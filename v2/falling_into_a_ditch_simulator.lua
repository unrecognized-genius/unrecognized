local startPosition = Vector3.new(3.2, 2000.5, -21.7)
local fallSpeed = 1500 
local deathCheckDelay = 0.1 

local player = game.Players.LocalPlayer

local function startFalling()
    while true do
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        
        humanoidRootPart.CFrame = CFrame.new(startPosition)
        
        while character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 do
            humanoidRootPart.CFrame = humanoidRootPart.CFrame - Vector3.new(0, fallSpeed * deathCheckDelay, 0)
            wait(deathCheckDelay)
        end
        
        player.CharacterAdded:Wait()
        wait(0.5)
    end
end

startFalling()
