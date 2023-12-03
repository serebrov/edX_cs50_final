Animation = Class{}

function Animation:init(def)
    self.texture = def.texture
    self.frames = def.frames
    self.looping = def.looping or true

    self.interval = def.interval or 0.05
    self.timer = 0
    self.currentFrame = 1
end

function Animation:get_current_frame()
    return self.frames[self.currentFrame]
end

function Animation:update(dt)
    if not self.looping and self.currentFrame == #self.frames then
        return
    end

    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = (self.currentFrame + 1) % (#self.frames + 1)

            if self.currentFrame == 0 then self.currentFrame = 1 end
        end
    end
end

function Animation:render(x, y)
    love.graphics.draw(
        self.texture,
        self.frames[self.currentFrame],
        math.floor(x),
        math.floor(y)
    )
end
