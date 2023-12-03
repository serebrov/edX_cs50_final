EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, level)
    self.entity = entity
    self.level = level

    -- Set to true when we collide with a wall
    self.bumped = false

    animation_name = 'walk-' .. self.entity.direction
    self.animation = self.entity.animations[animation_name]
end

function EntityWalkState:update(dt)
    self.bumped = false

    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walk_speed * dt

        -- Stop the entity if there's a missing tile on the left
        if self.entity.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then
            self.entity.x = MAP_RENDER_OFFSET_X + TILE_SIZE
            self.bumped = true
        -- Check if there's a wall directly to the left
        elseif self.level:tile_at(self.entity.x, self.entity.y).id == TILE_ID_WALL then
            self.entity.x = self.entity.x + self.entity.walk_speed * dt
            self.bumped = true
        end
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walk_speed * dt

        -- Stop the entity if there's a missing tile on the right
        if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.entity.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.entity.width
            self.bumped = true
        -- Check if there's a wall directly to the right
        elseif self.level:tile_at(self.entity.x + self.entity.width, self.entity.y).id == TILE_ID_WALL then
            self.entity.x = self.entity.x - self.entity.walk_speed * dt
            self.bumped = true
        end
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - self.entity.walk_speed * dt

        -- Stop the entity if there's a missing tile above
        if self.entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 then
            self.entity.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2
            self.bumped = true
        -- Check if there's a wall directly above
        elseif self.level:tile_at(self.entity.x, self.entity.y).id == TILE_ID_WALL then
            self.entity.y = self.entity.y + self.entity.walk_speed * dt
            self.bumped = true
        end
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + self.entity.walk_speed * dt

        -- Stop the entity if there's a missing tile below
        if self.entity.y + self.entity.height >= VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + TILE_SIZE then
            self.entity.y = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + TILE_SIZE - self.entity.height
            self.bumped = true
        -- Check if there's a wall directly below
        elseif self.level:tile_at(self.entity.x, self.entity.y + self.entity.height).id == TILE_ID_WALL then
            self.entity.y = self.entity.y - self.entity.walk_speed * dt
            self.bumped = true
        end
    end
end

function EntityWalkState:render()
    love.graphics.draw(
        TEXTURES[self.animation.texture],
        FRAMES[self.animation.texture][self.animation:get_current_frame()],
        math.floor(self.entity.x),
        math.floor(self.entity.y)
    )
end
