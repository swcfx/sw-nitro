
function IsVehicleElectric(vehicle)
  local maxFuelLevel = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fPetrolTankVolume')
  return not (maxFuelLevel > 0.0)
end
