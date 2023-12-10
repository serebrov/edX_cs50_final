EntityWithState = Class{__includes=Entity}

function EntityWithState :state_machine()
    if self.stateMachine == nil then
        self.stateMachine = self:create_state_machine()
    end

    return self.stateMachine
end

function EntityWithState :change_state(name, params)
    self.stateMachine:change(name, params)
end

function EntityWithState:update(dt)
    self.stateMachine:update(dt)
end

function EntityWithState:render()
    self:state_machine():render()
end
