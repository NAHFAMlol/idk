-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = game.Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configuration
local AimbotEnabled = false
local AimbotKey = Enum.KeyCode.E
local AimbotStatusLabel = nil -- Placeholder for status label
local AimbotHotkeyBox = nil -- Placeholder for hotkey input box

-- UI Configuration
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.new(0, 0, 0) -- Black color
TopBar.BackgroundTransparency = 0.5 -- Transparent
TopBar.BorderSizePixel = 0
TopBar.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 20)
TitleLabel.Position = UDim2.new(0, 0, 0, 5)
TitleLabel.Text = "Destructive Aimbot V2"
TitleLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text color
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.Parent = TopBar

AimbotStatusLabel = Instance.new("TextLabel")
AimbotStatusLabel.Size = UDim2.new(1, 0, 0, 20)
AimbotStatusLabel.Position = UDim2.new(0, 0, 0, 25)
AimbotStatusLabel.Text = "Aimbot: OFF"
AimbotStatusLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text color
AimbotStatusLabel.BackgroundTransparency = 1
AimbotStatusLabel.Font = Enum.Font.SourceSans
AimbotStatusLabel.TextSize = 14
AimbotStatusLabel.Parent = TopBar

local BottomBar = Instance.new("Frame")
BottomBar.Size = UDim2.new(1, 0, 0, 50)
BottomBar.Position = UDim2.new(0, 0, 1, -50)
BottomBar.BackgroundColor3 = Color3.new(0, 0, 0) -- Black color
BottomBar.BackgroundTransparency = 0.5 -- Transparent
BottomBar.BorderSizePixel = 0
BottomBar.Parent = ScreenGui

local HotkeyLabel = Instance.new("TextLabel")
HotkeyLabel.Size = UDim2.new(0, 100, 0, 20)
HotkeyLabel.Position = UDim2.new(0, 10, 0, 15)
HotkeyLabel.Text = "Aimbot Hotkey:"
HotkeyLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text color
HotkeyLabel.BackgroundTransparency = 1
HotkeyLabel.Font = Enum.Font.SourceSans
HotkeyLabel.TextSize = 14
HotkeyLabel.Parent = BottomBar

AimbotHotkeyBox = Instance.new("TextBox")
AimbotHotkeyBox.Size = UDim2.new(0, 100, 0, 20)
AimbotHotkeyBox.Position = UDim2.new(0, 120, 0, 15)
AimbotHotkeyBox.Text = AimbotKey.Name
AimbotHotkeyBox.TextColor3 = Color3.new(1, 0, 0) -- Red text color
AimbotHotkeyBox.BackgroundTransparency = 0.5 -- Transparent
AimbotHotkeyBox.BackgroundColor3 = Color3.new(0, 0, 0) -- Black color
AimbotHotkeyBox.Font = Enum.Font.SourceSans
AimbotHotkeyBox.TextSize = 14
AimbotHotkeyBox.Parent = BottomBar

-- Function to find the closest visible player
local function findClosestTarget()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if distance <= 100 then -- Adjust this distance as needed
                -- Check if player is visible in the camera view and not behind a wall
                local direction = (player.Character.HumanoidRootPart.Position - Camera.CFrame.Position).unit
                local ray = Ray.new(Camera.CFrame.Position, direction * 100)
                local part, hitPos = game.Workspace:FindPartOnRay(ray, LocalPlayer.Character, false, true)

                if part and part:IsDescendantOf(player.Character) then
                    -- No FOV check needed in this version
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end

    return closestPlayer, shortestDistance
end

-- Function to aim at the target
local function aimAtTarget()
    local TargetPlayer, _ = findClosestTarget()
    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = TargetPlayer.Character.HumanoidRootPart.Position
        local lookVector = (targetPos - Camera.CFrame.Position).unit

        -- Set camera CFrame to look at the target
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + lookVector)
    end
end

-- Function to toggle aimbot on/off
local function toggleAimbot()
    AimbotEnabled = not AimbotEnabled
    if AimbotEnabled then
        AimbotStatusLabel.Text = "Aimbot: ON"
        AimbotStatusLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text color
        print("Aimbot enabled")
    else
        AimbotStatusLabel.Text = "Aimbot: OFF"
        AimbotStatusLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text color
        print("Aimbot disabled")
    end
end

-- Function to update aimbot hotkey
local function updateAimbotHotkey()
    local newHotkey = AimbotHotkeyBox.Text
    local newKeyCode = Enum.KeyCode[newHotkey]
    if newKeyCode then
        AimbotKey = newKeyCode
        print("Aimbot hotkey changed to:", newHotkey)
    else
        AimbotHotkeyBox.Text = AimbotKey.Name
        print("Invalid hotkey. Please enter a valid key.")
    end
end

-- Connect focus lost event for aimbot hotkey box
AimbotHotkeyBox.FocusLost:Connect(updateAimbotHotkey)

-- Function to handle input for toggling aimbot
local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == AimbotKey then
        toggleAimbot()
    end
end

-- Connect input event for toggling aimbot
UserInputService.InputBegan:Connect(onInputBegan)

-- Function to run the aimbot
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        aimAtTarget()
    end
end)
