local Config                = Config
local CreateThread          = CreateThread
local debug                 = Config.Debug
local houseSelectionOptions = {}
local paymentMethodString   = {
    ['bank'] = 'bank',
    ['money'] = 'cash',
    ['black_money'] = 'dirty cash'
}
PlayerHouse                 = ''


--Seller interaction context menu functions
-------------------------------------------
local function updateContext()
    if debug then
        TriggerServerEvent(ResourceName .. ':debugPrint',
            string.format(Lang.updateContextDebug, cache.serverId, PlayerHouse))
        TriggerServerEvent(ResourceName .. ':debugPrint', '------------------------------------------------------')
    end
    lib.registerContext({
        id = 'house_selection_menu',
        title = Lang.houseSelectionContextTitle,
        options = houseSelectionOptions,
        menu = 'main_seller_menu'
    })
end

local function updateOptions()
    if debug then
        TriggerServerEvent(ResourceName .. ':debugPrint',
            string.format(Lang.updateOptionsDebug, cache.serverId, PlayerHouse))
    end
    houseSelectionOptions = {}
    local isDisabled, icon
    local hasSelectedHouse = false
    for houseKey, houseData in pairs(Config.Houses) do
        if houseKey == PlayerHouse then
            isDisabled = true
            icon = 'square-check'
            hasSelectedHouse = true
        else
            isDisabled = false
            icon = 'house'
        end
        table.insert(houseSelectionOptions,
            {
                title       = houseData.label,
                description = houseData.desc,
                icon        = icon,
                disabled    = isDisabled,
                onSelect    = function()
                    local success = lib.callback.await(ResourceName .. ':setDBHouse', false, houseKey)
                    if not success then
                        ShowNotification(Lang.notificationTitle, Lang.houseChoosingError, 'error', 3000)
                        return
                    end
                    ShowNotification(Lang.notificationTitle, string.format(Lang.houseChoosingSuccess, houseData.label),
                        'success', 3000)
                    PlayerHouse = houseKey
                    updateOptions()
                    updateContext()
                    UpdatePhysicalHouse()
                end
            })
    end
    if debug then
        TriggerServerEvent(ResourceName .. ':debugPrint',
            string.format(Lang.houseUpdatingSuccessDebug, cache.serverId, PlayerHouse))
        TriggerServerEvent(ResourceName .. ':debugPrint', '------------------------------------------------------')
    end
    return hasSelectedHouse
end

lib.registerContext({
    id = 'main_seller_menu',
    title = Lang.houseSellerContextTitle,
    options = {
        {
            title = Lang.hscChooseTitle,
            description = Lang.hscChooseDesc,
            icon = 'house',
            menu = 'house_selection_menu',
        },
        {
            title = Lang.hscKeyTitle,
            description = Lang.hscKeyDesc,
            metadata = {
                { label = Lang.priceLabel,         value = Config.HouseKeyPrice },
                { label = Lang.paymentMethodLabel, value = paymentMethodString[Config.PaymentMethod] }
            },
            icon = 'key',
            onSelect = function()
                if lib.callback.await(ResourceName .. ':buyKey', false) then ShowNotification(Lang.notificationTitle,
                        Lang.keyPurchaseSuccess, 'success', 4000) end
            end
        }
    }
})



--Callbacks
-----------
lib.callback.register(ResourceName .. ':setHouse', function(newHouse)
    PlayerHouse = newHouse
    updateOptions()
    updateContext()
    UpdatePhysicalHouse()
    return true
end)

lib.callback.register(ResourceName .. ':checkPedModel', function()
    if not IsModelInCdimage(Config.SellerPed.model) then return end
    return true
end)



--Seller creation thread
------------------------
CreateThread(function()
    local ped = Config.SellerPed
    if ped.blip.active then
        local blip = AddBlipForCoord(ped.position.x, ped.position.y, ped.position.z)
        SetBlipSprite(blip, ped.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, ped.blip.size)
        SetBlipColour(blip, ped.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ped.blip.name)
        EndTextCommandSetBlipName(blip)
    end
    CreateSellerPed()
end)
