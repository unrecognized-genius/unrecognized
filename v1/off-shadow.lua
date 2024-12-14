
local lighting = game:GetService("Lighting")

lighting.GlobalShadows = false
lighting.Brightness = 2 
lighting.Ambient = Color3.new(1, 1, 1) 
lighting.OutdoorAmbient = Color3.new(1, 1, 1)

lighting.FogEnd = 1000000 
lighting.FogStart = 1000000
lighting.FogColor = Color3.new(1, 1, 1) 

lighting.Technology = Enum.Technology.Compatibility 
lighting.ShadowSoftness = 0

for _, child in pairs(lighting:GetChildren()) do
    if child:IsA("PostEffect") then
        child:Destroy() 
    end
end

for _, descendant in pairs(workspace:GetDescendants()) do
    if descendant:IsA("BasePart") then
        descendant.CastShadow = false
    end
end
