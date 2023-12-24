GameStartState = Class{__includes = BaseState}

function GameStartState:init()
    changeMusic(SOUNDS['intro'])
end

function GameStartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter')
        or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('space')
    then
        gStateMachine:change('game-play')
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
