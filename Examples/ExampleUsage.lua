local ADDHub = require(game.ReplicatedStorage.ADDHubTemplate)

-- Inisialisasi
ADDHub:Init()

-- Buat Tabs
local mainTab = ADDHub:AddTab("MAIN")
local espTab = ADDHub:AddTab("ESP")
local pvpTab = ADDHub:AddTab("PVP")

ADDHub:ShowTab("MAIN")

-- Tambah Button
ADDHub:AddButton("MAIN", "Hello", function() print("Button ditekan!") end)

-- Tambah Toggle
ADDHub:AddToggle("ESP", "ESP Players", function(state) print("ESP Players:", state) end)

-- Tambah Input
ADDHub:AddInput("MAIN", "Ketik nama...", function(text) print("Input:", text) end)

-- Tambah Dropdown
ADDHub:AddDropdown("PVP", "Pilih Senjata", {"Pistol","Rifle","Sword"}, function(opt)
    print("Dipilih:", opt)
end)
