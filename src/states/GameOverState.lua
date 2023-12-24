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

    love.graphics.setFont(FONTS['large'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Boulder Clash', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(FONTS['small'])
    love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(FONTS['small'])
    love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')

    color = {0, 1, 0, 1}
    drawText(
        "[Space]: restart, [Esc] :quit",
        FONTS['large'], 5, VIRTUAL_HEIGHT/2 + 95, color, 0.25
    )
end
