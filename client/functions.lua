local Config                    = Config
local debug                     = Config.Debug
local houseBlip                 = nil
local interactionMethod         = Config.InteractionMethod
local interactionSize           = vec3(Config.InteractionSize, Config.InteractionSize, Config.InteractionSize)
local interactionDistance       = Config.InteractionDistance
local targets                   = {}
local points                    = {}

--Implement your own notification system or use exports/events from your current notification system.
RegisterNetEvent(ResourceName .. ':notify', function(title, description, type, duration)
    --Defaults to ox lib if Config.useCustomNotification is set to false.
    if not Config.CustomNotification then
        lib.notify({
            title       = title or 'Test',
            description = description or 'Test',
            type        = type or 'info',
            duration    = duration or 3000,
        })
    end
end)

--Implement your own textui system or use exports/events from your current textui system.
local function showTextUI(text)
    --Defaults to ox lib if Config.useCustomTextUI is set to false.
    if not Config.CustomTextUI then
        lib.showTextUI(text)
    end
end
local function hideTextUI()
    --Defaults to ox lib if Config.useCustomTextUI is set to false.
    if not Config.CustomTextUI then
        lib.hideTextUI()
    end
end
local function isTextUIOpen()
    --Defaults to ox lib if Config.useCustomTextUI is set to false.
    if not Config.CustomTextUI then
        lib.isTextUIOpen()
    end
end

local function hasKeyCheck()
    return Inventory:GetItemCount(Config.KeyItem) > 0
end

--Seller functions
local function updateSellerInteraction(ped)
    local targetPed = ped
    local targetPedCoords = Config.SellerPed.position

    if targets.sellerTarget then
        Target:removeLocalEntity(ped, 'speakwithseller')
        targets.sellerTarget = nil
    elseif points.sellerPoint then points.sellerPoint:remove() end

    if interactionMethod == 'target' then
        local targetPedOptions = {
            {
                label = Lang.speakWithSellerTarget,
                icon = 'fa-solid fa-comment',
                name = 'speakwithseller',
                distance = interactionDistance,
                canInteract = function ()
                        return not IsEntityDead(cache.ped)
                end,
                onSelect = function ()
                    if lib.progressBar({
                        duration = 1500,
                        label = Lang.progBarSpeakWithSeller,
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                            mouse = false,
                            sprint = true
                        },
                    }) then
                        lib.showContext('main_seller_menu')
                    end
                end
            }
        }
        Target:addLocalEntity(targetPed, targetPedOptions)
        targets.sellerTarget = true
    else
        points.sellerPoint = lib.points.new({
            coords = vec3(targetPedCoords.x, targetPedCoords.y, targetPedCoords.z),
            distance = Config.InteractionDistance
        })

        function points.sellerPoint:nearby()
            if not isTextUIOpen() then
                showTextUI(Lang.openWardrobe)
            end
            if IsControlJustPressed(0, 38) then
                lib.hideTextUI()
                if lib.progressBar({
                    duration = 1500,
                    label = Lang.progBarSpeakWithSeller,
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        move = true,
                        car = true,
                        combat = true,
                        mouse = false,
                        sprint = true
                    },
                }) then
                    lib.showContext('main_seller_menu')
                    hideTextUI()
                else
                    ShowNotification(Lang.notificationTitle, Lang.progBarStopSWS, 'info', 3000)
                end
            end
        end
    end
    return true
end

local function removeSellerInteraction(ped)
    if targets.sellerTarget then Target:removeLocalEntity(ped, 'speakwithseller') targets.sellerTarget = false return true
    elseif points.sellerPoint then points.sellerPoint:remove() return true
    else return false end
end

function CreateSellerPed()
    local ped
    local pedObject = Config.SellerPed
    points.sellerPedPoint = lib.points.new({
        coords = pedObject.position,
        distance = pedObject.distance
    })
    function points.sellerPedPoint:onEnter()
        if debug then
            lib.print.debug('---------------------------------------------------------------------------')
            lib.print.debug(Lang.createSellerPedDebug)
        end
        lib.requestModel(pedObject.model)
        ped = CreatePed(4, pedObject.model, pedObject.position, false, true)
        if ped then
            if debug then lib.print.debug(Lang.createSellerPedSuccess) end
            SetPedDefaultComponentVariation(ped)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetPedFleeAttributes(ped, 0, false)
            SetModelAsNoLongerNeeded(pedObject.model)

            if debug then lib.print.debug(Lang.createSellerPedIntDebug) end
            updateSellerInteraction(ped)
            if debug then
                lib.print.debug(Lang.createSellerPedIntSuccess)
                lib.print.debug('---------------------------------------------------------------------------')
            end
        else
            if debug then
                lib.print.error(Lang.createSellerPedFail)
                lib.print.debug('---------------------------------------------------------------------------')
                end
            end
        SetModelAsNoLongerNeeded(pedObject.model)
    end
    function points.sellerPedPoint:onExit()
        if debug then
            lib.print.debug('---------------------------------------------------------------------------')
            lib.print.debug(Lang.removeSellerPedDebug)
        end

        if ped then
            DeleteEntity(ped)
            if debug then
                lib.print.debug(Lang.removeSellerPedIntSuccess)
                lib.print.debug(Lang.removeSellerPedIntDebug)
            end
            local success = removeSellerInteraction(ped)
            if debug then
                if success then
                    lib.print.debug(Lang.removeSellerPedSuccess)
                    lib.print.debug('---------------------------------------------------------------------------')
                else
                    lib.print.error(Lang.removeSellerPedIntFail)
                    lib.print.debug('---------------------------------------------------------------------------')
                end
            end
        else
            if debug then
                lib.print.error(Lang.removeSellerPedFail)
                lib.print.debug('---------------------------------------------------------------------------')
            end
        end
    end
end

--House functions
local function openWardrobe()
    --Todo: add illenium-appearance support. Please someone PR this I can't be bothered.
    if Config.Appearance == 'fivem-appearance' then exports['fivem-appearance']:openWardrobe() end
end

local function openStash()
    local stashId = Config.Houses[PlayerHouse].iplType..' stash'
    Inventory:openInventory('stash', {id=stashId, owner=ESX.PlayerData.identifier})
end

local function exitHouse()
    local house = Config.Houses[PlayerHouse]
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do Wait(0) end
    TriggerServerEvent(ResourceName..':routingExit')
    if isTextUIOpen() then hideTextUI() end
    SetEntityCoords(cache.ped, house.position)
    DoScreenFadeIn(800)
    Wait(800)
    ShowNotification(Lang.notificationTitle, Lang.leftHouse, 'success', 3000)
end

local function enterHouse()
    local ipl = Config.Ipls[Config.Houses[PlayerHouse].iplType]
    if Config.KeyItem then
        if not hasKeyCheck() then
            ShowNotification(Lang.notificationTitle, Lang.dontHaveKey, 'error', 3000)
            return
        end
    end

    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do Wait(0) end
    TriggerServerEvent(ResourceName..':routingEnter')
    if isTextUIOpen() then hideTextUI() end
    RequestCollisionAtCoord(ipl.exitCoords)
    SetEntityCoords(cache.ped, ipl.exitCoords)
    DoScreenFadeIn(800)
    Wait(800)
    ShowNotification(Lang.notificationTitle, Lang.enteredHouse, 'success', 3000)
end

local function updateHouseInteractions()
    local ipl = Config.Ipls[Config.Houses[PlayerHouse].iplType]

    if targets.wardrobeTarget then
        Target:removeZone(targets.wardrobeTarget)
        Target:removeZone(targets.stashTarget)
        Target:removeZone(targets.houseExitTarget)
        targets.wardrobeTarget = nil
        targets.stashTarget = nil
        targets.houseExitTarget = nil
    elseif points.wardrobePoint then
        points.wardrobePoint:remove()
        points.stashPoint:remove()
        points.houseExitPoint:remove()
    end


    if interactionMethod == 'target' then
        --Wardrobe target
        local wardrobeTargetOptions = {
            coords      = ipl.wardrobeCoords,
            size        = interactionSize,
            options     = {
                {
                    label = Lang.openWardrobeTarget,
                    name = 'housewardrobe',
                    icon = 'fa-solid fa-shirt',
                    distance = interactionDistance,
                    canInteract = function ()
                        return not IsEntityDead(cache.ped)
                    end,
                    onSelect = openWardrobe
                }
            }

        }
        --Stash target
        local stashTargetOptions = {
            coords      = ipl.stashCoords,
            size        = interactionSize,
            options     = {
                {
                    label = Lang.openStashTarget,
                    name = 'housestash',
                    icon = 'fa-solid fa-shirt',
                    distance = interactionDistance,
                    canInteract = function ()
                        return not IsEntityDead(cache.ped)
                    end,
                    onSelect = openStash
                }
            }

        }
        --Exit target
        local houseExitTargetOptions = {
            coords      = ipl.exitCoords,
            size        = interactionSize,
            options     = {
                {
                    label = Lang.exitHouseTarget,
                    name = 'houseexit',
                    icon = 'fa-solid fa-box-open',
                    distance = interactionDistance,
                    canInteract = function ()
                        return not IsEntityDead(cache.ped)
                    end,
                    onSelect = exitHouse
                }
            }

        }
        targets.wardrobeTarget  = Target:addBoxZone(wardrobeTargetOptions)
        targets.stashTarget     = Target:addBoxZone(stashTargetOptions)
        targets.houseExitTarget = Target:addBoxZone(houseExitTargetOptions)
    else
        local wardrobeMarker = lib.marker.new(Config.Marker)
        local stashMarker = lib.marker.new(Config.Marker)
        local houseExitMarker = lib.marker.new(Config.Marker)
        wardrobeMarker.coords = ipl.wardrobeCoords
        wardrobeMarker.coords = vector3(wardrobeMarker.coords.x, wardrobeMarker.coords.y, wardrobeMarker.coords.z - 0.975)
        stashMarker.coords = ipl.stashCoords
        stashMarker.coords = vector3(stashMarker.coords.x, stashMarker.coords.y, stashMarker.coords.z - 0.975)
        houseExitMarker.coords = ipl.exitCoords
        houseExitMarker.coords = vector3(houseExitMarker.coords.x, houseExitMarker.coords.y, houseExitMarker.coords.z - 0.975)

        --Wardrobe point
        points.wardrobePoint = lib.points.new({
            coords = ipl.wardrobeCoords,
            distance = 10
        })
        function points.wardrobePoint:nearby()
            wardrobeMarker:draw()

            if self.currentDistance < Config.InteractionDistance then
                if not isTextUIOpen() then
                  showTextUI(Lang.openWardrobe)
                end

                if IsControlJustPressed(0, 38) then
                  openWardrobe()
                end
            else
              local isOpen, currentText = isTextUIOpen()
                if isOpen and currentText == Lang.openWardrobe then
                    hideTextUI()
                end
            end
        end
        --Stash point
        points.stashPoint = lib.points.new({
            coords = ipl.stashCoords,
            distance = 10
        })
        function points.stashPoint:nearby()
            stashMarker:draw()

            if self.currentDistance < Config.InteractionDistance then
                if not isTextUIOpen() then
                  showTextUI(Lang.openStash)
                end

                if IsControlJustPressed(0, 38) then
                  openStash()
                  hideTextUI()
                end
            else
              local isOpen, currentText = isTextUIOpen()
                if isOpen and currentText == Lang.openStash then
                    hideTextUI()
                end
            end
        end
        --Exit point
        points.houseExitPoint = lib.points.new({
            coords = ipl.exitCoords,
            distance = 10
        })
        function points.houseExitPoint:nearby()
            houseExitMarker:draw()

            if self.currentDistance < Config.InteractionDistance then
                if not isTextUIOpen() then
                  showTextUI(Lang.exitHouse)
                end

                if IsControlJustPressed(0, 38) then
                  exitHouse()
                end
            else
              local isOpen, currentText = isTextUIOpen()
                if isOpen and currentText == Lang.exitHouse then
                    hideTextUI()
                end
            end
        end
    end
end

local function updateHouseEntrance()
    local house = Config.Houses[PlayerHouse]
    if targets.houseEntranceTarget then
        Target:removeZone(targets.houseEntranceTarget)
        targets.houseEntranceTarget = nil
    elseif points.houseEntrancePoint then points.houseEntrancePoint:remove() end

    if interactionMethod == 'target' then
        local houseEntranceTargetOptions = {
            coords      = house.position,
            size        = interactionSize,
            options     = {
                {
                    label = Lang.enterHouseTarget,
                    name = 'housentrance'..PlayerHouse,
                    icon = 'fa-solid fa-door-open',
                    distance = interactionDistance,
                    canInteract = function ()
                        return not IsEntityDead(cache.ped)
                    end,
                    onSelect = enterHouse
                }
            }

        }
        targets.houseEntranceTarget = Target:addBoxZone(houseEntranceTargetOptions)
    else
        local houseEntranceMarker = lib.marker.new(Config.Marker)
        houseEntranceMarker.coords = house.position
        houseEntranceMarker.coords = vector3(houseEntranceMarker.coords.x, houseEntranceMarker.coords.y, houseEntranceMarker.coords.z - 0.975)

        points.houseEntrancePoint = lib.points.new({
            coords = house.position,
            distance = 30
        })

        function points.houseEntrancePoint:nearby()
            houseEntranceMarker:draw()

            if self.currentDistance < Config.InteractionDistance then
                if not isTextUIOpen() then
                  showTextUI(Lang.enterHouse)
                end

                if IsControlJustPressed(0, 38) then
                  enterHouse(house.iplType)
                end
            else
              local isOpen, currentText = isTextUIOpen()
                if isOpen and currentText == Lang.enterHouse then
                    hideTextUI()
                end
            end
        end
    end
end

function UpdatePhysicalHouse()
    if debug then
        TriggerServerEvent(ResourceName..':debugPrint', string.format(Lang.updatePhysHouseDebug, cache.serverId))
    end
    if houseBlip then RemoveBlip(houseBlip) end
    if PlayerHouse == '' then
        if debug then TriggerServerEvent(ResourceName..':debugPrint', string.format(Lang.skipUpdatePhysHouseDebug, cache.serverId)) end
        return
    end
    local house = Config.Houses[PlayerHouse]
    if house.blip.active then
        houseBlip = AddBlipForCoord(house.position.x, house.position.y, house.position.z)
        SetBlipSprite (houseBlip, house.blip.sprite)
        SetBlipDisplay(houseBlip, 4)
        SetBlipScale  (houseBlip, house.blip.size)
        SetBlipColour (houseBlip, house.blip.color)
        SetBlipAsShortRange(houseBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(house.blip.name)
        EndTextCommandSetBlipName(houseBlip)
    end
    updateHouseEntrance()
    updateHouseInteractions()

    if debug then
        TriggerServerEvent(ResourceName..':debugPrint', string.format(Lang.updatePhysHouseSuccess, cache.serverId))
        TriggerServerEvent(ResourceName..':debugPrint','---------------------------------------------------------------------------')
    end
end