local UserGameSettings = UserSettings():GetService("UserGameSettings")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Terrain = workspace.Terrain

UserGameSettings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
UserGameSettings.MasterVolume = 0.5

Lighting.GlobalShadows = false
Lighting.ShadowSoftness = 0
Lighting.Brightness = 2
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

Lighting.Bloom.Enabled = false
Lighting.Blur.Enabled = false
Lighting.ColorCorrection.Enabled = false
Lighting.SunRays.Enabled = false

RunService.ThrottleFramerateEnabled = true
RunService.ThrottleFramerate = 30

if Terrain then
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 0.9
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.GrassEnabled = false
    Terrain.DetailLevel = Enum.DetailLevel.Low
    Terrain.Decoration = false
    Terrain.MaxExtents = Vector3.new(1000, 1000, 1000)
end

for _, particle in ipairs(workspace:GetDescendants()) do
    if particle:IsA("ParticleEmitter") then
        particle.Rate = math.floor(particle.Rate / 2)
    end
end

for _, texture in ipairs(workspace:GetDescendants()) do
    if texture:IsA("Texture") then
        texture.TextureQuality = Enum.TextureQuality.Low
    end
end

local player = Players.LocalPlayer
if player then
    local character = player.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Plastic
                part.Reflectance = 0
            end
        end
    end
end

workspace.CurrentCamera:SetAttribute("MaxZoomDistance", 100)
workspace.CurrentCamera:SetAttribute("MinZoomDistance", 10)

for _, model in ipairs(workspace:GetDescendants()) do
    if model:IsA("Model") then
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Plastic
                part.Reflectance = 0
            end
        end
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Material == Enum.Material.Neon then
        obj.Material = Enum.Material.Plastic
    end
end

Lighting.GlobalShadows = false
Lighting.ShadowSoftness = 0
Lighting.GeographicLatitude = 0
Lighting.ClockTime = 12
Lighting.FogEnd = 0
Lighting.FogStart = 0