-- The game ID to hop to
local gameId = 142823291 -- Replace with the actual game ID you want to hop to

-- Function to freeze the game for a specified duration
local function freezeGame(duration)
    -- Just a wait function since actually freezing the game is not recommended
    wait(duration)
end

-- Function to hop to a new server
local function hopToServer()
    freezeGame(2) -- Freeze the game for 2 seconds before hopping
    wait(8) -- Wait for an additional 8 seconds (total of 10 seconds) before hopping
    game:GetService("TeleportService"):Teleport(gameId) -- Teleport to the specified game ID
end

-- Function to set up chat listener
local function onChatMessage(player, message)
    if message:lower() == "hi" then -- Check if the message is "hi" (case insensitive)
        hopToServer() -- Call the server hop function
    end
end

-- Connect the chat listener to the player's Chatted event
game.Players.LocalPlayer.Chatted:Connect(function(message)
    onChatMessage(game.Players.LocalPlayer, message) -- Pass the player and message to the handler
end)
