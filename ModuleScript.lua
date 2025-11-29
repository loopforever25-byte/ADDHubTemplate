-- GUI TEMPLATE – ADD++ HUB
-- SIMPLY CALL addToggle("Name", function(on) ... end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Template = {}

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AddHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(50,50,50)
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Text = "ADD++ HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(0,150,1,0)
title.Position = UDim2.new(0,5,0,0)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Parent = header

local iconBtn = Instance.new("TextButton")
iconBtn.Text = "☰"
iconBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
iconBtn.TextColor3 = Color3.new(1,1,1)
iconBtn.Size = UDim2.new(0,40,0,40)
iconBtn.Position = UDim2.new(0,10,0,10)
iconBtn.Visible = false
iconBtn.Parent = screenGui

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    iconBtn.Visible = true
end)

iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    iconBtn.Visible = false
end)

-- Toggle system
local toggles = {}
local startY = 50
local spacing = 35

function Template.addToggle(name, callback)
    local index = #toggles + 1
    local y = startY + (index - 1) * spacing

    local row = Instance.new("Frame")
    row.BackgroundTransparency = 1
    row.Size = UDim2.new(1,-10,0,30)
    row.Position = UDim2.new(0,5,0,y)
    row.Parent = mainFrame

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.Size = UDim2.new(0.6,0,1,0)
    label.Position = UDim2.new(0,5,0,0)
    label.Parent = row

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0,50,0,20)
    toggle.Position = UDim2.new(1,-55,0,5)
    toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
    toggle.Parent = row

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.5,0,1,0)
    slider.Position = UDim2.new(0,0,0,0)
    slider.BackgroundColor3 = Color3.fromRGB(50,200,50)
    slider.Parent = toggle

    local isOn = false

    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isOn = not isOn
            TweenService:Create(
                slider,
                TweenInfo.new(0.2),
                {Position = isOn and UDim2.new(0.5,0,0,0) or UDim2.new(0,0,0,0)}
            ):Play()

            if callback then
                task.spawn(callback, isOn)
            end
        end
    end)

    table.insert(toggles, row)
end

return Template
