-- References
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

-- GUI Setup
local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local StopButton = Instance.new("TextButton")
local ResumeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local TimerLabel = Instance.new("TextLabel")

local countdownTime = 60 -- Set the countdown time in seconds
local remainingTime = countdownTime -- Variable to keep track of remaining time
local isCountingDown = true -- Flag to control the countdown
local PlaceIDToTeleport = 142823291 -- Replace with the actual PlaceId you want to teleport to

-- Properties for ScreenGui
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Properties for Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.5

-- Create Timer Label
TimerLabel.Parent = Frame
TimerLabel.Size = UDim2.new(1, 0, 0, 70)
TimerLabel.Position = UDim2.new(0, 0, 0.55, -35)
TimerLabel.BackgroundTransparency = 1
TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerLabel.TextScaled = true
TimerLabel.Font = Enum.Font.FredokaOne
TimerLabel.Text = tostring(remainingTime)

-- Create Rounded Corners for Frame
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 20)

-- Function to create buttons with rounded corners and hover effects
local function createButton(text, position, parent)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(0, 90, 0, 40)
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Create Rounded Corners for Button
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 10)

    -- Add mouse enter and leave events for color changing
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    end)

    return button
end

-- Create buttons
StopButton = createButton("Stop", UDim2.new(0, 32, 0, 20), Frame)
CloseButton = createButton("Close", UDim2.new(0, 180, 0, 20), Frame)
ResumeButton = createButton("Resume", UDim2.new(0, 110, 0, 20), Frame)

-- Button functionalities
StopButton.MouseButton1Click:Connect(function()
    print("Stop Button Clicked")
    isCountingDown = false -- Stop the countdown
    StopButton.Text = "Stopped"
end)

ResumeButton.MouseButton1Click:Connect(function()
    print("Resume Button Clicked")
    isCountingDown = true -- Resume the countdown
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- Closes the GUI
end)

-- Countdown Timer Logic
spawn(function()
    while remainingTime > 0 do
        wait(1) -- Wait for 1 second
        if isCountingDown then
            remainingTime = remainingTime - 1
            TimerLabel.Text = tostring(remainingTime) -- Update timer label
        end
    end

    -- When the countdown reaches 0
    if remainingTime <= 0 then
        TimerLabel.Text = "Time's Up!"
        StopButton.TextColor3 = Color3.fromRGB(255, 0, 0) -- Change the color of the Stop button
        
        -- Teleport to the specific PlaceId
        local teleportSuccess, teleportError = pcall(function()
            TeleportService:Teleport(PlaceIDToTeleport, player) -- Teleport the player to the specified PlaceId
        end)

        if not teleportSuccess then
            warn("Teleport failed: " .. teleportError) -- Warn if teleportation failed
        end
    end
end)
