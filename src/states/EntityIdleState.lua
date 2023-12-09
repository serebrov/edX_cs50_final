EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
    self.entity = entity

    animation_name = 'idle-' .. self.entity.direction
    self.entity.animation = self.entity.animations[animation_name]
    assert(
        self.entity.animation ~= nil,
        'EntityIdleState:init() animation is nil for ' .. animation_name
    )
end

function EntityIdleState:update(dt)
    -- Do nothing
end

function EntityIdleState:render()
    assert(self.entity.animation ~= nil, 'EntityIdleState:render() animation is nil')
    self.entity:draw()
end
