GamePlayState = Class{__includes = BaseState}

function GamePlayState:init()
    self.level_number = 1
    self.level = Level(LEVEL_DEFS[self.level_number], self)
end

function GamePlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
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
    color = {0, 1, 0, 1}
    scale = 0.3
    drawText(text, FONTS['large'], 10, VIRTUAL_HEIGHT - 10, color, scale)
end

function GamePlayState:gameOver()
    gStateMachine:change('game-over')
end

function GamePlayState:nextLevel()
    if self.level_number < #LEVEL_DEFS then
        self.level_number = self.level_number + 1
        self.level = Level(LEVEL_DEFS[self.level_number], self)
    else
        gStateMachine:change('game-won')
    end
end
