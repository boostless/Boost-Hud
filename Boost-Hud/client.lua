

ESX = nil
local food, water,drunk ,  cash = 0
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local toghud = true

RegisterCommand('hud', function(source, args, rawCommand)

    if toghud then 
        toghud = false
    else
        toghud = true
    end

end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
    else
        toghud = false
    end

end)

RegisterNetEvent("Boost-Hud:onTick") 
AddEventHandler("Boost-Hud:onTick", function(Status)
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        hunger= status.val / 10000  
    end)
    
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)   
        thirst = status.val / 10000  
    end)
end)

local lungs = 0.0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(150)
        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local playerTalking = NetworkIsPlayerTalking(PlayerId())

        if IsEntityInWater(player) then
            lungs =  GetPlayerUnderwaterTimeRemaining(PlayerId()) * 2.5
        else
            lungs = GetPlayerSprintTimeRemaining(PlayerId()) * 10
        end

        SendNUIMessage({
            action = 'updateStatusHud',
            pauseMenu = IsPauseMenuActive(),
            show = toghud,
            health = health,
            armour = armor,
            oxygen = lungs,
            hunger = hunger,
	        thirst = thirst,
			voice = playerTalking
        })
    end
end)