--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/defs_level'
require 'src/defs_entity'

require 'src/StateMachine'
require 'src/Level'
require 'src/Animation'
require 'src/Entity'
require 'src/EntityWithState'
require 'src/Tile'
require 'src/Player'

require 'src/states/BaseState'

require 'src/states/EntityIdleState'
require 'src/states/EntityWalkState'
require 'src/states/PlayerIdleState'
require 'src/states/PlayerWalkState'
require 'src/states/GameOverState'
require 'src/states/GamePlayState'
require 'src/states/GameStartState'

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
    -- ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['rock'] = love.graphics.newImage('graphics/rock.png'),
    ['diamond'] = love.graphics.newImage('graphics/diamond.png'),
    ['exit'] = love.graphics.newImage('graphics/exit.png'),
    ['wall'] = love.graphics.newImage('graphics/wall.png'),
    ['ground'] = love.graphics.newImage('graphics/ground.png'),
    ['character-walk'] = love.graphics.newImage('graphics/character_walk_32.png'),
    -- ['boulders'] = love.graphics.newImage('graphics/boulders.png'),
    -- ['diamonds'] = love.graphics.newImage('graphics/diamonds.png'),
}

FRAMES = {
    ['character-walk'] = generate_frames(TEXTURES['character-walk'], 32, 32)
}

FONTS = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 10),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

SOUNDS = {
    ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
}
