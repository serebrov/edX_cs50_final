GamePlayState = Class{__includes = BaseState}

function GamePlayState:init()
    self.level = Level(LEVEL_DEFS['level1'])
end

function GamePlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('game-over')
    end
end

function GamePlayState:render()
    love.graphics.push()
    self.level:render()
    love.graphics.pop()
end
