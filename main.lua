local LIE = RegisterMod('Ludovico is everywhere', 1)
local challenge = Isaac.GetChallengeIdByName('Ludovico is everywhere')

LIE.replaceableItemPools = {
    [ItemPoolType.POOL_TREASURE]     = {},
    [ItemPoolType.POOL_SHOP]         = {},
    [ItemPoolType.POOL_DEVIL]        = {},
    [ItemPoolType.POOL_ANGEL]        = {},
    [ItemPoolType.POOL_GOLDEN_CHEST] = {},
    [ItemPoolType.POOL_RED_CHEST]    = {},
    [ItemPoolType.POOL_CURSE]        = {},
    [ItemPoolType.POOL_GREED_SHOP]   = {},
    [ItemPoolType.POOL_GREED_DEVIL]  = {},
    [ItemPoolType.POOL_GREED_ANGEL]  = {},
    [ItemPoolType.POOL_GREED_CURSE]  = {},
    [ItemPoolType.POOL_CRANE_GAME]   = {},
    [ItemPoolType.POOL_PLANETARIUM]  = {},
    [ItemPoolType.POOL_OLD_CHEST]    = {},
    [ItemPoolType.POOL_BABY_SHOP]    = {},
    [ItemPoolType.POOL_WOODEN_CHEST] = {},
}

function LIE:tryReplaceCollectible(itemPoolType, _, _)
    if (Game().Challenge == challenge) and LIE.replaceableItemPools[itemPoolType] then 
        -- You know what? Hell yeah.
        return CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE
    else
        return nil
    end
end

LIE:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, LIE.tryReplaceCollectible)