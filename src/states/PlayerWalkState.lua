PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity, level)
    EntityWalkState.init(self, entity, level)
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity.animation = self.entity.animations['walk-left']
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity.animation = self.entity.animations['walk-right']
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity.animation = self.entity.animations['walk-up']
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity.animation = self.entity.animations['walk-down']
    else
        self.entity:change_state('idle')
    end

    EntityWalkState.update(self, dt)

    tile_current = self.level:tile_at(self.entity.x, self.entity.y)

    -- If we're standing on the ground tile, then remove it
    if tile_current:isGround() then
        self.level:set_tile_at(self.entity.x, self.entity.y, nil)
    end

    -- If we're standing on a diamond tile, then remove it
    if tile_current:isDiamond() then
        self.level:set_tile_at(self.entity.x, self.entity.y, nil)
        self.entity.diamonds = self.entity.diamonds + 1
    end
end
