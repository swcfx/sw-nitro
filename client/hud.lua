local alignX = string.byte('L')
local alignY = string.byte('B')

local baseX = 2560
local baseY = 1440

local sizeX = 360
local sizeY = 24

local offsetX = 0
local offsetY = -(230 + sizeY)

-------------------------------------------------------------------------------

local colorBackgroundR = 0
local colorBackgroundG = 0
local colorBackgroundB = 0
local colorBackgroundA = 125

local colorForegroundR = 240
local colorForegroundG = 200
local colorForegroundB = 80
local colorForegroundA = 125

-------------------------------------------------------------------------------

local sizeBackgroundX = sizeX / baseX
local sizeBackgroundY = sizeY / baseY

local sizeForegroundX = sizeX / baseX
local sizeForegroundY = (sizeY / 2) / baseY

local originBackgroundX = (offsetX + (sizeX / 2)) / baseX
local originBackgroundY = (offsetY + (sizeY / 2)) / baseY

local originForegroundX = originBackgroundX
local originForegroundY = originBackgroundY - sizeForegroundY

-------------------------------------------------------------------------------

function DrawHud(fuel)
  SetScriptGfxAlign(alignX, alignY)

  -- Background
  DrawRect(
    originBackgroundX,
    originBackgroundY,
    sizeBackgroundX,
    sizeBackgroundY,
    colorBackgroundR,
    colorBackgroundG,
    colorBackgroundB,
    colorBackgroundA
  )

  -- Foreground
  DrawRect(
    originForegroundX,
    originForegroundY,
    sizeForegroundX,
    sizeForegroundY,
    colorForegroundR,
    colorForegroundG,
    colorForegroundB,
    colorForegroundA
  )

  -- Fuel bar
  DrawRect(
    originForegroundX - ((sizeForegroundX / 2) * (1 - fuel)),
    originForegroundY,
    sizeForegroundX * fuel,
    sizeForegroundY,
    colorForegroundR,
    colorForegroundG,
    colorForegroundB,
    colorForegroundA
  )

  ResetScriptGfxAlign()
end