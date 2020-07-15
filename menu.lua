Citizen.CreateThread(function()
    WarMenu.CreateMenu('general', "General Shop")
    WarMenu.SetSubTitle('general', 'Buy or Sell')
    WarMenu.CreateSubMenu('buy', 'general', 'Buy items')
    WarMenu.CreateSubMenu('sell', 'general', 'Sell items')

    while true do
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('general') then
            if WarMenu.MenuButton('Buy Items', 'buy') then
            end
            if WarMenu.MenuButton('Sell Items', 'sell') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('buy') then
            for k, v in ipairs(items) do
                if WarMenu.Button('Buy ' .. items[k][1] .. ' ~pa~' .. items[k][2]) then
                    TriggerServerEvent("buy", items[k][1], items[k][2])  
                    DisplayHelp('You have bought 1 ' .. items[k][1] .. ' if you had enough money!')
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('sell') then
            for k, v in ipairs(items) do
                if WarMenu.Button('Sell ' .. items[k][1] .. ' ~pa~' .. items[k][3]) then
                    TriggerServerEvent("sell", items[k][1], items[k][3])  
                    DisplayHelp('You have sold 1 ' .. items[k][1] .. ' if you had enough of that item on you!')
                end
            end
            WarMenu.Display()
        elseif (Vdist(coords.x, coords.y, coords.z, -322.25, 803.97, 116.95) < 2.0) then
               TriggerEvent("enter:general")
               if whenKeyJustPressed(keys["E"]) then
                WarMenu.OpenMenu('general')
               end
        elseif (Vdist(coords.x, coords.y, coords.z, -785.2388, -1323.848, 43.88416) < 2.0) then --f6
            TriggerEvent("enter:general")
            if whenKeyJustPressed(keys["E"]) then
            WarMenu.OpenMenu('general')
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('buy:general')
AddEventHandler('buy:general', function()
    DisplayHelp('You have been buy you stock.')
end)

RegisterNetEvent('enter:general')
  AddEventHandler('enter:general', function()
    SetTextScale(0.5, 0.5)
    local msg = "Press [E] to see the General Shop."
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)
