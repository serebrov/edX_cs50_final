GameStartState = Class{__includes = BaseState}

function GameStartState:init(game)
    self.game = game
    self.game:change_music(SOUNDS['intro'])
end

function GameStartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter')
        or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('space')
    then
        self.game:change_state('game-play')
    end
end

function GameStartState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())

    drawGameTitle()
    drawPrompt('Press Enter')
    drawControlsText('[Space] start, [Esc] quit')
end
