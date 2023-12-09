EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, level)
    self.entity = entity
    self.level = level

    -- Set to true when we collide with a wall
    self.bumped = false
    self.dx = 0
    self.dy = 0

    animation_name = 'walk-' .. self.entity.direction
    self.animation = self.entity.animations[animation_name]
end

function EntityWalkState:update(dt)
    self.bumped = false

    dx = 0
    dy = 0
    tile_next = nil

    if self.entity.direction == 'left' then
        tile_next = self.level:tile_at(self.entity.x - 1, self.entity.y + 1)
        dx = - self.entity.walk_speed * dt * TILE_SPEED_BUMP[tile_next]
    elseif self.entity.direction == 'right' then
        tile_next = self.level:tile_at(self.entity.x + TILE_SIZE, self.entity.y + 1)
        dx = self.entity.walk_speed * dt * TILE_SPEED_BUMP[tile_next]
    elseif self.entity.direction == 'up' then
        tile_next = self.level:tile_at(self.entity.x, self.entity.y - 1)
        dy = - self.entity.walk_speed * dt * TILE_SPEED_BUMP[tile_next]
    elseif self.entity.direction == 'down' then
        tile_next = self.level:tile_at(self.entity.x, self.entity.y + TILE_SIZE)
        dy = self.entity.walk_speed * dt * TILE_SPEED_BUMP[tile_next]
    end

    if tile_next == MAP_TILE_WALL then
        self.bumped = true
    elseif tile_next == MAP_TILE_ROCK then
        self.bumped = true
    -- elseif tile_next == MAP_TILE_DIAMOND then
    --     self.bumped = true
    else
        self.dx = self.dx + dx
        self.dy = self.dy + dy

        playerX = self.entity.x
        playerY = self.entity.y

        -- If we accumulated enough distance to move a full tile, then do so
        if self.dx >= TILE_SIZE then
            Timer.tween(0.1, {
                [self.entity] = {x = playerX + TILE_SIZE}
            })
            self.dx = 0
        elseif self.dx <= -TILE_SIZE then
            Timer.tween(0.1, {
                [self.entity] = {x = playerX - TILE_SIZE}
            })
            self.dx = 0
        end
        if self.dy >= TILE_SIZE then
            Timer.tween(0.1, {
                [self.entity] = {y = playerY + TILE_SIZE}
            })
            self.dy = 0
        elseif self.dy <= -TILE_SIZE then
            Timer.tween(0.1, {
                [self.entity] = {y = playerY - TILE_SIZE}
            })
            self.dy = 0
        end
    end
end

function EntityWalkState:render()
    self.entity:draw(self.animation)
end
