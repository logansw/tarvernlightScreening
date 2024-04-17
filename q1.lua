-- Constant value that represents the index of the player's logged in status
-- Not sure if there's convention for this, but I decided to prefix it with SV_ to indicate that
-- it's a storage value, with the idea that all storage value indices are prefixed with "SV_"
local SV_LOGGED_IN_INDEX = 1000
-- Another constant value that represents the delay time before the player's storage is released,
-- because magic numbers lack semantic meaning. I think it's a delay? I'm not actually sure why
-- there would need to be one, but maybe some other systems rely on it. Since I don't know, I'll
-- just leave it as is. 
local LOG_OUT_DELAY = 1000

-- Called when the player logs out
function onLogout(player)
    if player:getStorageValue(SV_LOGGED_IN_INDEX) == 1 then
        addEvent(releaseStorage, LOG_OUT_DELAY, player)
    end
    return true
end

-- Marks the specified player's storage as released
local function releaseStorage(player)
    player:setStorageValue(SV_LOGGED_IN_INDEX, -1)
end