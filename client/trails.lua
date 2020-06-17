-- synced by Xinerki :^)

local vehicles = {}
local particles = {}

function IsVehicleLightTrailEnabled(vehicle)
  return vehicles[vehicle] == true
end

function SetVehicleLightTrailEnabled(vehicle, enabled)
  if IsVehicleLightTrailEnabled(vehicle) == enabled then
    return
  end
  
  if enabled then
    local ptfxs = {}
    
    local leftTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_l"), 1.0)
    local rightTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_r"), 1.0)
    
    table.insert(ptfxs, leftTrail)
    table.insert(ptfxs, rightTrail)

    vehicles[vehicle] = true
    particles[vehicle] = ptfxs
  else
    if particles[vehicle] and #particles[vehicle] > 0 then
      for _, particleId in ipairs(particles[vehicle]) do
        StopVehicleLightTrail(particleId, 500)
      end
    end

    vehicles[vehicle] = nil
    particles[vehicle] = nil
  end
end
