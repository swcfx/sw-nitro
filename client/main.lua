local INPUT_CHARACTER_WHEEL = 19
local INPUT_VEH_ACCELERATE = 71

local function NitroLoop(lastVehicle)
  local player = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(player)
  local driver = GetPedInVehicleSeat(vehicle, -1)

  if lastVehicle ~= 0 and lastVehicle ~= vehicle then
    SetVehicleNitroBoostEnabled(lastVehicle, false)
    SetVehicleNitroPurgeEnabled(lastVehicle, false)
    TriggerServerEvent('nitro:__sync', false, false, true)
  end

  if vehicle == 0 or driver ~= player then
    return 0
  end

  local model = GetEntityModel(vehicle)

  if not IsThisModelACar(model) then
    return 0
  end

  local isEnabled = IsControlPressed(0, INPUT_CHARACTER_WHEEL)
  local isDriving = IsControlPressed(0, INPUT_VEH_ACCELERATE)
  local isBoosting = IsVehicleNitroBoostEnabled(vehicle)
  local isPurging = IsVehicleNitroPurgeEnabled(vehicle)

  if isEnabled then
    if isDriving then
      if not isBoosting then
        SetVehicleNitroBoostEnabled(vehicle, true)
        SetVehicleNitroPurgeEnabled(vehicle, false)
        TriggerServerEvent('nitro:__sync', true, false, false)
      end
    else
      if not isPurging then
        SetVehicleNitroBoostEnabled(vehicle, false)
        SetVehicleNitroPurgeEnabled(vehicle, true)
        TriggerServerEvent('nitro:__sync', false, true, false)
      end
    end
  elseif isBoosting or isPurging then
    SetVehicleNitroBoostEnabled(vehicle, false)
    SetVehicleNitroPurgeEnabled(vehicle, false)
    TriggerServerEvent('nitro:__sync', false, false, false)
  end

  return vehicle
end

Citizen.CreateThread(function ()
  local lastVehicle = 0

  while true do
    Citizen.Wait(0)
    lastVehicle = NitroLoop(lastVehicle)
  end
end)

RegisterNetEvent('nitro:__update')
AddEventHandler('nitro:__update', function (playerServerId, boostEnabled, purgeEnabled, lastVehicle)
  local player = GetPlayerPed(GetPlayerFromServerId(playerServerId))
  local vehicle = GetVehiclePedIsIn(player, lastVehicle)
  local driver = GetPedInVehicleSeat(vehicle, -1)

  SetVehicleNitroBoostEnabled(vehicle, boostEnabled)
  SetVehicleNitroPurgeEnabled(vehicle, purgeEnabled)
end)
