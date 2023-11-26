GameStartState = Class{__includes = BaseState}

function GameStartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('game-play')
    end
end

function GameStartState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setFont(gFonts['large'])

    -- Draw the outline by drawing the text in black slightly offset multiple times
    love.graphics.setColor(0, 0, 0, 1) -- black color for the outline
    local offsets = {{2, 2}, {-2, -2}, {2, -2}, {-2, 2}} -- shadow offsets
    for _, offset in pairs(offsets) do
        love.graphics.printf(
            'Boulder Clash',
            2 + offset[1],
            VIRTUAL_HEIGHT / 2 - 30 + offset[2],
            VIRTUAL_WIDTH,
            'center'
        )
    end

    -- Draw the text in a bright color
    -- love.graphics.setColor(1, 0.84, 0, 1) -- gold color
    love.graphics.setColor(0, 0.84, 1, 1) -- blue color
    love.graphics.printf('Boulder Clash', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')

    -- Draw the action prompt
    love.graphics.setFont(gFonts['medium'])
    -- Neon green label color
    local labelColor = {0.2, 1, 0.2, 1}

    -- Draw the shadow in black
    love.graphics.setColor(0, 0, 0, 1) -- black color for the shadow
    love.graphics.printf('Press Enter', 2, VIRTUAL_HEIGHT / 2 + 66, VIRTUAL_WIDTH, 'center')

    -- Draw the text in neon green on top of the shadow
    love.graphics.setColor(labelColor)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')

    -- love.graphics.draw(gTextures['background'], 0, 0, 0, 
    --     VIRTUAL_WIDTH / gTextures['background']:getWidth(),
    --     VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    -- love.graphics.setFont(gFonts['large'])
    -- love.graphics.setColor(34/255, 34/255, 34/255, 1)
    -- love.graphics.printf('Boulder Clash', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.setFont(gFonts['small'])
    -- love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end
