-- =========================
-- ADD++ HUB GUI Module (Final Fixed)
-- =========================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local GUI = {}

GUI.DefaultLabel = {
	Font = "SourceSans",
	TextSize = 90,
}

GUI.Tabs = {}

-- =========================
-- Layout Helper
-- =========================
local function getLayoutSize(layout)
	if layout == "Landscape" then
		return 650, 450
	elseif layout == "Portrait" then
		return 300, 500
	else -- kotak / default
		return 450, 450
	end
end

local FullFontList = {
	AmaticSC = Enum.Font.AmaticSC,
	Antique = Enum.Font.Antique,
	Arcade = Enum.Font.Arcade,
	Arial = Enum.Font.Arial,
	ArialBold = Enum.Font.ArialBold,
	Arimo = Enum.Font.Arimo,
	ArimoBold = Enum.Font.ArimoBold,
	Bangers = Enum.Font.Bangers,
	Bodoni = Enum.Font.Bodoni,
	BuilderSans = Enum.Font.BuilderSans,
	BuilderSansBold = Enum.Font.BuilderSansBold,
	BuilderSansExtraBold = Enum.Font.BuilderSansExtraBold,
	BuilderSansMedium = Enum.Font.BuilderSansMedium,
	Cartoon = Enum.Font.Cartoon,
	Code = Enum.Font.Code,
	Creepster = Enum.Font.Creepster,
	DenkOne = Enum.Font.DenkOne,
	Fantasy = Enum.Font.Fantasy,
	Fondamento = Enum.Font.Fondamento,
	FredokaOne = Enum.Font.FredokaOne,
	Garamond = Enum.Font.Garamond,
	Gotham = Enum.Font.Gotham,
	GothamBlack = Enum.Font.GothamBlack,
	GothamBold = Enum.Font.GothamBold,
	GothamMedium = Enum.Font.GothamMedium,
	GrenzeGotisch = Enum.Font.GrenzeGotisch,
	Highway = Enum.Font.Highway,
	IndieFlower = Enum.Font.IndieFlower,
	JosefinSans = Enum.Font.JosefinSans,
	Jura = Enum.Font.Jura,
	Kalam = Enum.Font.Kalam,
	Legacy = Enum.Font.Legacy,
	LuckiestGuy = Enum.Font.LuckiestGuy,
	Merriweather = Enum.Font.Merriweather,
	Michroma = Enum.Font.Michroma,
	Nunito = Enum.Font.Nunito,
	Oswald = Enum.Font.Oswald,
	PatrickHand = Enum.Font.PatrickHand,
	PermanentMarker = Enum.Font.PermanentMarker,
	Roboto = Enum.Font.Roboto,
	RobotoCondensed = Enum.Font.RobotoCondensed,
	RobotoMono = Enum.Font.RobotoMono,
	Sarpanch = Enum.Font.Sarpanch,
	SciFi = Enum.Font.SciFi,
	SourceSans = Enum.Font.SourceSans,
	SourceSansBold = Enum.Font.SourceSansBold,
	SourceSansItalic = Enum.Font.SourceSansItalic,
	SourceSansLight = Enum.Font.SourceSansLight,
	SourceSansSemibold = Enum.Font.SourceSansSemibold,
	SpecialElite = Enum.Font.SpecialElite,
	TitilliumWeb = Enum.Font.TitilliumWeb,
	Ubuntu = Enum.Font.Ubuntu,
	Unknown = Enum.Font.Unknown
}


local FontAlias = {

	-- Amatic
	Amatic = "AmaticSC",

	-- Antique
	Old = "Antique",
	Antique = "Antique",

	-- Arcade
	Arc = "Arcade",
	Retro = "Arcade",
	Arcade = "Arcade",

	-- Arial variants
	Arial = "Arial",
	ArialB = "ArialBold",
	Bold = "SourceSansBold",
	Italic = "SourceSansItalic",

	-- Arimo
	Arimo = "Arimo",
	ArimoB = "ArimoBold",

	-- Bangers
	Bangers = "Bangers",

	-- Bodoni
	Bodoni = "Bodoni",

	-- BuilderSans
	Builder = "BuilderSans",
	BuilderB = "BuilderSansBold",
	BuilderEB = "BuilderSansExtraBold",
	BuilderM = "BuilderSansMedium",

	-- Cartoon
	Cartoon = "Cartoon",

	-- Code
	Code = "Code",

	-- Creepster
	Creep = "Creepster",
	Creepster = "Creepster",

	-- DenkOne
	Denk = "DenkOne",
	DenkOne = "DenkOne",

	-- Fantasy
	Fantasy = "Fantasy",

	-- Fondamento
	Fondamento = "Fondamento",

	-- Fredoka
	Fredoka = "FredokaOne",

	-- Garamond
	Garamond = "Garamond",

	-- Gotham
	Gotham = "Gotham",
	GothamB = "GothamBold",
	GothamBlack = "GothamBlack",
	GothamM = "GothamMedium",

	-- Grenze
	Grenze = "GrenzeGotisch",

	-- Highway
	Road = "Highway",
	Street = "Highway",
	Highway = "Highway",

	-- Indie Flower
	Indie = "IndieFlower",

	-- Josefin Sans
	Josefin = "JosefinSans",

	-- Jura
	Jura = "Jura",

	-- Kalam
	Kalam = "Kalam",

	-- Legacy
	Legacy = "Legacy",

	-- Luckiest Guy
	Luckiest = "LuckiestGuy",

	-- Merriweather
	Merriweather = "Merriweather",

	-- Michroma
	Micro = "Michroma",

	-- Nunito
	Nunito = "Nunito",

	-- Oswald
	Oswald = "Oswald",

	-- Patrick Hand
	Hand = "PatrickHand",
	Patrick = "PatrickHand",

	-- Permanent Marker
	Marker = "PermanentMarker",

	-- Roboto variants
	Roboto = "Roboto",
	RobotoC = "RobotoCondensed",
	RobotoCondensed = "RobotoCondensed",
	RobotoM = "RobotoMono",
	RobotoMono = "RobotoMono",
	Mono = "RobotoMono",

	-- Sarpanch
	Sarpanch = "Sarpanch",

	-- SciFi
	Sci = "SciFi",
	Science = "SciFi",

	-- Source Sans variants
	Sans = "SourceSans",
	SansPro = "SourceSansSemibold",
	Pro = "SourceSansSemibold",
	Source = "SourceSans",
	SourceBold = "SourceSansBold",
	SourceItalic = "SourceSansItalic",
	SourceLight = "SourceSansLight",

	-- Special Elite
	Special = "SpecialElite",

	-- Titillium Web
	Titillium = "TitilliumWeb",

	-- Ubuntu
	Ubu = "Ubuntu",
	Ubuntu = "Ubuntu",

	-- Unknown
	Unknown = "Unknown",
}

local function ResolveFont(name)
	if not name then return nil end

	local cleaned = string.lower(name):gsub("%s+", ""):gsub("[^%w]", "")

	-- Alias
	for alias, target in pairs(FontAlias) do
		if string.lower(alias) == cleaned then
			return FullFontList[target]
		end
	end

	-- Full names
	for fontName, enum in pairs(FullFontList) do
		if string.lower(fontName) == cleaned then
			return enum
		end
	end

	return nil  -- ubah default juga ke nil
end

-- =========================
-- AddSettingsFrame
-- =========================
function GUI:AddSettingsFrame(info)
	local width, height = getLayoutSize(info.Layout)

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = info.Name or "ADDHub_UI"
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	-- Main Frame
	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, width, 0, height)
	MainFrame.Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
	MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	MainFrame.Active = true
	MainFrame.Draggable = info.FrameDraggable or false
	MainFrame.Parent = ScreenGui
	
	local originalDraggable = info.FrameDraggable == true
	MainFrame.Active = originalDraggable

	-- Header
	local Header = Instance.new("Frame")
	Header.Size = UDim2.new(1,0,0,30)
	Header.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Header.Parent = MainFrame

	-- Title
	local Title = Instance.new("TextLabel")
	Title.Text = info.Name or "ADD++ HUB"
	Title.Font = ResolveFont(info.FontName) or Enum.Font.Bangers
	Title.TextSize = info.TextSizeName or 20
	Title.TextColor3 = Color3.fromRGB(255,70,70)
	Title.BackgroundTransparency = 1
	Title.AnchorPoint = Vector2.new(0,0.5)
	Title.Position = UDim2.new(0,10,0.5,0)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Header

	-- SubName    
	if info.SubName then
		local SubTitle = Instance.new("TextLabel")
		SubTitle.Text = "- "..info.SubName
		SubTitle.Font = ResolveFont(info.FontSubName) or Enum.Font.SourceSans
		SubTitle.TextSize = info.TextSizeSubName or 16
		SubTitle.TextColor3 = Color3.fromRGB(200,200,200)
		SubTitle.BackgroundTransparency = 1
		SubTitle.AnchorPoint = Vector2.new(0,0.5)
		SubTitle.Position = UDim2.new(0, Title.TextBounds.X + 15, 0.5, 0)
		SubTitle.TextXAlignment = Enum.TextXAlignment.Left
		SubTitle.Parent = Header
	end

	-- Close Button
	local Close = Instance.new("TextButton")
	Close.Size = UDim2.new(0,23,0,18)
	Close.Position = UDim2.new(1,-35,0,5)
	Close.Text = "X"
	Close.TextColor3 = Color3.new(1,1,1)
	Close.BackgroundColor3 = Color3.fromRGB(150,0,0)
	Close.Font = Enum.Font.SourceSansBold
	Close.Parent = Header
	Close.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	-- Minimize Button
	local Minimize = Instance.new("TextButton")
	Minimize.Size = UDim2.new(0,23,0,18)
	Minimize.Position = UDim2.new(1,-70,0,5)
	Minimize.Text = "_"
	Minimize.TextColor3 = Color3.fromRGB(255,255,255)
	Minimize.BackgroundColor3 = Color3.fromRGB(50,50,50)
	Minimize.Font = Enum.Font.SourceSansBold
	Minimize.Parent = Header

	-- parser kecil untuk string Position
	local function parsePosition(pos)
		if typeof(pos) == "UDim2" then
			return pos
		elseif typeof(pos) == "string" then
			local xOffset = tonumber(pos:match("x%-([%-]?%d+)")) or 0
			local yOffset = tonumber(pos:match("y%-([%-]?%d+)")) or 0
			return UDim2.new(0, xOffset, 0, yOffset)
		else
			return UDim2.new(0,10,0,50) -- default
		end
	end

	-- =========================
	-- Icon (default selalu ada)
	-- =========================
	local Icon
	do
		if info.IconImg then
			Icon = Instance.new("ImageButton")
			Icon.Image = info.IconImg
		else
			Icon = Instance.new("TextButton")
			Icon.Text = info.IconText or "AH"
			Icon.Font = info.IconFont or Enum.Font.Bangers
			Icon.TextSize = 25
			Icon.TextColor3 = Color3.fromRGB(255,70,70)
		end

		local sizeVal = info.IconSize or 40
		Icon.Size = UDim2.new(0, sizeVal, 0, sizeVal)
		Icon.Position = parsePosition(info.IconPosition) or UDim2.new(0,10,0,50)
		Icon.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Icon.Parent = ScreenGui
		Icon.Visible = false

		local cornerVal = info.IconCorner or 0
		if cornerVal > 0 then
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, cornerVal)
			corner.Parent = Icon
		end

		if info.IconDraggable then
			local dragging = false
			local dragInput, dragStart, startPos

			Icon.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or
					input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = Icon.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			Icon.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)

			RunService.RenderStepped:Connect(function()
				if dragging and dragInput then
					local delta = dragInput.Position - dragStart
					Icon.Position = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset + delta.X,
						startPos.Y.Scale,
						startPos.Y.Offset + delta.Y
					)
				end
			end)
		end
	end

	-- Minimize / Restore
	Minimize.MouseButton1Click:Connect(function()
		MainFrame.Visible = false
		if Icon then Icon.Visible = true end
	end)

	if Icon then
		Icon.MouseButton1Click:Connect(function()
			MainFrame.Visible = true
			Icon.Visible = false
		end)
	end

	-- =========================
	-- Container utama
	-- =========================
	local Container = Instance.new("Frame")
	Container.Size = UDim2.new(1,-10,1,-45)
	Container.Position = UDim2.new(0,5,0,35)
	Container.BackgroundTransparency = 1
	Container.Parent = MainFrame

	-- =========================
	-- TAB SYSTEM
	-- =========================
	local Tabs = {}
	local CurrentTab = nil

	-- Scrolling Tab Header (HORIZONTAL)
	local TabHeader = Instance.new("ScrollingFrame")
	TabHeader.Size = UDim2.new(1, 0, 0, 30)
	TabHeader.BackgroundTransparency = 1
	TabHeader.Parent = Container

	TabHeader.ScrollBarThickness = 4
	TabHeader.ScrollBarImageColor3 = Color3.fromRGB(120,120,120)
	TabHeader.ScrollingDirection = Enum.ScrollingDirection.X
	TabHeader.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabHeader.AutomaticCanvasSize = Enum.AutomaticSize.X
	TabHeader.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
	TabHeader.VerticalScrollBarInset = Enum.ScrollBarInset.None
	TabHeader.ScrollBarImageTransparency = 1
	TabHeader.ScrollBarThickness = 0

	-- Layout tombol tab
	local TabHeaderLayout = Instance.new("UIListLayout")
	TabHeaderLayout.FillDirection = Enum.FillDirection.Horizontal
	TabHeaderLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabHeaderLayout.Padding = UDim.new(0, 8)
	TabHeaderLayout.Parent = TabHeader

	local TabContent = Instance.new("Frame")
	TabContent.Size = UDim2.new(1,0,1,-40)
	TabContent.Position = UDim2.new(0,0,0,35)
	TabContent.BackgroundTransparency = 1
	TabContent.Parent = Container

	-- =========================
	-- API untuk developer
	-- =========================
	local FrameAPI = {}
	FrameAPI.Container = Container
	FrameAPI.MainFrame = MainFrame
	FrameAPI.ScreenGui = ScreenGui
	FrameAPI.Icon = Icon

	function FrameAPI:AddTab(name)
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(0, 70, 1, 0)
		TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		TabButton.Text = name
		TabButton.TextColor3 = Color3.new(1,1,1)
		TabButton.Font = info.FontTab or Enum.Font.SourceSansBold
		TabButton.TextSize = info.TextSizeTab or 12
		TabButton.Parent = TabHeader

		local UICornerBtn = Instance.new("UICorner")
		UICornerBtn.CornerRadius = UDim.new(0,12)
		UICornerBtn.Parent = TabButton

		-- Scrolling Container
		local TabContainer = Instance.new("ScrollingFrame")
		TabContainer.Size = UDim2.new(1,0,1,0)
		TabContainer.BackgroundTransparency = 1
		TabContainer.Visible = false
		TabContainer.Parent = TabContent

		TabContainer.ScrollBarThickness = 4
		TabContainer.ScrollBarImageColor3 = Color3.fromRGB(110,110,110)
		TabContainer.CanvasSize = UDim2.new(0,0,0,0)
		TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
		TabContainer.ScrollingDirection = Enum.ScrollingDirection.Y
		TabContainer.ScrollBarImageTransparency = 1


		-- Layout agar toggle / input rapi
		local layout = Instance.new("UIListLayout")
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0,6)
		layout.Parent = TabContainer

		Tabs[name] = TabContainer

		local function UpdateTabButtonStyles()
			for tabName, tabFrame in pairs(Tabs) do
				local btn = nil
				for _, child in pairs(TabHeader:GetChildren()) do
					if child:IsA("TextButton") and child.Text == tabName then
						btn = child
						break
					end
				end
				if btn then
					if tabFrame == CurrentTab then
						btn.BackgroundColor3 = Color3.fromRGB(255,70,70)
						btn.TextColor3 = Color3.new(1,1,1)
					else
						btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
						btn.TextColor3 = Color3.new(1,1,1)
					end
				end
			end
		end

		TabButton.MouseButton1Click:Connect(function()
			for _, tab in pairs(Tabs) do
				tab.Visible = false
			end
			TabContainer.Visible = true
			CurrentTab = TabContainer
			UpdateTabButtonStyles()
		end)

		if not CurrentTab then
			CurrentTab = TabContainer
			TabContainer.Visible = true
			UpdateTabButtonStyles()
		end

		-- Tab API
		local TabAPI = {}
		
		function TabAPI:CreateTitle(info)
			local Title = Instance.new("Frame")
			Title.Size = UDim2.new(1,0,0,40)
			Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
			Title.BackgroundTransparency = info.BgTransparent or 0
			Title.Parent = TabContainer

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1,0,1,0)
			Label.BackgroundTransparency = 1
			Label.Text = info.Name or "Title"
			Label.TextColor3 = Color3.fromRGB(255,255,255)
			Label.TextSize = info.TextSize or 20
			Label.Font = ResolveFont(info.Font)

			--------------------------------------------------------------------
			-- ALIGN
			--------------------------------------------------------------------
			local align = info.Align or "Left"
			local alignMapX = {
				Left = Enum.TextXAlignment.Left,
				Center = Enum.TextXAlignment.Center,
				Right = Enum.TextXAlignment.Right,
			}

			Label.TextXAlignment = alignMapX[align] or Enum.TextXAlignment.Left

			if align == "Left" then
				Label.Position = UDim2.new(0,10,0,0)
			elseif align == "Center" then
				Label.Position = UDim2.new(0,0,0,0)
			elseif align == "Right" then
				Label.Position = UDim2.new(0,-10,0,0)
			end

			Label.Parent = Title

			return Title
		end

		function TabAPI:CreateToggle(info)
			info = info or {}
			local Item = Instance.new("Frame")
			Item.Size = UDim2.new(1,0,0,30)
			Item.BackgroundColor3 = Color3.fromRGB(30,30,30)
			Item.Parent = TabContainer

			-- Label di kiri
			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(0.7,0,1,0)
			Label.BackgroundTransparency = 1
			Label.Text = info.Name or "Toggle"
			Label.TextColor3 = Color3.fromRGB(230,230,230)
			Label.Font = ResolveFont(info.Font or GUI.DefaultLabel.Font)
			Label.TextSize = info.TextSize or GUI.DefaultLabel.TextSize
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Position = UDim2.new(0,15,0,0)
			Label.Parent = Item

			-- Toggle Frame di kanan
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Size = UDim2.new(0,50,0,22)
			ToggleFrame.Position = UDim2.new(1,-60,0,4)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(0,0,0) -- lebih gelap/transparent feel
			ToggleFrame.BackgroundTransparency = 0.7 -- bikin tipis, semi transparan
			ToggleFrame.Parent = Item
			ToggleFrame.ClipsDescendants = true

			local UICornerToggle = Instance.new("UICorner")
			UICornerToggle.CornerRadius = UDim.new(0,12)
			UICornerToggle.Parent = ToggleFrame
			
			local UIStrokeToggle = Instance.new("UIStroke")
			UIStrokeToggle.Color = Color3.fromRGB(180,180,180)
			UIStrokeToggle.Thickness = 1
			UIStrokeToggle.Transparency = 0.6
			UIStrokeToggle.Parent = ToggleFrame

			-- Circle toggle
			local ToggleCircle = Instance.new("Frame")
			ToggleCircle.Size = UDim2.new(0,18,0,18)
			ToggleCircle.Position = UDim2.new(0,2,0,2)
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(0, 193, 0) -- warna ON jadi lebih “tipis”
			ToggleCircle.Parent = ToggleFrame

			local UICornerCircle = Instance.new("UICorner")
			UICornerCircle.CornerRadius = UDim.new(1,0)
			UICornerCircle.Parent = ToggleCircle

			local state = false

			local function SetState(on)
				state = on
				if state then
					ToggleCircle:TweenPosition(UDim2.new(1, -20, 0, 2), "Out", "Quad", 0.2, true)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(0, 193, 0)
					if info.Callback then info.Callback(true) end
				else
					ToggleCircle:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Quad", 0.2, true)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(140,140,140)
					if info.CallbackOff then info.CallbackOff(false) end
				end
			end

			-- Klik toggle
			ToggleFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					SetState(not state)
				end
			end)

			return Item
		end
		
		function TabAPI:CreateTextInputButton(info)
			local Item = Instance.new("Frame")
			Item.Size = UDim2.new(1,0,0,65)
			Item.BackgroundColor3 = Color3.fromRGB(30,30,30)
			Item.Parent = TabContainer

			-- Label kiri
			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(0.6,0,0,30)
			Label.Position = UDim2.new(0,15,0,0)
			Label.BackgroundTransparency = 1
			Label.Text = info.Name or "Input Toggle"
			Label.TextColor3 = Color3.fromRGB(230,230,230)
			Label.Font = ResolveFont(info.Font or GUI.DefaultLabel.Font)
			Label.TextSize = info.TextSize or GUI.DefaultLabel.TextSize
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Item

			---------------------------------------------------
			--   TOGGLE STYLE PERSIS KAYAK CreateToggle()
			---------------------------------------------------
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Size = UDim2.new(0,50,0,22)
			ToggleFrame.Position = UDim2.new(1,-60,0,4)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
			ToggleFrame.BackgroundTransparency = 0.7
			ToggleFrame.ClipsDescendants = true
			ToggleFrame.Parent = Item

			local UICornerToggle = Instance.new("UICorner")
			UICornerToggle.CornerRadius = UDim.new(0,12)
			UICornerToggle.Parent = ToggleFrame

			local UIStrokeToggle = Instance.new("UIStroke")
			UIStrokeToggle.Color = Color3.fromRGB(180,180,180)
			UIStrokeToggle.Thickness = 1
			UIStrokeToggle.Transparency = 0.6
			UIStrokeToggle.Parent = ToggleFrame

			local ToggleCircle = Instance.new("Frame")
			ToggleCircle.Size = UDim2.new(0,18,0,18)
			ToggleCircle.Position = UDim2.new(0,2,0,2)
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(0,193,0)
			ToggleCircle.Parent = ToggleFrame

			local UICornerCircle = Instance.new("UICorner")
			UICornerCircle.CornerRadius = UDim.new(1,0)
			UICornerCircle.Parent = ToggleCircle

			---------------------------------------------------
			-- Input box di bawah
			---------------------------------------------------
			local InputBox = Instance.new("TextBox")
			InputBox.Size = UDim2.new(0, 80, 0, 22)  -- kecil (sama lebar dgn toggle)
			InputBox.Position = UDim2.new(1, -90, 0, 35)
			InputBox.PlaceholderText = info.Placeholder or "Type value..."
			InputBox.Text = info.CurrentValue and tostring(info.CurrentValue) or ""
			InputBox.BackgroundColor3 = Color3.fromRGB(100,100,100)
			InputBox.TextColor3 = Color3.new(1,1,1)
			InputBox.Font = Enum.Font.SourceSans
			InputBox.TextSize = 14
			InputBox.ClearTextOnFocus = false
			InputBox.Parent = Item

			local InputCorner = Instance.new("UICorner")
			InputCorner.CornerRadius = UDim.new(0,6)
			InputCorner.Parent = InputBox

			---------------------------------------------------
			-- LOGIC TOGGLE
			---------------------------------------------------
			local state = false

			local function SetState(on)
				state = on

				if state then
					-- Move to ON
					ToggleCircle:TweenPosition(UDim2.new(1,-20,0,2),"Out","Quad",0.2,true)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(0,193,0)

					if info.Callback then 
						info.Callback(true, InputBox.Text) 
					end

				else
					-- Move to OFF
					ToggleCircle:TweenPosition(UDim2.new(0,2,0,2),"Out","Quad",0.2,true)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(140,140,140)

					if info.CallbackOff then 
						info.CallbackOff(false) 
					end
				end
			end

			-- klik toggle
			ToggleFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					SetState(not state)
				end
			end)

			---------------------------------------------------
			-- optional: user input berubah -> kalau toggle ON maka apply otomatis
			---------------------------------------------------
			InputBox:GetPropertyChangedSignal("Text"):Connect(function()
				if state and info.Callback then
					info.Callback(true, InputBox.Text)
				end
			end)

			return {
				Frame = Item,
				Input = InputBox,
				SetState = SetState
			}
		end
		
		function TabAPI:CreateSliderToggle(info)
			local Item = Instance.new("Frame")
			Item.Size = UDim2.new(1,0,0,65)
			Item.BackgroundColor3 = Color3.fromRGB(30,30,30)
			Item.Parent = TabContainer

			-- Label kiri
			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(0.4,0,0,30)
			Label.Position = UDim2.new(0,15,0,0)
			Label.BackgroundTransparency = 1
			Label.Text = info.Name or "Slider Toggle"
			Label.TextColor3 = Color3.fromRGB(230,230,230)
			Label.Font = ResolveFont(info.Font or GUI.DefaultLabel.Font)
			Label.TextSize = info.TextSize or GUI.DefaultLabel.TextSize
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Item

			---------------------------------------------------
			-- TOGGLE STYLE
			---------------------------------------------------
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Size = UDim2.new(0,50,0,22)
			ToggleFrame.Position = UDim2.new(1,-60,0,4)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
			ToggleFrame.BackgroundTransparency = 0.7
			ToggleFrame.ClipsDescendants = true
			ToggleFrame.Parent = Item

			local UICornerToggle = Instance.new("UICorner")
			UICornerToggle.CornerRadius = UDim.new(0,12)
			UICornerToggle.Parent = ToggleFrame

			local UIStrokeToggle = Instance.new("UIStroke")
			UIStrokeToggle.Color = Color3.fromRGB(180,180,180)
			UIStrokeToggle.Thickness = 1
			UIStrokeToggle.Transparency = 0.6
			UIStrokeToggle.Parent = ToggleFrame

			local ToggleCircle = Instance.new("Frame")
			ToggleCircle.Size = UDim2.new(0,18,0,18)
			ToggleCircle.Position = UDim2.new(0,2,0,2)
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(0,193,0)
			ToggleCircle.Parent = ToggleFrame

			local UICornerCircle = Instance.new("UICorner")
			UICornerCircle.CornerRadius = UDim.new(1,0)
			UICornerCircle.Parent = ToggleCircle

			---------------------------------------------------
			-- SLIDER FULL WIDTH
			---------------------------------------------------
			local WrapperSlider = Instance.new("Frame")
			WrapperSlider.Size = UDim2.new(1, 0, 0, 65)
			WrapperSlider.Position = UDim2.new(0, 0, 0, 0)
			WrapperSlider.BackgroundTransparency = 1
			WrapperSlider.Parent  = Item
			
			local SliderFrame = Instance.new("Frame")
			SliderFrame.Size = UDim2.new(0.72, 0, 0, 6)
			SliderFrame.Position = UDim2.new(0.03, 0, 0, 45)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
			SliderFrame.Parent = WrapperSlider

			local SliderCorner = Instance.new("UICorner")
			SliderCorner.CornerRadius = UDim.new(0,6)
			SliderCorner.Parent = SliderFrame

			local SliderFill = Instance.new("Frame")
			SliderFill.Size = UDim2.new(0,0,1,0)
			SliderFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
			SliderFill.Parent = SliderFrame

			local SliderButton = Instance.new("Frame")
			SliderButton.Size = UDim2.new(0,20,0,20)
			SliderButton.AnchorPoint = Vector2.new(0, 0.35)
			SliderButton.BackgroundColor3 = Color3.fromRGB(0,120,255)
			SliderButton.Parent = SliderFrame

			local SliderButtonCorner = Instance.new("UICorner")
			SliderButtonCorner.CornerRadius = UDim.new(1,0)
			SliderButtonCorner.Parent = SliderButton

			local ValueLabel = Instance.new("TextLabel")
			ValueLabel.Size = UDim2.new(0,50,0,22)
			ValueLabel.Position = UDim2.new(1, -60, 0, 35)
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.TextColor3 = Color3.fromRGB(230,230,230)
			ValueLabel.Font = Enum.Font.SourceSans
			ValueLabel.TextSize = 14
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValueLabel.Text = tostring(info.CurrentValue or 0) .. (info.Suffix or "")
			ValueLabel.Parent = Item

			---------------------------------------------------
			-- LOGIC TOGGLE & SLIDER
			---------------------------------------------------
			local state = false
			local minVal = info.Range and info.Range[1] or 0
			local maxVal = info.Range and info.Range[2] or 100
			local increment = info.Increment or 1
			local sliderValue = info.CurrentValue or minVal
			local TweenService = game:GetService("TweenService")
			local RunService = game:GetService("RunService")

			local function UpdateSliderDisplay()
				local percent = (sliderValue - minVal) / (maxVal - minVal)
				local posX = percent * SliderFrame.AbsoluteSize.X

				local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				TweenService:Create(SliderButton, tweenInfo, {Position = UDim2.new(0, posX, 0, 0)}):Play()
				TweenService:Create(SliderFill, tweenInfo, {Size = UDim2.new(0, posX, 1, 0)}):Play()
				ValueLabel.Text = tostring(math.floor(sliderValue)) .. (info.Suffix or "")
			end

			local function SetState(on)
				state = on
				if state then
					ToggleCircle:TweenPosition(UDim2.new(1,-20,0,2),"Out","Quad",0.2,true)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(0,193,0)
					if info.Callback then info.Callback(sliderValue) end
				else
					ToggleCircle:TweenPosition(UDim2.new(0,2,0,2),"Out","Quad",0.2,true)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(140,140,140)
					if info.CallbackOff then info.CallbackOff() end
				end
			end

			ToggleFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					SetState(not state)
				end
			end)

			local dragging = false
			SliderButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)
			SliderButton.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)
			SliderFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)
			SliderFrame.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			RunService.RenderStepped:Connect(function()
				if dragging then
					local mouse = game.Players.LocalPlayer:GetMouse()
					local posX = math.clamp(mouse.X - SliderFrame.AbsolutePosition.X, 0, SliderFrame.AbsoluteSize.X)
					local percent = posX / SliderFrame.AbsoluteSize.X
					local rawValue = minVal + percent * (maxVal - minVal)
					sliderValue = math.floor(rawValue / increment + 0.5) * increment
					UpdateSliderDisplay()
					if state and info.Callback then
						info.Callback(sliderValue)
					end
				end
			end)

			-- simpan state asli frame utama
			local OriginalDraggable = MainFrame.Draggable
			local originalDraggableState = nil

			-- HOVER LOGIC (desktop)
			WrapperSlider.MouseEnter:Connect(function()
				if originalDraggableState == nil then
					originalDraggableState = MainFrame.Draggable
				end
				MainFrame.Draggable = false
			end)

			WrapperSlider.MouseLeave:Connect(function()
				if originalDraggableState ~= nil then
					MainFrame.Draggable = originalDraggableState
					originalDraggableState = nil
				end
			end)

			-- TOUCH LOGIC (mobile / touchscreen)
			WrapperSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Touch then
					if originalDraggableState == nil then
						originalDraggableState = MainFrame.Draggable
					end
					MainFrame.Draggable = false
				end
			end)

			WrapperSlider.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Touch then
					if originalDraggableState ~= nil then
						MainFrame.Draggable = originalDraggableState
						originalDraggableState = nil
					end
				end
			end)

			-- inisialisasi slider
			UpdateSliderDisplay()

			return {
				Frame = Item,
				SetState = SetState
			}
		end

		return TabAPI
	end

	return FrameAPI
end

return GUI