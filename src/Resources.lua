--[[
    Given an spritesheet and the frame width and  height, split the sheet
    into a table of frames.
]]
function generate_frames(sheet, frame_width, frame_height)
    local frames = {}

    local sheet_width = sheet:getWidth()
    local sheet_height = sheet:getHeight()

    local x_frames = sheet_width / frame_width
    local y_frames = sheet_height / frame_height

    local frame_count = 1

    for y = 0, y_frames - 1 do
        for x = 0, x_frames - 1 do
            frames[frame_count] = love.graphics.newQuad(
                x * frame_width,
                y * frame_height,
                frame_width,
                frame_height,
                sheet_width,
                sheet_height
            )
            frame_count = frame_count + 1
        end
    end

    return frames
end

TEXTURES = {
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['rock'] = love.graphics.newImage('graphics/rock.png'),
    ['diamond'] = love.graphics.newImage('graphics/diamond.png'),
    ['exit'] = love.graphics.newImage('graphics/exit.png'),
    ['exit-on'] = love.graphics.newImage('graphics/exit-on.png'),
    ['exit-hi'] = love.graphics.newImage('graphics/exit_hi.png'),
    ['exit-on-hi'] = love.graphics.newImage('graphics/exit-on_hi.png'),
    ['wall'] = love.graphics.newImage('graphics/wall.png'),
    ['ground'] = love.graphics.newImage('graphics/ground.png'),
    ['character-walk'] = love.graphics.newImage('graphics/character_walk_32.png'),
}

FRAMES = {
    ['character-walk'] = generate_frames(TEXTURES['character-walk'], 32, 32),
    ['exit-on'] = generate_frames(TEXTURES['exit-on'], 16, 16),
    ['exit-on-hi'] = generate_frames(TEXTURES['exit-on'], 1024, 1024)
}

FONTS = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 10),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

SOUNDS = {
    ['intro'] = love.audio.newSource('sounds/music.mp3', 'static'),
    ['game-over'] = love.audio.newSource('sounds/game-over.mp3', 'static'),
    ['game-won'] = love.audio.newSource('sounds/game-won.mp3', 'static'),
}

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
