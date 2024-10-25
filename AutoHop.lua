local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local webhookUrl = "https://discord.com/api/webhooks/1299411759156822066/6twa5G6Jw7PBmNbQ6aHH14CdyZWvtpix9I0lSty09fVA_yPWwQ6vmJ96gZRgU1HUjMEp" -- Replace with your actual webhook URL

local function SendMessage(webhook, signalType)
    local fardplayer = Players.LocalPlayer
    local ExecutorWebhook = identifyexecutor() or "undefined" -- Replace with your method to get the executor type
    local timestamp = os.date("%Y-%m-%d %H:%M:%S") -- Current timestamp

    local msg = {
        ["content"] = "",
        ["username"] = fardplayer.Name ..
                    "",
        ["avatar_url"] = "https://images-ext-1.discordapp.net/external/SN9zgqCIgFRx4vco6NsGsf0QjfoCHf2Lj_k2R67EIIg/https/i.ibb.co/GWsnpph/xpng.png?format=webp&quality=lossless", -- Replace or customize your avatar URL
        ["embeds"] = {
            {
                ["title"] = "**💪 • Muscle Hop**",
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
                            timestamp .. "```",
                        ["inline"] = false
                    }
                },
                ["thumbnail"] = {
                    ["url"] = "https://images-ext-1.discordapp.net/external/SN9zgqCIgFRx4vco6NsGsf0QjfoCHf2Lj_k2R67EIIg/https/i.ibb.co/GWsnpph/xpng.png?format=webp&quality=lossless" -- Replace with actual image URL if needed
                }
            }
        },
        ["attachments"] = {}
    }

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

local function freezeAndCount()
    local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
    local freezeScreen = Instance.new("ScreenGui", playerGui)
    freezeScreen.Name = "CountdownScreen"
    local frame = Instance.new("Frame", freezeScreen)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.6
    frame.Visible = true

    local muscleLabel = Instance.new("TextLabel", frame)
    muscleLabel.Size = UDim2.new(0.4, 0, 0.1, 0)
    muscleLabel.Position = UDim2.new(0.3, 0, 0.3, 0)
    muscleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    muscleLabel.TextScaled = true
    muscleLabel.BackgroundTransparency = 1
    muscleLabel.Font = Enum.Font.FredokaOne
    muscleLabel.Text = "Muscle On Top!"

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.4, 0, 0.1, 0)
    label.Position = UDim2.new(0.3, 0, 0.45, 0)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.FredokaOne

    local stopButton = Instance.new("TextButton", frame)
    stopButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    stopButton.Position = UDim2.new(0.4, 0, 0.6, 0)
    stopButton.Text = "Stop Countdown"
    stopButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    stopButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    stopButton.Font = Enum.Font.FredokaOne
    stopButton.TextScaled = true

    local corner = Instance.new("UICorner", stopButton)
    corner.CornerRadius = UDim.new(0, 10)

    local countdownActive = true

    stopButton.MouseButton1Click:Connect(function()
        countdownActive = false
        label.Text = "Countdown Stopped"
        wait(2)
        freezeScreen:Destroy()
    end)

    -- Add the username text label
    local usernameLabel = Instance.new("TextLabel", frame)
    usernameLabel.Size = UDim2.new(1, 0, 0.1, 0)
    usernameLabel.Position = UDim2.new(0, 0, 0.9, 0) -- Position at the bottom center
    usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    usernameLabel.TextScaled = true
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.Font = Enum.Font.FredokaOne
    usernameLabel.Text = Players.LocalPlayer.Name .. " is using Auto Hop"

    SendMessage(webhookUrl) -- Call to send details to the webhook

    for i = 1, 120 do
        if countdownActive then
            label.Text = tostring(i)
            wait(1)
        end
    end

    if countdownActive then
        label.Text = "Hopping Now"
        wait(2)

        local placeId = game.PlaceId
        TeleportService:Teleport(placeId, Players.LocalPlayer)
    end
end

freezeAndCount()
