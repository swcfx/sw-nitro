


-- Citizen.CreateThread(function()
--   local lastVehicle = 0

--   while true do
--     Citizen.Wait(0)
--     lastVehicle = ProcessNitro(lastVehicle)
--   end
-- end)

local nitro = false
local LAST_VEHICLE = 0

local function ProcessNitro()
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    ProcessNitro()
    DEBUG_RESET()
  end
end)

RegisterCommand('+nitro', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  -- SetVehicleNitroActive(vehicle, true)
  nitro = true
end, false)

RegisterCommand('-nitro', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  -- SetVehicleNitroActive(vehicle, false)
  nitro = false
end, false)

RegisterKeyMapping('+nitro', 'Enable nitro', 'PAD_DIGITALBUTTON', 'LLEFT_INDEX')
-- RegisterKeyMapping('+nitro', 'Enable nitro', 'KEYBOARD', 'LMENU')