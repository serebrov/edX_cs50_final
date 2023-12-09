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
    self.level:update(dt)
end

function GamePlayState:render()
    love.graphics.push()
    self.level:render()
    love.graphics.pop()
    self.player:render()

    -- Show the number of diamonds collected
    love.graphics.setFont(FONTS['small'])
    love.graphics.setColor(1, 1, 1, 1)
    -- TODO: diamond is not visible, need to find a font that has it
    love.graphics.print('💎 ' .. self.player.diamonds, 10, VIRTUAL_HEIGHT - 10)

end
