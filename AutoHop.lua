print("Debug Testing")
local function onPlayerChat(player, message)
    if message:lower() == "hi" then
        print("Detected 'hi', waiting for 10 seconds before server hopping...")
        wait(10)  -- Wait for 10 seconds
        local teleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        -- Teleport the player back to the same game (this effectively serves as server hopping)
        teleportService:Teleport(placeId, player)
    end
end

-- Connect to the player's chat when they join the game
game.Players.PlayerAdded:Connect(function(player)
    -- Connect to the player's chat events
    player.Chatted:Connect(function(message)
        onPlayerChat(player, message)
    end)
end)
