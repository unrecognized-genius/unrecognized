local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local currentPosition = humanoidRootPart.Position
local newPosition = currentPosition + Vector3.new(0, 1000, 0) 

local platform = Instance.new("Part")
platform.Size = Vector3.new(50, 1, 50) 
platform.Position = newPosition - Vector3.new(0, 3, 0) 
platform.Anchored = true 
platform.Color = Color3.fromRGB(0, 0, 0) 
platform.Name = "TeleportPlatform"
platform.Parent = workspace

humanoidRootPart.CFrame = CFrame.new(newPosition)
