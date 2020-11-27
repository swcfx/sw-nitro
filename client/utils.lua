local ELECTRIC_VEHICLES = {
  [GetHashKey('AIRTUG')] = true,
  [GetHashKey('CYCLONE')] = true,
  [GetHashKey('CADDY')] = true,
  [GetHashKey('CADDY2')] = true,
  [GetHashKey('CADDY3')] = true,
  [GetHashKey('DILETTANTE')] = true,
  [GetHashKey('IMORGON')] = true,
  [GetHashKey('KHAMEL')] = true,
  [GetHashKey('NEON')] = true,
  [GetHashKey('RAIDEN')] = true,
  [GetHashKey('SURGE')] = true,
  [GetHashKey('VOLTIC')] = true,
  [GetHashKey('VOLTIC2')] = true,
  [GetHashKey('TEZERACT')] = true
}

-- TODO: Replace with `FLAG_IS_ELECTRIC` from vehicles.meta:
-- https://gtamods.com/wiki/Vehicles.meta
function IsVehicleElectric(vehicle)
  local model = GetEntityModel(vehicle)
  return ELECTRIC_VEHICLES[model] or false
end
