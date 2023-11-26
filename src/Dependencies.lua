--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/level_defs'

require 'src/StateMachine'
require 'src/Level'
-- require 'src/Animation'
-- require 'src/Entity'
-- require 'src/entity_defs'
-- require 'src/GameObject'
-- require 'src/game_objects'
-- require 'src/Hitbox'
-- require 'src/Player'
-- require 'src/Util'

require 'src/states/BaseState'

-- require 'src/states/entity/EntityIdleState'
-- require 'src/states/entity/EntityWalkState'

-- require 'src/states/entity/player/PlayerIdleState'
-- require 'src/states/entity/player/PlayerSwingSwordState'
-- require 'src/states/entity/player/PlayerWalkState'

require 'src/states/GameOverState'
require 'src/states/GamePlayState'
require 'src/states/GameStartState'

gTextures = {
    -- ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['rock'] = love.graphics.newImage('graphics/rock.png'),
    ['diamond'] = love.graphics.newImage('graphics/diamond.png'),
    ['exit'] = love.graphics.newImage('graphics/exit.png'),
    -- ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    -- ['boulders'] = love.graphics.newImage('graphics/boulders.png'),
    -- ['diamonds'] = love.graphics.newImage('graphics/diamonds.png'),
}

gFrames = {
    -- ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    -- ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    -- ['boulders'] = GenerateQuads(gTextures['boulders'], 16, 16),
    -- ['diamonds'] = GenerateQuads(gTextures['diamonds'], 16, 16),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
}
