Player = Class{__includes = Entity}

function Player:init(x, y, level)
    self.id = 'player'
    def = ENTITY_DEFS['player']
    self.diamonds = 0
    self.level = level
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

function Player:state_machine()
    if self.stateMachine == nil then
        self.stateMachine = self:create_state_machine()
    end

    return self.stateMachine
end

function Player:change_state(name, params)
    self.stateMachine:change(name, params)
end

function Player:update(dt)
    self.stateMachine:update(dt)
end

function Player:render()
    self:state_machine():render()
end
