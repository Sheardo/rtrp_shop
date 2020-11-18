data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent('sell')
AddEventHandler('sell', function(player_item, price)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local count = data.checkItem(_source, player_item)
        local ItemData = data.getItem(_source, player_item)
        if count == nil then
            TriggerClientEvent("redemrp_notification:start", _source, 'You dont have enough ' .. player_item, 5)
        end
        if count >= 1 then
            print(count)
            ItemData.RemoveItem(1)
            user.addMoney(price)
            DisplayHelp('You have sold 1 ' .. player_item .. '.')
        else
            TriggerClientEvent("redemrp_notification:start", _source, 'You dont have enough ' .. player_item, 5)
        end   
    end)
end)

RegisterServerEvent('buy')
AddEventHandler('buy', function(player_item, price)
    local _item = player_item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local ItemData = data.getItem(_source, player_item)
        if user.getMoney() >= price then
                user.removeMoney(price)
                print(count)
                ItemData.AddItem(1)
                TriggerClientEvent('buy:general', _source)
        else
            TriggerClientEvent('Message:cancel', source)
        end
    end)
end)
