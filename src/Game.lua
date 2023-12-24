Game = Class{}

function Game:init()
    self.music = nil
    self.state_machine = StateMachine {
        ['game-start'] = function() return GameStartState(self) end,
        ['game-play'] = function() return GamePlayState(self) end,
        ['game-over'] = function() return GameOverState(self) end,
        ['game-won'] = function() return GameWonState(self) end
    }

    self.state_machine:change('game-start')
end

function Game:update(dt)
    self.state_machine:update(dt)
end

function Game:render()
    self.state_machine:render()
end

function Game:change_state(state_name)
    self.state_machine:change(state_name)
end

function Game:change_music(audio)
    if self.music then
        self.music:stop()
    end
    if not audio then
        return
    end
    self.music = audio
    self.music:setLooping(true)
    self.music:play()
end

function drawGameTitle()
    -- Draw the outline by drawing the text in black slightly offset multiple times
    local offsets = {{2, 2}, {-2, -2}, {2, -2}, {-2, 2}} -- shadow offsets
    for _, offset in pairs(offsets) do
        drawText(
            'Boulder Clash', 2 + offset[1], VIRTUAL_HEIGHT / 2 - 30 + offset[2],
            {
                font = 'large',
                color = COLOR_BLACK,
                width = VIRTUAL_WIDTH,
                align = 'center'
            }
        )
    end

    -- Draw the text in a bright color
    drawText(
        'Boulder Clash', 2, VIRTUAL_HEIGHT / 2 - 30,
        {
            font = 'large',
            color = COLOR_BLUE,
            width = VIRTUAL_WIDTH,
            align = 'center'
        }
    )
end

function drawPrompt(text)
    -- Draw the action prompt
    drawText(
        text, 2, VIRTUAL_HEIGHT / 2 + 26,
        {
            font = 'medium',
            color = COLOR_BLACK,
            width = VIRTUAL_WIDTH,
            align = 'center'
        }
    )
    drawText(
        text, 0, VIRTUAL_HEIGHT / 2 + 24,
        {
            font = 'medium',
            color = COLOR_NEON_GREEN,
            width = VIRTUAL_WIDTH,
            align = 'center'
        }
    )
end

function drawControlsText(text)
    drawText(
        text, 5, VIRTUAL_HEIGHT/2 + 95,
        {
            font = 'large',
            scale = 0.25,
            color = COLOR_GREEN,
        }
    )
end
