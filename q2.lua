-- Make sure these are imported at the top of the file
local db, result = require("db"), require("result")

-- this method is supposed to print names of all guilds that have less than memberCount max members
function printSmallGuildNames(memberCount)    
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    if resultId then
        repeat
            local guildName = result.getString(resultId, "name")
            print(guildName)
        until not result.next(resultId)
    end
end