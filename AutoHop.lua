-- The game ID to hop to
local gameId = 142823291

-- Function to freeze the game for a specified duration
local function freezeGame(duration)
    -- You can just use wait here since freezing the game using character removal is not ideal
    wait(duration)
end

-- Function to hop to a new server
local function hopToServer()
    freezeGame(2) -- Freeze the game for 2 seconds
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
