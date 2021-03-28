local vehicles = {}

function SetNitroBoostScreenEffectsEnabled(enabled)
  if enabled then
    StopScreenEffect('RaceTurbo')
    StartScreenEffect('RaceTurbo', 0, false)
    SetTimecycleModifier('rply_motionblur')
    ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
  else
    StopGameplayCamShaking(true)
    SetTransitionTimecycleModifier('default', 0.35)
  end
end

function IsVehicleNitroBoostEnabled(vehicle)
  return vehicles[vehicle] == true
end

function SetVehicleNitroBoostEnabled(vehicle, enabled)
  if IsVehicleNitroBoostEnabled(vehicle) == enabled then
    return
  end

  if IsPedInVehicle(PlayerPedId(), vehicle) or not enabled then
    SetNitroBoostScreenEffectsEnabled(enabled)
  end

  SetVehicleBoostActive(vehicle, enabled)
  vehicles[vehicle] = enabled or nil
end

Citizen.CreateThread(function ()
  local function BackfireLoop()
    -- TODO: Only do this for nearby vehicles.
      for vehicle in pairs(vehicles) do
        --CreateVehicleExhaustBackfire(vehicle, 1.25)
        SetVehicleNitroEnabled(vehicle, true, 0.0, 0.0, 0.0, true)
      end
    end

    while true do
      Citizen.Wait(0)
      BackfireLoop()
    end
  end)

Citizen.CreateThread(function ()
  local function BoostLoop()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local enabled = IsVehicleNitroBoostEnabled(vehicle)

    if vehicle == 0 or driver ~= player or not enabled then
      return
    end

    -- TODO: Use better math. The effect of nitro is quite extreme for cars with
    -- custom handling, while slow cars have almost no effect from this at all.
    -- Also, maybe torque is not the correct setting to change.
    if not IsVehicleStopped(vehicle) then
      local vehicleModel = GetEntityModel(vehicle)
      local currentSpeed = GetEntitySpeed(vehicle)
      local maximumSpeed = GetVehicleModelMaxSpeed(vehicleModel)
      local multiplier = 2.0 * maximumSpeed / currentSpeed

      SetVehicleEngineTorqueMultiplier(vehicle, multiplier)
    end
  end

  while true do
    Citizen.Wait(0)
    BoostLoop()
  end
end)
