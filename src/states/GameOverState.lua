GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    changeMusic(SOUNDS['game-over'])
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter')
        or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('space')
    then
        gStateMachine:change('game-start')
    end
end

function GameOverState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())

    drawGameTitle()
    drawPrompt('Game Over')
    drawControlsText('[Space] restart, [Esc] quit')
end
