ResourceName = GetCurrentResourceName()

Inventory = exports.ox_inventory

Target = exports.ox_target

Lang = Locale[Config.Locale]

function TableLength(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

function ShowNotification(...) (IsDuplicityVersion() and TriggerClientEvent or TriggerEvent) (ResourceName .. ':notify', ...) end