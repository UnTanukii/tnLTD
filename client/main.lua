ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end

ESX.PlayerData = ESX.GetPlayerData()
end)

print('^1By^7 ^4Tanukii#7115 - dsc.gg/rfs-store')

open = false
local mainMenu = RageUI.CreateMenu("tnLTD", "Interaction")
local foodMenu = RageUI.CreateSubMenu(mainMenu, "tnLTD", "Nourriture")
local drinkMenu = RageUI.CreateSubMenu(mainMenu, "tnLTD", "Boissons")
local otherMenu = RageUI.CreateSubMenu(mainMenu, "tnLTD", "Autres")
mainMenu.Closed = function()
	open = false 
end

function OpenMenu()
	if open then 
		open = false 
		RageUI.Visible(mainMenu, false)
		return 
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		Citizen.CreateThread(function()
			while open do 
				RageUI.IsVisible(mainMenu, function()

                RageUI.Button("Nourriture", nil, {RightLabel = "→"}, true , {},foodMenu)
                RageUI.Button("Boissons", nil, {RightLabel = "→"}, true , {},drinkMenu)
                RageUI.Button("Autres", nil, {RightLabel = "→"}, true , {},otherMenu)

				end)
				RageUI.IsVisible(foodMenu, function()
                    for k,v in pairs(Items.food) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$~s~"}, true, {
                            onSelected = function()
                                TriggerServerEvent("tnLTD:buyItem", v.item, v.price)
                            end
                        })
                    end
					end)
                RageUI.IsVisible(drinkMenu, function()
                    for k,v in pairs(Items.drink) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$~s~"}, true, {
                            onSelected = function()
                                TriggerServerEvent("tnLTD:buyItem", v.item, v.price)
                            end
                        })
                    end
                    end)
                RageUI.IsVisible(otherMenu, function()
                    for k,v in pairs(Items.other) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$~s~"}, true, {
                            onSelected = function()
                                TriggerServerEvent("tnLTD:buyItem", v.item, v.price)
                            end
                        })
                    end
                    end)
				Wait(0)
			end
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        local waito = false
        for _, info in pairs(Blips) do
            local dist = Vdist2(GetEntityCoords(GetPlayerPed(-1)), info.x, info.y, info.z)
            if dist < 6 then
                waito = true 
			          
                if dist < 5 then 
                    Visual.Subtitle("Appuyez sur ~b~E~s~ pour ~p~acheter~s~.", 1)
                    if IsControlJustPressed(0, 51) then
                        RageUI.CloseAll()
                        OpenMenu()
                    end
                end
            end
        end
        if waito then
            Wait(0)
        else 
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    for _, info in pairs(Blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.sprite)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, info.scale)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
        Citizen.CreateThread(function()
            local hash = GetHashKey(Ped)
            while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(20)
            end
            ped = CreatePed("PED_TYPE_MALE", Ped, info.x, info.y, info.z, info.h, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
        end)
    end
end)
