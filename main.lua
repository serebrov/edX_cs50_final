-- GD50 final project
-- Boulder Clash

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Boulder Clash')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    love.graphics.setFont(FONTS['small'])

    gStateMachine = StateMachine {
        ['game-start'] = function() return GameStartState() end,
        ['game-play'] = function() return GamePlayState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('game-start')

    SOUNDS['music']:setLooping(true)
    SOUNDS['music']:play()

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end
