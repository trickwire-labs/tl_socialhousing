IsPedModelChecked = false
local pedObject = Config.SellerPed
local debug = Config.Debug
local ipls = Config.Ipls

function SetPlayerHouseInDB(playerId, house)
    ---@diagnostic disable-next-line: undefined-field
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if not xPlayer then return end
    return MySQL.update.await('UPDATE `users` SET `social_house` = ? WHERE `identifier` = ? LIMIT 1',
        { house, xPlayer.getIdentifier() })
end

function GetPlayerHouseFromDB(playerId)
    ---@diagnostic disable-next-line: undefined-field
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if not xPlayer then return end
    return MySQL.scalar.await('SELECT `social_house` FROM `users` WHERE `identifier` = ? LIMIT 1',
        { xPlayer.getIdentifier() })
end

function SetClientsideHouse(playerId)
    local playerHouse = GetPlayerHouseFromDB(playerId)

    if debug then
        if not playerHouse or playerHouse == '' then
            lib.print.debug(string.format(Lang.playerNoHouseDBDebug, playerId))
            playerHouse = ''
        end
        lib.print.debug(string.format(Lang.fetchingUpdatingCLDebug, playerId, playerHouse or Lang.nonExisting))
    end

    local success = lib.callback.await(ResourceName .. ':setHouse', playerId, playerHouse)
    if not success then
        if debug then lib.print.error(string.format(Lang.fetchingUpdatingCLFail, playerId,
                playerHouse or Lang.nonExisting)) end
        return
    else
        if debug then lib.print.debug(string.format(Lang.fetchingUpdatingCLSuccess, playerId,
                playerHouse or Lang.nonExisting)) end
    end
end

function RegisterIplStashes()
    if debug then
        lib.print.debug(Lang.registeringStashesDebug)
    end
    local stashes = {}
    for iplKey, iplData in pairs(ipls) do
        if debug then
            lib.print.debug(string.format(Lang.registeringStashDebug, iplKey))
        end
        local stash = {
            id = iplKey .. ' stash',
            label = Lang.stashLabel,
            slots = Config.StashSlots,
            weight = Config.StashWeight,
            owner = 'char1:license',
            coords = iplData.stashCoords,
        }
        table.insert(stashes, stash)
        if debug then
            lib.print.debug(Lang.stashTable)
            lib.print.debug(stash)
        end
        Inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner, false, stash.coords)
        if debug then
            lib.print.debug(string.format(Lang.registeringStashSuccess, iplKey))
        end
    end
    if debug then
        lib.print.debug(string.format(Lang.registeringStashesSuccess, #stashes))
        lib.print.debug(Lang.registeredStashesDebug)
        lib.print.debug(json.encode(stashes, { indent = true }))
        lib.print.debug('--------------------------------------------')
    end
end

function RunPedModelCheck(playerId)
    if not pedObject then
        lib.print.error(Lang.pedObjectNotFound)
        return
    else
        if debug then lib.print.debug(Lang.pedObjectFound .. pedObject.model) end
    end
    local isPedModelCorrect = lib.callback.await(ResourceName .. ':checkPedModel', playerId)
    if not isPedModelCorrect or not pedObject.position or not pedObject.model or not pedObject.distance or not pedObject.blip then
        lib.print.error(Lang.invalidePedData)
        return
    else
        if debug then lib.print.debug(Lang.pedObjectValidSuccess) end
    end
    IsPedModelChecked = true
end

function RunConfigChecks()
    if debug then lib.print.debug(Lang.configCheckDebug) end

    if not Config.Houses or TableLength(Config.Houses) < 1 then
        lib.print.error(Lang.housesNotFound)
        return
    else
        if debug then lib.print.debug(string.format(Lang.housesFound, TableLength(Config.Houses))) end
    end

    for houseKey, houseData in pairs(Config.Houses) do
        if not (string.len(houseKey) >= 1 and string.len(houseKey) <= 256) then
            lib.print.error(string.format(Lang.invalidHouseKey, houseKey))
            return
        else
            if debug then lib.print.debug(string.format(Lang.validHouseKey, houseKey)) end
        end
        if not houseData.label or not houseData.desc or not houseData.position or not houseData.blip or not houseData.iplType then
            lib.print.error(string.format(Lang.invalidHouseData, houseKey))
            return
        else
            if debug then lib.print.debug(string.format(Lang.validHouseData, houseKey)) end
        end
    end

    if not Config.Ipls or TableLength(Config.Ipls) < 1 then
        lib.print.error(Lang.noIplsFound)
        return
    else
        if debug then lib.print.debug(string.format(Lang.foundIplsDebug, TableLength(Config.Ipls))) end
    end
    for iplKey, iplData in pairs(Config.Ipls) do
        if not (string.len(iplKey) >= 1 and string.len(iplKey) <= 256) then
            lib.print.error(string.format(Lang.invalidIplKey, iplKey))
            return
        else
            if debug then lib.print.debug(string.format(Lang.validIplKey, iplKey)) end
        end
        if not iplData.exitCoords or not iplData.stashCoords or not iplData.wardrobeCoords then
            lib.print.error(string.format(Lang.invalidIplData, iplKey))
            return
        else
            if debug then lib.print.debug(string.format(Lang.validIplData, iplKey)) end
        end
    end

    if not Config.InteractionMethod == 'textui' and not Config.InteractionMethod == 'target' then
        lib.print.error(Lang.invalidInteractionMethod)
        return
    else
        if debug then lib.print.debug(string.format(Lang.validInteractionMethod, Config.InteractionMethod)) end
    end

    --Todo: add illenium-appearance support. Please someone PR this I can't be bothered.
    if not Config.Appearance == 'fivem-appearance' then
        lib.print.error(Lang.invalidAppearance)
        return
    else
        if debug then lib.print.debug(string.format(Lang.validAppearance, Config.Appearance)) end
    end

    local players = GetPlayers()
    if players[1] then
        RunPedModelCheck(players[1])
    else
        if debug then lib.print.debug(Lang.skipModelCheck) end
        IsPedModelChecked = false
    end


    if debug then
        lib.print.debug(Lang.doneCheckingConfig)
        lib.print.debug('--------------------------------------------')
    end
    return true
end

function RunPlayerChecks()
    if debug then
        lib.print.debug(Lang.checkingPlayersHouses)
    end

    local players = GetPlayers()
    if not players or #players == 0 then
        if debug then
            lib.print.debug(Lang.skipHouseSetting)
        end
        goto skipFetch
    else
        if debug then
            lib.print.debug(string.format(Lang.houseSettingForPlayersDebug, #players))
            lib.print.debug('--------------------------------------------')
        end
    end

    for _, playerId in ipairs(players) do
        SetClientsideHouse(playerId)
    end

    ::skipFetch::
    if debug then
        lib.print.debug(Lang.doneCheckingPlayersHouses)
        lib.print.debug('--------------------------------------------')
    end
    return true
end
