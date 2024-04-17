/*  CHANGES AND RATIONALE:
    Whenever the new keyword is used, memory is allocated so we need to make sure we delete
    objects when we're done using them.

    One assumption I'm making is that if a new player is created, it will continue to be used
    after this method has completed. I'm assuming that loadPlayerByName loads up some references
    to the player object, so I don't want to delete it yet. There should probably be some other
    method elsewhere that is called when the player exits the game that unloads everything, at
    which point the memory should be freed up then.

    If the loading is successful and the item creation fails, I think we probably still want to
    have the reference to the player to use later, so I decided not to free up the memory then.

    One other thing to check in the full codebase would be to make sure the Item has an appropriate
    destructor. I can't say how I should handle the cleanup because it depends on the details of
    CreateItem(), but that would be a good place to check if there are still memory leaks.
*/

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool newPlayerCreated = false;
    if (!player) {
        player = new Player(nullptr);
        newPlayerCreated = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;  // Free memory if loading the player fails
            return;
        }
    }
    Item* item = Item::CreateItem(itemId);
        if (!item) {
            return;
        }
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}