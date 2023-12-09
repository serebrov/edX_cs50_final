Entity = Class{}

function Entity:init(def, x, y)
    self.direction = 'right'
    self.walk_speed = def.walk_speed

    self.animations = createAnimations(def.animations)
    self.animation = nil

    if def.texture ~= nil then
        self.texture = TEXTURES[def.texture]
    end

    assert (self.animations ~= nil or self.texture ~= nil, 'Object must have animations or texture')

    assert(x ~= nil, 'Object must have an x coordinate')
    assert(y ~= nil, 'Object must have an y coordinate')

    self.x = x
    self.y = y

    self.offset_x = def.offset_x or 0
    self.offset_y = def.offset_y or 0
    self.scale_x = def.scale_x or 1
    self.scale_y = def.scale_y or 1

    self.width = TILE_SIZE
    self.height = TILE_SIZE
    self.solid = def.solid
end

function Entity:update(dt)
end

function Entity:render()
    self:draw()
end

function Entity:draw()
    if self.animation then
        love.graphics.draw(
        TEXTURES[self.animation.texture],
        FRAMES[self.animation.texture][self.animation:get_current_frame()],
        math.floor(self.x) + self.offset_x,
        math.floor(self.y) + self.offset_y,
        0,
        self.scale_x,
        self.scale_y
        )
    else
        love.graphics.draw(
        self.texture,
        math.floor(self.x) + self.offset_x,
        math.floor(self.y) + self.offset_y,
        0,
        self.scale_x,
        self.scale_y
        )
    end
end

function createAnimations(animations)
    if animations == nil then
        return nil
    end

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
