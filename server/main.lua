RegisterNetEvent('nitro:__sync')
AddEventHandler('nitro:__sync', function (boostEnabled, purgeEnabled, lastVehicle)
  local source = source

  for _, player in ipairs(GetPlayers()) do
    if player ~= tostring(source) then
      TriggerClientEvent('nitro:__update', player, source, boostEnabled, purgeEnabled, lastVehicle)
    end
  end
end)
