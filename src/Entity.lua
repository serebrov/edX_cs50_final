Entity = Class{}

function Entity:init(def, level)
    self.level = level
    self.direction = 'right'
    self.animations = self:createAnimations(def.animations)

    self.x = def.x
    self.y = def.y
    self.width = TILE_SIZE
    self.height = TILE_SIZE
    self.walk_speed = def.walk_speed
end

function Entity:state_machine()
    if self.stateMachine == nil then
        self.stateMachine = self:create_state_machine()
    end

    return self.stateMachine
end

function Entity:change_state(name, params)
    self.stateMachine:change(name, params)
end

-- Should be implemented by subclasses
function Entity:create_state_machine()
    return StateMachine {}
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render()
    self:state_machine():render()
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end
