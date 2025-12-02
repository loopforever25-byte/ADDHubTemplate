local GUI = require(script.Parent:WaitForChild("Main"))

local ADDHubUI = GUI:AddSettingsFrame({
	Name = "ADD++ HUB",
	SubName = "Blox Fruit",
	Layout = "Landscape",       -- Kotak atau Kosong atau Tulis apapun / Portrait / Landscape
	FrameDraggable = true,
	TextSizeName = 25,
	TextSizeSubName = 20,
	IconDraggable = true,
	IconText = "AH",
	-- IconImg = "rbxassetid://123456789", -- Gunakan ini untuk ganti dengan assetid gambar icon
	IconPosition = "x-10 y-50",
	IconFont = "Bangers",
	IconSize = 40,
	IconCorner = 7,
	FontTab = "ArialBold",
	TextSizeTab = 12
})

GUI.DefaultTab.Font = "Bangers" -- Gunakan ini untuk custom semua Font
GUI.DefaultTab.TextSize = 16 -- Gunakan ini untuk custom semua TextSize

local TabMain = ADDHubUI:AddTab("Main")
local TabCombat = ADDHubUI:AddTab("Combat")
local TabEsp = ADDHubUI:AddTab("ESP")

GUI.DefaultTitle.Font = "Highway" -- Gunakan ini untuk custom semua Font title
GUI.DefaultTitle.TextSize = 20 -- Gunakan ini untuk custom semua TextSize title
GUI.DefaultTitle.Align = "Left"  -- Gunakan ini untuk custom semua Align title
GUI.DefaultTitle.BgTransparent = 1  -- Gunakan ini untuk custom semua BgTransparent title

local ADDHub = TabMain:CreateTitle({
	Name = "Farm",
	-- Align = "Left", (Atau gunakan ini untuk custom satu persatu)
	-- BgTransparent = 1, (Atau gunakan ini untuk custom satu persatu)
	-- Font = "SourceSans", (Atau gunakan ini untuk custom satu persatu)
	-- TextSize = 30 (Atau gunakan ini untuk custom satu persatu)
})

GUI.DefaultLabel.Font = "Rbt" -- Gunakan ini untuk custom semua Font label
GUI.DefaultLabel.TextSize = 16 -- Gunakan ini untuk custom semua TextSize label

local ADDHub = TabMain:CreateToggle({
	Name = "Highlight",
 -- Font = "Bangers", (Atau gunakan ini untuk custom satu persatu)
 -- TextSize = 16, (Atau gunakan ini untuk custom satu persatu)
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if not char then return end

		-- Cek kalau sudah ada highlight sebelumnya
		if char:FindFirstChild("ADD_HIGHLIGHT") then
			char.ADD_HIGHLIGHT.Enabled = true
			return
		end

		-- Buat highlight baru
		local hl = Instance.new("Highlight")
		hl.Name = "ADD_HIGHLIGHT"
		hl.FillColor = Color3.fromRGB(255, 0, 0)
		hl.FillTransparency = 0.4     -- 0 = solid, 1 = full transparan
		hl.OutlineColor = Color3.fromRGB(255, 0, 0)
		hl.OutlineTransparency = 0
		hl.Adornee = char
		hl.Parent = char
	end,
	CallbackOff = function()
		local char = game.Players.LocalPlayer.Character
		if not char then return end

		local hl = char:FindFirstChild("ADD_HIGHLIGHT")
		if hl then
			hl.Enabled = false
		end
	end
})

local ADDhub = TabMain:CreateTextInputButton({
	Name = "WalkSpeed",
	Placeholder = "Angka",
	CurrentValue = 200,
 -- Font = "Bangers", (Atau gunakan ini untuk custom satu persatu)
 -- TextSize = 16, (Atau gunakan ini untuk custom satu persatu)
	Callback = function(state, value)
		-- state = true artinya toggle ON
		if state then
			local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = tonumber(value) or 16
			end
		end
	end,
	CallbackOff = function(state)
		-- state = false artinya toggle OFF
		local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = 16 -- balikin default
		end
	end
})

local ADDhub = TabMain:CreateSliderToggle({
	Name = "WalkSpeed",
	Range = {1, 200},
	Increment = 1,
	Suffix = " studs",
	CurrentValue = 200,
 -- Font = "Bangers", (Atau gunakan ini untuk custom satu persatu)
 -- TextSize = 16, (Atau gunakan ini untuk custom satu persatu)
	Callback = function(value)
		local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = value
		end
	end,
	CallbackOff = function()
		local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = 16
		end
	end
})

local ADDhub = TabCombat:CreateToggle({
	Name = "Aim Kamera",
	Callback = function() print("On") end,
	CallbackOff = function() print("Off") end
})
