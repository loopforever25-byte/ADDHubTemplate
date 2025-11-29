-- ModuleScript: ADDHubTemplate
local ADDHub = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Store semua elemen GUI
ADDHub.Elements = {}

-- ===============================
-- Helper Functions
-- ===============================
local function createCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
end

local function createStroke(parent, thickness, color)
    local s = Instance.new("UIStroke")
    s.Thickness = thickness
    s.Color = color
    s.Parent = parent
end

local function enableDrag(frame)
    local dragging = false
    local dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = UIS:GetMouseLocation()
            startPos = frame.Position
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    RunService.Heartbeat:Connect(function()
        if dragging then
            local delta = UIS:GetMouseLocation() - dragStart
            frame.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)
end

-- ===============================
-- Initialize GUI
-- ===============================
function ADDHub:Init()
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ADDHubGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    self.Elements.ScreenGui = screenGui

    -- Launcher Button "AH"
    local launcher = Instance.new("TextButton")
    launcher.Name = "AH_Launcher"
    launcher.Size = UDim2.new(0, 60, 0, 60)
    launcher.Position = UDim2.new(0, 20, 0.5, -30)
    launcher.BackgroundColor3 = Color3.fromRGB(0,170,255)
    launcher.Text = "AH"
    launcher.TextColor3 = Color3.fromRGB(255,255,255)
    launcher.Font = Enum.Font.GothamBlack
    launcher.TextSize = 22
    launcher.Visible = true
    launcher.Parent = screenGui
    createCorner(launcher, 60)
    createStroke(launcher, 2, Color3.fromRGB(0,100,200))
    enableDrag(launcher)
    self.Elements.Launcher = launcher

    -- Main Holder
    local mainHolder = Instance.new("Frame")
    mainHolder.Size = UDim2.new(0, 410, 0, 310)
    mainHolder.Position = UDim2.new(0.5, -205, 0.5, -155)
    mainHolder.BackgroundColor3 = Color3.fromRGB(35,35,40)
    mainHolder.Parent = screenGui
    mainHolder.Visible = false
    createCorner(mainHolder, 12)
    createStroke(mainHolder, 2, Color3.fromRGB(70,70,80))
    enableDrag(mainHolder)
    self.Elements.MainHolder = mainHolder

    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 35, 0, 28)
    closeButton.Position = UDim2.new(1, -45, 0.16, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
    closeButton.BackgroundTransparency = 0.8
    closeButton.TextColor3 = Color3.fromRGB(255,255,255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 18
    closeButton.Parent = mainHolder
    createCorner(closeButton, 6)

    closeButton.MouseButton1Click:Connect(function()
        mainHolder.Visible = false
        launcher.Visible = true
    end)

    launcher.MouseButton1Click:Connect(function()
        launcher.Visible = false
        mainHolder.Visible = true
    end)

    -- Tabs container
    self.Elements.Tabs = {}
end

-- ===============================
-- Tabs
-- ===============================
function ADDHub:AddTab(name)
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -20, 1, -60)
    tabFrame.Position = UDim2.new(0, 10, 0, 50)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.Parent = self.Elements.MainHolder

    self.Elements.Tabs[name] = tabFrame
    return tabFrame
end

function ADDHub:ShowTab(name)
    for tName, tFrame in pairs(self.Elements.Tabs) do
        tFrame.Visible = (tName == name)
    end
end

-- ===============================
-- UI Elements with Callback
-- ===============================
function ADDHub:AddButton(tabName, text, callback)
    local tab = self.Elements.Tabs[tabName]
    assert(tab, "Tab "..tabName.." tidak ada!")
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, (#tab:GetChildren())*45)
    btn.Parent = tab
    btn.MouseButton1Click:Connect(callback)
    return btn
end

function ADDHub:AddToggle(tabName, text, callback)
    local tab = self.Elements.Tabs[tabName]
    assert(tab, "Tab "..tabName.." tidak ada!")
    local toggle = Instance.new("TextButton")
    toggle.Text = text.." OFF"
    toggle.Size = UDim2.new(0, 120, 0, 35)
    toggle.Position = UDim2.new(0, 10, 0, (#tab:GetChildren())*45)
    toggle.Parent = tab
    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = text.." "..(state and "ON" or "OFF")
        if callback then callback(state) end
    end)
    return toggle
end

function ADDHub:AddInput(tabName, placeholder, callback)
    local tab = self.Elements.Tabs[tabName]
    assert(tab, "Tab "..tabName.." tidak ada!")
    local input = Instance.new("TextBox")
    input.PlaceholderText = placeholder
    input.Size = UDim2.new(0, 200, 0, 35)
    input.Position = UDim2.new(0, 10, 0, (#tab:GetChildren())*45)
    input.Parent = tab
    input.FocusLost:Connect(function()
        if callback then callback(input.Text) end
    end)
    return input
end

function ADDHub:AddDropdown(tabName, labelText, options, callback)
    local tab = self.Elements.Tabs[tabName]
    assert(tab, "Tab "..tabName.." tidak ada!")
    local dropHolder = Instance.new("Frame")
    dropHolder.Size = UDim2.new(0, 200, 0, 35)
    dropHolder.Position = UDim2.new(0, 10, 0, (#tab:GetChildren())*45)
    dropHolder.BackgroundColor3 = Color3.fromRGB(60,60,70)
    dropHolder.Parent = tab
    createCorner(dropHolder, 6)

    local dropBtn = Instance.new("TextButton")
    dropBtn.Text = labelText.." ▼"
    dropBtn.Size = UDim2.new(1,0,1,0)
    dropBtn.BackgroundTransparency = 1
    dropBtn.Parent = dropHolder

    local dropFrame = Instance.new("Frame")
    dropFrame.Size = UDim2.new(1,0,0,0)
    dropFrame.Position = UDim2.new(0,0,1,0)
    dropFrame.BackgroundColor3 = Color3.fromRGB(50,50,60)
    dropFrame.ClipsDescendants = true
    dropFrame.Parent = dropHolder
    createCorner(dropFrame, 6)

    local dropOpen = false
    local targetSize = 0
    RunService.RenderStepped:Connect(function()
        local cur = dropFrame.Size.Y.Offset
        dropFrame.Size = UDim2.new(1,0,0,cur + (targetSize - cur)*0.18)
    end)

    dropBtn.MouseButton1Click:Connect(function()
        dropOpen = not dropOpen
        targetSize = dropOpen and (#options*35) or 0
        dropBtn.Text = labelText.." "..(dropOpen and "▲" or "▼")
    end)

    for i,opt in ipairs(options) do
        local optionBtn = Instance.new("TextButton")
        optionBtn.Text = opt
        optionBtn.Size = UDim2.new(1,0,0,35)
        optionBtn.Position = UDim2.new(0,0,0,(i-1)*35)
        optionBtn.BackgroundColor3 = Color3.fromRGB(70,70,80)
        optionBtn.TextColor3 = Color3.fromRGB(255,255,255)
        optionBtn.Parent = dropFrame
        createCorner(optionBtn, 6)
        optionBtn.MouseButton1Click:Connect(function()
            dropBtn.Text = labelText.." ▼"
            dropOpen = false
            targetSize = 0
            if callback then callback(opt) end
        end)
    end
    return dropHolder
end

return ADDHub
