ENTITY_DEFS = {
    ['player'] = {
        walk_speed = PLAYER_WALK_SPEED,
        offset_x = -3,
        offset_y = 0,
        scale_x = 0.7,
        scale_y = 0.7,
        animations = {
            ['walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.155,
                texture = 'character-walk'
            },
            ['walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['idle-left'] = {
                frames = {13},
                texture = 'character-walk'
            },
            ['idle-right'] = {
                frames = {5},
                texture = 'character-walk'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'character-walk'
            },
            ['idle-up'] = {
                frames = {9},
                texture = 'character-walk'
            }
        }
    },
    ['ground'] = {
        texture = 'ground',
        speed_bump = 0.5,
        -- Scale the rock to 1/6 of its original size (96 to 16)
        scale_x = 1/6,
        scale_y = 1/6,
    },
    ['rock'] = {
        texture = 'rock',
        solid = true,
        can_fall = true,
        speed_bump = 0,
        -- Scale the rock to 1/32 of its original size (512 to 16)
        scale_x = 1/32,
        scale_y = 1/32,
    },
    ['diamond'] = {
        texture = 'diamond',
        can_fall = true,
        speed_bump = 0.7,
        -- Scale the diamond to 1/64 of its original size (1024 to 16)
        scale_x = 1/64,
        scale_y = 1/64,
    },
    ['exit'] = {
        texture = 'exit',
        speed_bump = 1,
        -- -- Scale the exit to 1/64 its original size (1024 to 16)
        -- scale_x = 1/64,
        -- scale_y = 1/64,
        animations = {
            ['on'] = {
                texture = 'exit-on',
                frames = {1,2,3,4},
                interval = 0.15,
                -- scale_x = 1/64,
                -- scale_y = 1/64,
            },
        }
    },
    ['wall'] = {
        texture = 'wall',
        solid = true,
        speed_bump = 0,
        -- Scale the rock to 1/5 of its original size (80 to 16)
        scale_x = 1/5,
        scale_y = 1/5,
    }
}
