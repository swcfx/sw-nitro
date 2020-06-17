-- function byte2bin(n)
-- local t, d = {}, 0
  -- d = math.log(n)/math.log(2) -- binary logarithm
  -- for i=math.floor(d+1),0,-1 do
    -- t[#t+1] = math.floor(n / 2^i)
    -- n = n % 2^i
  -- end
  -- return table.concat(t)
-- end

function IsVehicleElectric(vehicle)
  local maxFuelLevel = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fPetrolTankVolume')
  return not (maxFuelLevel > 0.0)
  
  -- local flag = GetVehicleHandlingInt(vehicle, 'CHandlingData', 'strHandlingFlags')
  -- return byte2bin(flag) / 10^3 == false
end
