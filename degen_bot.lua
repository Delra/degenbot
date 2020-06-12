local discordia = require('discordia')
local env = require("environment")
local client = discordia.Client()

-- A discord bot for some basic moderation. We'll start with message deletion. 

function table.contains(t, c)
    for _, value in ipairs(t) do 
        if value == c then return true end
    end
end

function isModeratedChannel(id)
    local channels = {
        "525949758758584375",
        "598510136637521921",
        "525948955985444865",
        "525948930232680448",
    }
    return table.contains(channels, id)
end

function lewdNoLewds(msg)
    local lewds = {
        "525948955985444865",
        "598510136637521921",
        "525948930232680448",
    }
    if table.contains(lewds, msg.channel.id) and msg.attachments then return false end
    return true
end

function checkForDeletion(msg)
    if isModeratedChannel(msg.channel.id) and lewdNoLewds(msg) then
        msg:delete()
    end
end

client:on('messageCreate', checkForDeletion)

client:run('Bot '..env.token)