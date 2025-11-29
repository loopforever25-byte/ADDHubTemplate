local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- ScreenGui
-- =========================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ADDHub_GUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- =========================
-- Main Frame
-- =========================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- =========================
-- Header
-- =========================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,30)
Header.BackgroundColor3 = Color3.fromRGB(0,0,0)
Header.Parent = MainFrame

-- Label ADD ++ HUB
local Label = Instance.new("TextLabel")
Label.Text = "ADD ++ HUB"
Label.TextColor3 = Color3.fromRGB(255, 75, 75) -- #ff4b4b
Label.BackgroundTransparency = 1
Label.Font = Enum.Font.SourceSansBold
Label.TextSize = 18
Label.Position = UDim2.new(0,5,0,0)
Label.Size = UDim2.new(0.5,0,1,0)
Label.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-35,0,0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Parent = Header

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Text = "_"
MinBtn.Size = UDim2.new(0,30,0,30)
MinBtn.Position = UDim2.new(1,-70,0,0)
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Parent = Header

-- Icon AH (bentuk bulat) untuk show GUI ketika minimized
local IconAH = Instance.new("TextButton")
IconAH.Size = UDim2.new(0,40,0,40)
IconAH.Position = UDim2.new(0,10,0,50)
IconAH.BackgroundColor3 = Color3.fromRGB(0,0,0)
IconAH.TextColor3 = Color3.fromRGB(255,75,75)
IconAH.Text = "AH"
IconAH.Visible = false
IconAH.Parent = ScreenGui

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconAH.Visible = true
end)

IconAH.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    IconAH.Visible = false
end)

-- =========================
-- Layout Container
-- =========================
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1,-10,1,-40)
Container.Position = UDim2.new(0,5,0,35)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.Parent = Container

-- =========================
-- GUI Modular Table
-- =========================
local GUI = {}
GUI.Tabs = {}

function GUI:CreateTab(name)
    local Tab = {}
    Tab.Name = name
    Tab.Items = {}
    Tab.Container = Container

    -- Create Button
    function Tab:CreateButton(info)
        local Button = Instance.new("TextButton")
        Button.Text = info.Name or "Button"
        Button.Size = UDim2.new(1,0,0,30)
        Button.BackgroundColor3 = Color3.fromRGB(70,70,70)
        Button.TextColor3 = Color3.new(1,1,1)
        Button.Parent = Tab.Container

        Button.MouseButton1Click:Connect(function()
            if info.Callback then
                info.Callback()
            end
        end)

        table.insert(Tab.Items, Button)
        return Button
    end

    -- Create Toggle
    function Tab:CreateToggle(info)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1,0,0,30)
        Frame.BackgroundTransparency = 1
        Frame.Parent = Tab.Container

        local Label = Instance.new("TextLabel")
        Label.Text = info.Name or "Toggle"
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.new(0.6,0,1,0)
        Label.TextColor3 = Color3.new(1,1,1)
        Label.Parent = Frame

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0,50,0,20)
        Button.Position = UDim2.new(1,-55,0,5)
        Button.BackgroundColor3 = Color3.fromRGB(100,100,100)
        Button.Text = "Off"
        Button.Parent = Frame

        local state = false

        Button.MouseButton1Click:Connect(function()
            state = not state
            Button.Text = state and "On" or "Off"

            if state then
                if info.Callback then info.Callback(true) end
            else
                if info.CallbackOff then info.CallbackOff(false) end
            end
        end)

        table.insert(Tab.Items, Frame)
        return Frame
    end

    table.insert(self.Tabs, Tab)
    return Tab
end

return GUI
