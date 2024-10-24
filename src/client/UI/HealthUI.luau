local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create Health Bar UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HealthBarUI"
screenGui.Parent = playerGui

local healthBarBackground = Instance.new("Frame")
healthBarBackground.Name = "HealthBarBackground"
healthBarBackground.Size = UDim2.new(0.3, 0, 0.05, 0)
healthBarBackground.Position = UDim2.new(0.5, -150, 0.05, 0)
healthBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
healthBarBackground.BorderSizePixel = 0
healthBarBackground.Parent = screenGui

local healthBar = Instance.new("Frame")
healthBar.Name = "HealthBarFill"
healthBar.Size = UDim2.new(1, 0, 1, 0)
healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
healthBar.BorderSizePixel = 0
healthBar.Parent = healthBarBackground

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
})
uiGradient.Parent = healthBar

local function updateHealth(health)
    local maxHealth = 100
    local healthPercent = math.clamp(health / maxHealth, 0, 1)
    
    -- Tween the health bar size for smooth depletion
    TweenService:Create(healthBar, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = UDim2.new(healthPercent, 0, 1, 0)
    }):Play()
end

-- Initialize Health Bar based on current health
local function initializeHealthBar(character)
    local humanoid = character:WaitForChild("Humanoid")
    updateHealth(humanoid.Health)
    
    -- Update health bar when health changes
    humanoid.HealthChanged:Connect(updateHealth)
end

-- Setup health bar for the current character
if player.Character then
    initializeHealthBar(player.Character)
end

-- Connect to CharacterAdded to handle respawns
player.CharacterAdded:Connect(initializeHealthBar)
