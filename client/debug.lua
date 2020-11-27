local DEBUG_INDEX = 0

function DEBUG_RESET()
  DEBUG_INDEX = 0
end

function DEBUG_LABEL(text)
  SetScriptGfxAlign(string.byte('L'), string.byte('B'))
  SetTextFont(0)
  SetTextProportional(1)
  SetTextScale(0.0, 0.3)
  SetTextColour(128, 128, 128, 255)
  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry('STRING')
  AddTextComponentString(text)
  DrawText(0.0, 0.075 - (0.025 * DEBUG_INDEX))
  ResetScriptGfxAlign()

  DEBUG_INDEX = DEBUG_INDEX + 1
end