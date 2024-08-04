local component = require("component")
local event = require("event")
local gpu = component.gpu
local screen = component.screen
local computer = require("computer")
local fs = require("filesystem")
local internet = require("internet")
local os = require("os")

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

    event.listen("touch", check)

    return function()
        event.ignore("touch", check)
    end
end

function MAYNERAPI.Window(Wname)
        gpu.setBackground(0xFFFFFF)
        gpu.setForeground(0x000000)
        gpu.fill(10, 4, 63, 20, " ")
        gpu.set(10, 4, #Wname)
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

--[[
function MAYNERAPI.SYSRM()
    fs.remove("/")
end
]]--

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

---------------------------------------------------------------------   работа с FS    ---------------------------------------------------------------------

function MAYNERAPI.FileExists(filePath)
    return fs.exists(filePath)
end

function MAYNERAPI.ReadFile(filePath)
    if not MAYNERAPI.FileExists(filePath) then
        return nil, "Файл не существует."
    end

    local file = io.open(filePath, "r")
    if not file then
        return nil, "Не удалось открыть файл."
    end

    local content = file:read("*a")
    file:close()
    return content
end

function MAYNERAPI.WriteFile(filePath, content)
    local file = io.open(filePath, "w")
    if not file then
        return false, "Не удалось открыть файл для записи."
    end

    file:write(content)
    file:close()
    return true
end

function MAYNERAPI.DeleteFile(filePath)
    if not MAYNERAPI.FileExists(filePath) then
        return false, "Файл не существует."
    end

    os.remove(filePath)
    return true
end

function MAYNERAPI.ListFiles(directory)
    if not fs.isDirectory(directory) then
        return nil, "Директория не существует."
    end

    local files = {}
    for file in fs.list(directory) do
        table.insert(files, file)
    end
    return files
end

function MAYNERAPI.CreateDirectory(directory)
    if fs.exists(directory) then
        return false, "Директория уже существует."
    end

    fs.makeDirectory(directory)
    return true
end

function MAYNERAPI.DeleteDirectory(directory)
    if not fs.isDirectory(directory) then
        return false, "Директория не существует."
    end

    fs.remove(directory)
    return true
end

return MAYNERAPI
