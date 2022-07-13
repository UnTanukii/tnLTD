ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("tnLTD:buyItem")
AddEventHandler("tnLTD:buyItem", function(item, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xMoney = xPlayer.getMoney()
    if xMoney < price then
        TriggerClientEvent('esx:showAdvancedNotification', src, Notification.Name, "~r~Erreur", "Vous n'avez pas assez d'argent.", Notification.Char, 0)
    else 
        TriggerClientEvent('esx:showAdvancedNotification', src, Notification.Name, "~g~Succès", "Achat effectué !", Notification.Char, 0)
        xPlayer.addInventoryItem(item, 1)
        xPlayer.removeMoney(price)
    end

end)