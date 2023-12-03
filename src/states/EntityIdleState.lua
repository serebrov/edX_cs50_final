EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
    self.entity = entity

    animation_name = 'idle-' .. self.entity.direction
    self.animation = self.entity.animations[animation_name]
end

function EntityIdleState:update(dt)
    -- Do nothing
end

function EntityIdleState:render()
    love.graphics.draw(
        TEXTURES[self.animation.texture],
        FRAMES[self.animation.texture][self.animation:get_current_frame()],
        math.floor(self.entity.x),
        math.floor(self.entity.y)
    )
end
