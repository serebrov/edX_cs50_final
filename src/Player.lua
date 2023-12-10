Player = Class{__includes = EntityWithState}

function Player:init(x, y, level)
    self.id = 'player'

    def = ENTITY_DEFS['player']
    self.diamonds = 0
    self.level = level

    self.direction = 'right'
    self.walk_speed = def.walk_speed

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
