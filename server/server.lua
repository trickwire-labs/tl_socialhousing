local debug = Config.Debug
local addItemResponses = {
    ['invalid_item'] = Lang.invalidItem,
    ['invalid_inventory'] = Lang.invalidInventory,
    ['inventory_full'] = Lang.inventoryFull
}

lib.callback.register(ResourceName..':getDBHouse', function()
    return GetPlayerHouseFromDB(source)
end)

lib.callback.register(ResourceName..':setDBHouse', function(source, house)
    local playerPos = GetEntityCoords(GetPlayerPed(source))
	local targetPos = Config.SellerPed.position
    local distance = #(playerPos - targetPos)
    if distance > Config.InteractionDistance + 3 then --Accounts for some lag
        lib.print.warn(string.format(Lang.cheatSetHouse, source))
        return
    end
    return SetPlayerHouseInDB(source, house)
end)

lib.callback.register(ResourceName..':buyKey', function()
    local playerPos = GetEntityCoords(GetPlayerPed(source))
	local targetPos = Config.SellerPed.position
    local distance = #(playerPos - targetPos)
    if distance > Config.InteractionDistance + 3 then
        lib.print.warn(string.format(Lang.cheatBuyKey, source))
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    local accounts = xPlayer.getAccounts()
    local accountMoney
    for _, data in ipairs(accounts) do
        if data.name == Config.PaymentMethod then accountMoney = data.money end
    end

    if not accounts or not accountMoney then
        ShowNotification(source, Lang.notificationTitle, Lang.cantLoadMoney, 'error', 4000)
        return
    end
    if accountMoney >= Config.HouseKeyPrice then
        if Inventory:CanCarryItem(source, Config.KeyItem, 1) then
            local success, response = Inventory:AddItem(source, Config.KeyItem, 1)
            if not success then
                ShowNotification(source, Lang.notificationTitle, Lang.couldntBuyKey..addItemResponses[response], 'error', 4000)
                return
            else
                xPlayer.removeAccountMoney(Config.PaymentMethod, Config.HouseKeyPrice)
                return true
            end
        else
            ShowNotification(source, Lang.notificationTitle, Lang.couldntBuyKey..Lang.inventoryWeightLimit, 'error', 4000)
            return
        end
    else
        ShowNotification(source, Lang.notificationTitle, Lang.couldntBuyKey..Lang.notEnoughMoney, 'error', 4000)
        return
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= ResourceName then return end
    IsPedModelChecked = false
    Wait(1000)
    if debug then
        lib.print.debug('--------------------------------------------')
        lib.print.debug(string.format(Lang.startingResourceDebug, ResourceName))
        lib.print.debug('--------------------------------------------')
        lib.print.debug(Lang.runningChecks)
        lib.print.debug('--------------------------------------------')
    end
    if not RunConfigChecks() then return end
    if not RunPlayerChecks() then return end
    RegisterIplStashes()

    if debug then
        lib.print.debug(string.format(Lang.startingResourceSuccess, ResourceName))
        lib.print.debug('--------------------------------------------')
    end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    SetPlayerRoutingBucket(playerId, GetResourceKvpInt(ResourceName..':'..ESX.GetPlayerFromId(playerId).getIdentifier()..':routingBucket') or 0)
    if not IsPedModelChecked then
        if debug then
            lib.print.debug('------------------------------------')
            lib.print.debug(string.format(Lang.playerConnectedPedDebug, playerId))
        end
        RunPedModelCheck(playerId)
    end
    if debug then lib.print.debug(string.format(Lang.playerConnectedDebug, playerId)) end

    if not GetPlayerHouseFromDB(playerId) then
        if debug then
            lib.print.debug()
            lib.print.debug('------------------------------------')
        end
        return
    end

    SetClientsideHouse(playerId)
end)

RegisterNetEvent(ResourceName..':routingEnter', function()
    SetResourceKvpInt(ResourceName..':'..ESX.GetPlayerFromId(source).getIdentifier()..':routingBucket', source)
    SetPlayerRoutingBucket(source, source)
end)

RegisterNetEvent(ResourceName..':routingExit', function()
    SetResourceKvpInt(ResourceName..':'..ESX.GetPlayerFromId(source).getIdentifier()..':routingBucket', 0)
    SetPlayerRoutingBucket(source, 0)
end)

RegisterNetEvent(ResourceName..':errorPrint', function(errorText)
    lib.print.error(errorText)
end)

RegisterNetEvent(ResourceName..':debugPrint', function(debugText)
    lib.print.debug(debugText)
end)