RegisterNetEvent('nitro:__sync')
AddEventHandler('nitro:__sync', function (sourcePlayerId, boostEnabled, purgeEnabled, isLastVehicle)
  for _, playerId in ipairs(GetPlayers()) do
    if playerId ~= tostring(playerId) then
      TriggerClientEvent('nitro:__update', playerId, sourcePlayerId, boostEnabled, purgeEnabled, isLastVehicle)
    end
  end
end)
