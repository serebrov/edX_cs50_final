PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(entity)
    EntityIdleState.init(self, entity)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:change_state('walk')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:change_state('walk')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:change_state('walk')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:change_state('walk')
    end
    EntityIdleState.update(self, dt)
end
