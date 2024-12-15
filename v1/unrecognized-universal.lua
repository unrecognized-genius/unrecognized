local player = game.Players.LocalPlayer

local function onCharacterAdded(character)
    local gui = player.PlayerGui:FindFirstChild("MenuGui")
    if not gui then
        local newGui = script.YourGui:Clone()
        newGui.Parent = player.PlayerGui
    end
end

player.CharacterAdded:Connect(onCharacterAdded)



local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenuGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MenuFrame"
frame.Size = UDim2.new(0.5, 0, 0.5, 0) 
frame.Position = UDim2.new(0.25, 0, 0.25, 0) 
frame.BackgroundColor3 = Color3.new(0, 0, 0) 
frame.BackgroundTransparency = 0.25 
frame.Active = true 
frame.Draggable = true 
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0.05, 0) 
titleLabel.Position = UDim2.new(0, 0, 0, 0) 
titleLabel.BackgroundTransparency = 1 titleLabel.Text = "unrecognized"
titleLabel.TextColor3 = Color3.new(1, 1, 1) titleLabel.TextScaled = true titleLabel.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0) closeButton.Position = UDim2.new(0.9, 0, 0, 0) closeButton.BackgroundColor3 = Color3.new(1, 0, 0) closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1) closeButton.TextScaled = true closeButton.Parent = frame

local function closeMenu()
    frame.Visible = false
end

closeButton.MouseButton1Click:Connect(closeMenu)





local espNameButton = Instance.new("TextButton")
espNameButton.Name = "ESPNameButton"
espNameButton.Size = UDim2.new(0.2, 0, 0.1, 0) espNameButton.Position = UDim2.new(0.01, 1, 0, 15) espNameButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) espNameButton.Text = "Toggle ESP Name"
espNameButton.TextColor3 = Color3.new(1, 1, 1) espNameButton.TextScaled = true espNameButton.Parent = frame

local function createESPName(player)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESPName"
    billboardGui.Adornee = player.Character:WaitForChild("Head")
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1)     textLabel.TextScaled = false     textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = billboardGui

    billboardGui.Parent = player.Character:WaitForChild("Head")
end

local function removeESPName(player)
    local head = player.Character:FindFirstChild("Head")
    if head then
        local billboardGui = head:FindFirstChild("ESPName")
        if billboardGui then
            billboardGui:Destroy()
        end
    end
end

local espNameVisible = false

local function toggleESPName()
    espNameVisible = not espNameVisible
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            if espNameVisible then
                createESPName(player)
            else
                removeESPName(player)
            end
        end
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        player.CharacterAdded:Connect(function()
            if espNameVisible then
                createESPName(player)
            end
        end)
    end
end)

espNameButton.MouseButton1Click:Connect(toggleESPName)





local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Size = UDim2.new(0.2, 0, 0.1, 0) espButton.Position = UDim2.new(0.01, 95, 0, 15) espButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) espButton.Text = "Toggle ESP BOX"
espButton.TextColor3 = Color3.new(1, 1, 1) espButton.TextScaled = true espButton.Parent = frame

local espEnabled = false
local espBoxes = {}

local function createESPBox(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.new(1, 0, 0)     box.Thickness = 2
    box.Filled = false
    espBoxes[player] = box

    local function updateBox()
        if espEnabled then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character.Humanoid.Health > 0 then
                local rootPart = character.HumanoidRootPart
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    box.Size = Vector2.new(2000 / screenPos.Z, 4000 / screenPos.Z)                     box.Position = Vector2.new(screenPos.X - box.Size.X / 2, screenPos.Y - box.Size.Y / 2)
                    box.Visible = true
                else
                    box.Visible = false
                end
            else
                box.Visible = false
            end
        else
            box.Visible = false
        end
    end

    game:GetService("RunService").RenderStepped:Connect(updateBox)
end

local function toggleESP()
    espEnabled = not espEnabled
    for _, box in pairs(espBoxes) do
        box.Visible = espEnabled
    end
    if espEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createESPBox(player)
            end
        end
    end
end

espButton.MouseButton1Click:Connect(toggleESP)

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        player.CharacterAdded:Connect(function()
            createESPBox(player)
        end)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    if espBoxes[player] then
        espBoxes[player]:Remove()
        espBoxes[player] = nil
    end
end)



local partButton = Instance.new("TextButton")
partButton.Name = "PartButton"
partButton.Size = UDim2.new(0.2, 0, 0.1, 0) partButton.Position = UDim2.new(0.01, 190, 0, 15) partButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) partButton.Text = "Create Part"
partButton.TextColor3 = Color3.new(1, 1, 1) partButton.TextScaled = true partButton.Parent = frame

local function placePartUnderPlayer()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local rootPart = character.HumanoidRootPart
        local part = Instance.new("Part")
        part.Size = Vector3.new(10, 2, 10)         
        part.Position = rootPart.Position - Vector3.new(0, rootPart.Size.Y / 2 + part.Size.Y / 2, 0)         part.Anchored = true         part.Parent = workspace
    end
end

partButton.MouseButton1Click:Connect(placePartUnderPlayer)



local speedButton = Instance.new("TextButton")
speedButton.Name = "SpeedButton"
speedButton.Size = UDim2.new(0.2, 0, 0.1, 0) speedButton.Position = UDim2.new(0.01, 280, 0, 15) speedButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) speedButton.Text = "Boost Speed 2x"
speedButton.TextColor3 = Color3.new(1, 1, 1) speedButton.TextScaled = true speedButton.Parent = frame

local normalWalkSpeed = 16 local boostedWalkSpeed = 32 local speedBoosted = false

local function toggleSpeed()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        if speedBoosted then
            humanoid.WalkSpeed = normalWalkSpeed
        else
            humanoid.WalkSpeed = boostedWalkSpeed
        end
        speedBoosted = not speedBoosted
    end
end

speedButton.MouseButton1Click:Connect(toggleSpeed)



local jumpButton = Instance.new("TextButton")
jumpButton.Name = "JumpButton"
jumpButton.Size = UDim2.new(0.2, 0, 0.1, 0) jumpButton.Position = UDim2.new(0.01, 1, 0, 40) jumpButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) jumpButton.Text = "Jump Boost 2x"
jumpButton.TextColor3 = Color3.new(1, 1, 1) jumpButton.TextScaled = true jumpButton.Parent = frame

local normalJumpPower = 50 local boostedJumpPower = 100 local jumpBoosted = false

local function toggleJumpPower()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        if jumpBoosted then
            humanoid.JumpPower = normalJumpPower
        else
            humanoid.JumpPower = boostedJumpPower
        end
        jumpBoosted = not jumpBoosted
    end
end

jumpButton.MouseButton1Click:Connect(toggleJumpPower)



local killSelfButton = Instance.new("TextButton")
killSelfButton.Name = "KillSelfButton"
killSelfButton.Size = UDim2.new(0.2, 0, 0.1, 0) killSelfButton.Position = UDim2.new(0.01, 95, 0, 40) killSelfButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) killSelfButton.Text = "Kill"
killSelfButton.TextColor3 = Color3.new(1, 1, 1) killSelfButton.TextScaled = true killSelfButton.Parent = frame

local function killSelf()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").Health = 0
    end
end

killSelfButton.MouseButton1Click:Connect(killSelf)
