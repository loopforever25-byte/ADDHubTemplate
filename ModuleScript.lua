-- GUI Template
local GUI = {}
GUI.Tabs = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MODULAR_GUI"
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Layout for tabs
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.Parent = MainFrame

-- =========================
-- Create Tab
-- =========================
function GUI:CreateTab(name)
    local Tab = {}
    Tab.Name = name
    Tab.Items = {}

    -- Container for tab items
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, -10, 0, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Parent = MainFrame

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0,5)
    Layout.Parent = TabFrame

    -- =========================
    -- Create Button
    -- =========================
    function Tab:CreateButton(info)
        local Button = Instance.new("TextButton")
        Button.Text = info.Name or "Button"
        Button.BackgroundColor3 = Color3.fromRGB(70,70,70)
        Button.Size = UDim2.new(1,0,0,30)
        Button.TextColor3 = Color3.new(1,1,1)
        Button.Parent = TabFrame

        Button.MouseButton1Click:Connect(function()
            if info.Callback then
                info.Callback()
            end
        end)

        table.insert(Tab.Items, Button)
        return Button
    end

    -- =========================
    -- Create Toggle
    -- =========================
    function Tab:CreateToggle(info)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1,0,0,30)
        Frame.BackgroundTransparency = 1
        Frame.Parent = TabFrame

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
                if info.Callback then
                    info.Callback(true)
                end
            else
                if info.CallbackOff then
                    info.CallbackOff(false)
                end
            end
        end)

        table.insert(Tab.Items, Frame)
        return Frame
    end

    -- =========================
    -- Create Slider
    -- =========================
    function Tab:CreateSlider(info)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1,0,0,30)
        Frame.BackgroundTransparency = 1
        Frame.Parent = TabFrame

        local Label = Instance.new("TextLabel")
        Label.Text = info.Name or "Slider"
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.new(0.6,0,1,0)
        Label.TextColor3 = Color3.new(1,1,1)
        Label.Parent = Frame

        local Slider = Instance.new("Frame")
        Slider.Size = UDim2.new(0.3,0,1,0)
        Slider.Position = UDim2.new(0.65,0,0,0)
        Slider.BackgroundColor3 = Color3.fromRGB(100,100,100)
        Slider.Parent = Frame

        local dragging = false

        Slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        Slider.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouse = UserInputService:GetMouseLocation()
                local relativeX = math.clamp(mouse.X - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X)
                local percent = relativeX / Slider.AbsoluteSize.X
                Slider.Size = UDim2.new(percent,0,1,0)
                if info.Callback then
                    info.Callback(percent)
                end
            end
        end)

        table.insert(Tab.Items, Frame)
        return Frame
    end

    table.insert(self.Tabs, Tab)
    return Tab
end

return GUI
