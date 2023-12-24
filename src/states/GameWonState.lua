GameWonState = Class{__includes = BaseState}

function GameWonState:init(game)
    self.game = game
    self.game:change_music(SOUNDS['game-won'])
end

function GameWonState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter')
        or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('space')
    then
        self.game:change_state('game-start')
    end
end

function GameWonState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())

    drawGameTitle()
    drawPrompt('You Won!')
    drawControlsText('[Space] restart, [Esc] quit')
end
