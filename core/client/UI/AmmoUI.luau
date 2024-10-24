    // Start Generation Here
    -- Ammo Bar UI Creation
    local function createAmmoBarUI(player)

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- Create Ammo Bar Background
    local ammoBarBackground = Instance.new("Frame")
    ammoBarBackground.Name = "AmmoBarBackground"
    ammoBarBackground.Size = UDim2.new(0.2, 0, 0.03, 0)
    ammoBarBackground.Position = UDim2.new(0.5, -100, 0.95, -30)
    ammoBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ammoBarBackground.BorderSizePixel = 0
    ammoBarBackground.Parent = playerGui:WaitForChild("HUD")

    -- Create Ammo Bar Fill
    local ammoBarFill = Instance.new("Frame")
    ammoBarFill.Name = "AmmoBarFill"
    ammoBarFill.Size = UDim2.new(1, 0, 1, 0)
    ammoBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    ammoBarFill.BorderSizePixel = 0
    ammoBarFill.Parent = ammoBarBackground

    -- Function to update Ammo Bar
    local function updateAmmoBar(currentAmmo, maxAmmo)
        local ammoRatio = currentAmmo / maxAmmo
        ammoBarFill:TweenSize(UDim2.new(ammoRatio, 0, 1, 0), "Out", "Quad", 0.2, true)
    end

    -- Connect to ammo update event
    local ammoUpdateEvent = ReplicatedStorage:WaitForChild("AmmoUpdate") -- Replace with actual event name
    ammoUpdateEvent.OnClientEvent:Connect(function(currentAmmo, maxAmmo)
        updateAmmoBar(currentAmmo, maxAmmo)
    end)
    
    local Players = game:GetService("Players")
    Players.PlayerAdded:Connect(function(player)
        createAmmoBarUI(player)
    end)
    -- Initialize Ammo Bar with default values
    updateAmmoBar(30, 90) -- Example initial ammo
