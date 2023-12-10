ENTITY_DEFS = {
    ['player'] = {
        walk_speed = PLAYER_WALK_SPEED,
        offset_x = 0,
        offset_y = 0,
        scale_x = 0.5,
        scale_y = 0.5,
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
    },
    ['rock'] = {
        texture = 'rock',
        solid = true,
        can_fall = true,
        speed_bump = 0,
    },
    ['diamond'] = {
        texture = 'diamond',
        can_fall = true,
        speed_bump = 0.7,
    },
    ['exit'] = {
        texture = 'exit',
        speed_bump = 1,
        animations = {
            ['on'] = {
                frames = {1,2,3,4},
                interval = 0.15,
                texture = 'exit-on'
            },
        }
    },
    ['wall'] = {
        texture = 'wall',
        solid = true,
        speed_bump = 0,
    }
}
