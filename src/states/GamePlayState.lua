GamePlayState = Class{__includes = BaseState}

function GamePlayState:init()
    self:startLevel(1)
end

function GamePlayState:startLevel(level_number)
    self.level_number = level_number
    self.level = Level(LEVEL_DEFS[self.level_number], self)

    self.track = 'sounds/level' .. self.level_number .. '.mp3'
    self.music = love.audio.newSource(self.track, 'static')
    changeMusic(self.music)
end

function GamePlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('game-over')
    end
    self.level:update(dt)
end

function GamePlayState:render()
    love.graphics.push()
    self.level:render()
    love.graphics.pop()

    -- Show the number of diamonds collected
    -- TODO: diamond is not visible, need to find a font that has it
    -- text = '💎 ' .. self.level.player.diamonds
    text = 'Diamonds: ' .. self.level.player.diamonds .. ' of ' .. self.level.diamonds
    drawText(
        text, 10, VIRTUAL_HEIGHT - 10,
        {
            font = 'large',
            scale = 0.3,
            color = COLOR_GREEN,
        }
    )

    drawText(
        '[Arrows] move, [Esc] quit', 150, VIRTUAL_HEIGHT - 10,
        {
            font = 'large',
            scale = 0.25,
            color = COLOR_GREEN,
        }
    )
end

function GamePlayState:gameOver()
    gStateMachine:change('game-over')
end

function GamePlayState:nextLevel()
    if self.level_number < #LEVEL_DEFS then
        self:startLevel(self.level_number + 1)
    else
        gStateMachine:change('game-won')
    end
end
