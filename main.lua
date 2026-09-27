--==================================================
-- BIGBOSS COORDINATE LOCATOR
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local BLACK  = Color3.fromRGB(7, 9, 14)
local PANEL  = Color3.fromRGB(15, 20, 32)
local PANEL2 = Color3.fromRGB(24, 31, 47)
local ORANGE = Color3.fromRGB(255, 166, 0)
local WHITE  = Color3.fromRGB(235, 235, 235)
local GREY   = Color3.fromRGB(130, 140, 155)
local GREEN  = Color3.fromRGB(60, 200, 110)
local CYAN   = Color3.fromRGB(80, 200, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "BIGBOSS_COORDS"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(340, 260)
main.Position = UDim2.new(0.5, -170, 0.5, -130)
main.BackgroundColor3 = BLACK
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = BLACK
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.fromOffset(14, 0)
title.BackgroundTransparency = 1
title.Text = "BIGBOSS COORDINATE LOCATOR"
title.TextColor3 = ORANGE
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(32, 32)
closeBtn.Position = UDim2.new(1, -40, 0.5, -16)
closeBtn.BackgroundColor3 = PANEL2
closeBtn.Text = "X"
closeBtn.TextColor3 = WHITE
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local coordLabel = Instance.new("TextLabel")
coordLabel.Size = UDim2.new(1, -30, 0, 80)
coordLabel.Position = UDim2.fromOffset(15, 54)
coordLabel.BackgroundColor3 = PANEL
coordLabel.BorderSizePixel = 0
coordLabel.Text = "X: 0\nY: 0\nZ: 0"
coordLabel.TextColor3 = CYAN
coordLabel.TextSize = 16
coordLabel.Font = Enum.Font.Code
coordLabel.TextXAlignment = Enum.TextXAlignment.Left
coordLabel.TextYAlignment = Enum.TextYAlignment.Center
coordLabel.Parent = main

local coordCorner = Instance.new("UICorner")
coordCorner.CornerRadius = UDim.new(0, 7)
coordCorner.Parent = coordLabel

local coordPadding = Instance.new("UIPadding")
coordPadding.PaddingLeft = UDim.new(0, 15)
coordPadding.Parent = coordLabel

local vectorLabel = Instance.new("TextLabel")
vectorLabel.Size = UDim2.new(1, -30, 0, 30)
vectorLabel.Position = UDim2.fromOffset(15, 140)
vectorLabel.BackgroundColor3 = PANEL2
vectorLabel.BorderSizePixel = 0
vectorLabel.Text = "Vector3.new(0, 0, 0)"
vectorLabel.TextColor3 = GREEN
vectorLabel.TextSize = 12
vectorLabel.Font = Enum.Font.Code
vectorLabel.TextXAlignment = Enum.TextXAlignment.Center
vectorLabel.Parent = main

local vectorCorner = Instance.new("UICorner")
vectorCorner.CornerRadius = UDim.new(0, 6)
vectorCorner.Parent = vectorLabel

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(1, -30, 0, 38)
copyBtn.Position = UDim2.fromOffset(15, 178)
copyBtn.BackgroundColor3 = ORANGE
copyBtn.Text = "COPY COORDINATES"
copyBtn.TextColor3 = BLACK
copyBtn.TextSize = 12
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Parent = main

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 7)
copyCorner.Parent = copyBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 20)
statusLabel.Position = UDim2.fromOffset(15, 220)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Walk to the spot you want"
statusLabel.TextColor3 = GREY
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = main

local lastX, lastY, lastZ = 0, 0, 0

RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local pos = root.Position
    lastX = math.floor(pos.X)
    lastY = math.floor(pos.Y)
    lastZ = math.floor(pos.Z)

    coordLabel.Text = string.format("X: %d\nY: %d\nZ: %d", lastX, lastY, lastZ)
    vectorLabel.Text = string.format("Vector3.new(%d, %d, %d)", lastX, lastY, lastZ)
end)

copyBtn.MouseButton1Click:Connect(function()
    local text = string.format("Vector3.new(%d, %d, %d)", lastX, lastY, lastZ)

    local copied = false
    pcall(function()
        if setclipboard then
            setclipboard(text)
            copied = true
        elseif toclipboard then
            toclipboard(text)
            copied = true
        end
    end)

    if copied then
        copyBtn.Text = "COPIED!"
        copyBtn.BackgroundColor3 = GREEN
        statusLabel.Text = "Copied: " .. text
        statusLabel.TextColor3 = GREEN
    else
        copyBtn.Text = "COPY MANUALLY"
        copyBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
        statusLabel.Text = "Read the green box"
        statusLabel.TextColor3 = ORANGE
    end

    print("[BIGBOSS COORDS] " .. text)

    task.wait(1.5)
    copyBtn.Text = "COPY COORDINATES"
    copyBtn.BackgroundColor3 = ORANGE
end)

-- Drag
local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("[BIGBOSS COORDS] Locator loaded.")
