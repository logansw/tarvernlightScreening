-- CHANGES AND RATIONALE:
-- Fixed the method name to be more descriptive, and I decided to do camelCase because the
-- other methods from q1 and q2 were in camelCase. Whatever the convention, consistency is
-- key!
-- Added nil checks for player, party, and memberToRemove. It's always good to check for nil values before
-- doing anything with them, and to throw appropriately desriptive errors so that the errors
-- can be traced more easily. 
-- We already made a player object at the start of the function, so later in party:removeMember
-- we can just reuse that instead of creating a new player object.
-- Added a tiny optimization where the loop to find the member in the party breaks once that member is
-- found and removed
function removeMemberFromParty(playerId, memberName)
    player = Player(playerId)
    if not player then  -- player nil check
        error("Player not found")
        return
    end

    local party = player:getParty()
    if not party then   -- party nil check
        error("Party not found")
        return
    end

    local memberToRemove = Player(memberName)
    if not memberToRemove then  -- memberToRemove nil check
        error("Member not found")
        return
    end
    
    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
            party:removeMember(player)
            break
        end
    end
end