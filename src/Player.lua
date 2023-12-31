--[[
Player class.

Besides EntityWithState also includes Tile so we can
uniformly render the player and the tiles.

Note: "player as a tile" system is currently unused,
we handle the player separately in Level.lua.
]]--
Player = Class{__includes = EntityWithState}

-- See Level.lua for details, a possible implementation is to
-- have a player as a tile, so we can uniformly render the player
-- and the tiles.
-- Player = Class{__includes = {EntityWithState, Tile}}

function Player:init(level, x, y)
    self.id = 'player'

    def = ENTITY_DEFS['player']
    self.diamonds = 0
    self.level = level

    self.direction = 'right'
    self.walk_speed = def.walk_speed

    Tile.init(self, 'player', level, x, y)
    Entity.init(self, def, x, y)
end

function Player:create_state_machine()
    machine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self, self.level) end,
        ['idle'] = function() return PlayerIdleState(self) end,
    }
    machine:change('idle')
    return machine
end
