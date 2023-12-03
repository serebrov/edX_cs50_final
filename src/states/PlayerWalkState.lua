PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity, level)
    EntityWalkState.init(self, entity, level)
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.animation = self.entity.animations['walk-left']
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.animation = self.entity.animations['walk-right']
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.animation = self.entity.animations['walk-up']
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.animation = self.entity.animations['walk-down']
    else
        self.entity:change_state('idle')
    end
    EntityWalkState.update(self, dt)
end
