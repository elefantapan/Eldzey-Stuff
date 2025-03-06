SMODS.PokerHandPart {
    key = '6',
    func = function(hand) return get_X_same(6, hand, true) end
}

SMODS.PokerHandPart {
    key = "SuperStraight",
    func = function(hand)
        return get_straight(hand, 6, false, false)
    end
}

SMODS.PokerHand {
    key = "Super Straight",
    chips = 280,
    mult = 20,
    l_chips = 60,
    l_mult = 6,
    example = {
        { 'S_K', true},
        { 'H_Q', true},
        { 'C_J', true},
        { 'D_T', true},
        { 'S_9', true},
        { 'H_8', true}
    },
    loc_txt = {
         name = 'Super Straight',
        description = {
            'Six cards with consecutive ranks'
        }
    },
    evaluate = function(parts, hand)
            return parts.crjk_SuperStraight
    end
}

SMODS.PokerHand {
    key = "Six of a kind",
    chips = 240,
    mult = 18,
    l_chips = 60,
    l_mult = 6,
    example = {
        { 'S_K', true},
        { 'H_K', true},
        { 'C_K', true},
        { 'D_K', true},
        { 'S_K', true},
        { 'H_K', true}
    },
    loc_txt = {
         name = 'Six of a kind',
        description = {
            'Six cards with the same rank'
        }
    },
    evaluate = function(parts, hand)
            return parts.crjk_6
    end
}