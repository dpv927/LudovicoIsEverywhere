local LIE = RegisterMod('Ludovico is everywhere', 1)

LIE.anitation_time = 3000
LIE.dialog_fade = 0.01
LIE.fade_start = 1500
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

local function startAnimation(animate_sad)
    LIE.animate_isaac = true
    LIE.animate_sad = animate_sad
    LIE.dialog_opacity = 1
    LIE.animation_start = Isaac.GetTime()
end

function LIE:tryReplaceCollectible(itemPoolType, _, _) 
    if LIE.replaceableItemPools[itemPoolType] then 
        -- You know what? Hell yeah.
        Game():GetPlayer(0):AnimateHappy()
        startAnimation(false)
        return CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE
    else
        Game():GetPlayer(0):AnimateSad()
        startAnimation(true)
        return nil
    end
end

function LIE:tryIsaacTalk()
    if LIE.animate_isaac then
        local position = Isaac.GetPlayer(0).Position
        local message = nil

        if LIE.animate_sad then
	        position.X = position.X - 80
	        position.Y = position.Y - 80
            message = "Where is Ludovico?"
        else
            position.X = position.X - 40
	        position.Y = position.Y - 80
            message = "Hell yes!"
        end

        local renderpos = Isaac.WorldToScreen(position)
        Isaac.RenderText(message, renderpos.X, renderpos.Y, 1,1,1, LIE.dialog_opacity)

        local time_diff =  Isaac.GetTime() - LIE.animation_start

        if time_diff > LIE.anitation_time then
            LIE.animate_isaac = false
            return
        end

        if (time_diff > LIE.fade_start) and (LIE.dialog_opacity >= 0) then
            LIE.dialog_opacity = LIE.dialog_opacity - LIE.dialog_fade
        end
    end
end

LIE:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, LIE.tryReplaceCollectible)
LIE:AddCallback(ModCallbacks.MC_POST_RENDER,         LIE.tryIsaacTalk)