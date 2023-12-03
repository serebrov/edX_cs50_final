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

    dx = 0
    dy = 0
    tile_next = nil

    if self.entity.direction == 'left' then
        dx = - self.entity.walk_speed * dt
        tile_next = self.level:tile_at(self.entity.x - 1, self.entity.y + 1)
        -- tile_next, tile_x, tile_y = self.level:tile_at(self.entity.x - TILE_SIZE, self.entity.y + 1)
    elseif self.entity.direction == 'right' then
        dx = self.entity.walk_speed * dt
        tile_next = self.level:tile_at(self.entity.x + TILE_SIZE, self.entity.y + 1)
    elseif self.entity.direction == 'up' then
        dy = - self.entity.walk_speed * dt
        tile_next = self.level:tile_at(self.entity.x, self.entity.y - 1)
    elseif self.entity.direction == 'down' then
        dy = self.entity.walk_speed * dt
        tile_next = self.level:tile_at(self.entity.x, self.entity.y + TILE_SIZE)
    end

    if tile_next == MAP_TILE_WALL then
        self.bumped = true
    elseif tile_next == MAP_TILE_ROCK then
        self.bumped = true
    -- elseif tile_next == MAP_TILE_DIAMOND then
    --     self.bumped = true
    else
        -- self.entity.x, self.entity.y = tile_x, tile_y
        self.entity.x = self.entity.x + dx
        self.entity.y = self.entity.y + dy
    end
end

function EntityWalkState:render()
    self.entity:draw(self.animation)
end
