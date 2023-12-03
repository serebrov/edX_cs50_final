Player = Class{__includes = Entity}

function Player:init(def, level)
    def.x = 1 * TILE_SIZE
    def.y = 1 * TILE_SIZE - 11
    Entity.init(self, def, level)
end

function Player:create_state_machine()
    machine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self, self.level) end,
        ['idle'] = function() return PlayerIdleState(self) end,
    }
    machine:change('idle')
    return machine
end
