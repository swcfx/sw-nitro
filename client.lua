local INPUT_CHARACTER_WHEEL = 19

-- TODO: Get actual exhaust positions and rotations. This is based on bone
-- positions, but custom exhausts can have different positions or rotations.
local function RenderVehicleExhaustBackfire(vehicle, scale)
  local exhaustNames = {
    "exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
    "exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
    "exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
    "exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
  }

  for _, exhaustName in ipairs(exhaustNames) do
    local boneIndex = GetEntityBoneIndexByName(vehicle, exhaustName)

    if boneIndex ~= -1 then
      local pos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
      local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)

      UseParticleFxAssetNextCall('core')
      StartParticleFxNonLoopedOnEntity_2('veh_backfire', vehicle, off.x, off.y, off.z, 0.0, 0.0, 0.0, scale, false, false, false)
    end
  end
end

Citizen.CreateThread(function ()
  local function NitroLoop()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player)
    local driver = GetPedInVehicleSeat(vehicle, -1)

    if vehicle == 0 or driver ~= player then
      return
    end

    if IsControlJustPressed(0, INPUT_CHARACTER_WHEEL) then
      StopScreenEffect('RaceTurbo')
      StartScreenEffect('RaceTurbo', 0, false)
      SetVehicleBoostActive(vehicle, true)
      ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
    elseif IsControlJustReleased(0, INPUT_CHARACTER_WHEEL) then
      SetVehicleBoostActive(vehicle, false)
      StopGameplayCamShaking(true)
    end

    if IsControlPressed(0, INPUT_CHARACTER_WHEEL) then
      RenderVehicleExhaustBackfire(vehicle, 1.25)

      -- TODO: Use better math. The effect of nitro is quite extreme for cars
      -- with custom handling, while slow cars have almost no effect from this
      -- at all. Also, maybe torque is not the correct setting to change.
      if not IsVehicleStopped(vehicle) then
        local vehicleModel = GetEntityModel(vehicle)
        local currentSpeed = GetEntitySpeed(vehicle)
        local maximumSpeed = GetVehicleModelMaxSpeed(vehicleModel)
        local multiplier = 2.0 * maximumSpeed / currentSpeed

        SetVehicleEngineTorqueMultiplier(vehicle, multiplier)
      end
    end
  end

  while true do
    Citizen.Wait(0)
    NitroLoop()
  end
end)
