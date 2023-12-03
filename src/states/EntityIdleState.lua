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
    self.entity:draw(self.animation)
end
