assert(SMODS.load_file("pokerHands.lua"))()
assert(SMODS.load_file("blinds.lua"))()

SMODS.Atlas{
    key = 'Jokerr',
    path = 'Jokerr.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Bacon',
    path = 'Bacon.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Cupid',
    path = 'Cupid.png',
    px = 138,
    py = 186
}

SMODS.Joker{
    key = 'gradientjoker',
    loc_txt = {
        name = 'Gradient Joker',
        text = {
            'Multiply the multiplier by the cards face worth.',
            'Face cards and Ace\'s are worth {X:mult,C:white}X#1#{}'
        }
    },

    --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    cost = 40,
    atlas = 'Jokerr',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            Xmult = 11
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local xmult = nil
            if context.other_card:get_id() == 14 then
                xmult = 11
            elseif (context.other_card:get_id() <= 13) and (context.other_card:get_id() >= 10) then
                xmult = 10
            elseif (context.other_card:get_id() <= 9) and (context.other_card:get_id() >= 2) then
                xmult = context.other_card:get_id()
            end
            if xmult then
                return {Xmult_mod = xmult}
            end
        end
    end
}

SMODS.Joker{
    key = 'Cupid',
    loc_txt = {
        name = 'Cupid',
        text = {
            'For every heart digit, 0.1x multiplier to score',
            'Current: {X:mult,C:white}X#1#{}'
        }
    },
    --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    cost = 20,
    atlas = 'Cupid',
    rarity = 4,
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            Xmult = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then 
                local xmult = nil
                if context.other_card:get_id() == 14 then
                    xmult = 1.1
                elseif (context.other_card:get_id() <= 13) and (context.other_card:get_id() >= 10) then
                    xmult = 1.0
                elseif (context.other_card:get_id() <= 9) and (context.other_card:get_id() >= 2) then
                    xmult = context.other_card:get_id() / 10.0
                end
                if xmult then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + xmult
                end
                return {mult = card.ability.extra.Xmult}
            end
        end
        
    end
}

SMODS.Joker{
    key = 'Bacon',
    loc_txt = {
        name = 'Bacon',
        text = {
            'Numbered cards give +mult based off',
            ' their rank when held in hand'
        }
    },
    --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    cost = 20,
    atlas = 'Bacon',
    rarity = 3,
    pos = {
        x = 0,
        y = 0
    },

    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.individual and not context.end_of_round then
            local id = context.other_card:get_id()
            if id > 0 and id < 11 then
              return { mult = context.other_card:get_id() }
            end
          end
    end

}
SMODS.Atlas{
    key = 'Trash',
    path = 'Trash.png',
    px = 71,
    py = 95
}

SMODS.Consumable {
    key = "Trash",
    set = 'Tarot',
    loc_txt = {
        name = 'Trash can',
        text = {
            'Gain +3 discards'
        }
    },
    atlas = 'Trash',
    unlocked = true,
    discovered = true,

    config = {
        extra = {
            discards = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.discards}}
    end,
    can_use = function(self, card) return true end,
    use = function(self, card, area)
        ease_discard(card.ability.extra.discards)
        SMODS.calculate_effect({ message = localize('k_three_discards'), colour = G.C.RED }, card)
    end
}
SMODS.Atlas{
    key = 'six',
    path = 'six.png',
    px = 72,
    py = 95
}

SMODS.Voucher {
	key = "Six",
	config = { extra = 1 },
	atlas = "six",
	order = 9,
	pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Sixxer',
        text = {
            'Adds one card to be played'
        }
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { (card and card.ability.extra or self.config.extra) } }
	end,
	redeem = function(self, card)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit
			+ (card and card.ability.extra or self.config.extra)
	end
}
