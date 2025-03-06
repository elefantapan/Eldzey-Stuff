SMODS.Atlas {
    key = "blind_chips",
    path = "Thread.png",
    px = 0,
    py = 0,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 20
}

SMODS.Blind {
    key = "ThreadBlind",
    loc_txt = {
        name = "Thread",
        text = {
            'Play maximum 3 cards.'
        }
    },
    atlas = "blind_chips",
    pos = {
        x = 0,
        y = 0
    },
    dollars = 7,
    mult = 1.5,
    boss = {
        min = 3,
        max = 10
    },
    boss_colour = HEX("993600")
}