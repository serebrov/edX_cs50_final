GamePlayState = Class{__includes = BaseState}

function GamePlayState:init()
    self.level = Level(LEVEL_DEFS['level1'])
    self.player = Player(ENTITY_DEFS['player'], self.level)
end

function GamePlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('game-over')
    end

    self.player:update(dt)
end

function GamePlayState:render()
    love.graphics.push()
    self.level:render()
    love.graphics.pop()
    self.player:render()
end
