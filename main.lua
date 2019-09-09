
require 'src/Dependencies'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- shiny tile spawning odds
SHINY_TILE = 0.98

function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- window bar title
    love.window.setTitle('Crush 3')

    -- seed the RNG
    math.randomseed(os.time())

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- set music to loop and start
    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['begin-game'] = function() return BeginGameState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('start')

    -- keep track of scrolling our background on the X axis
    backgroundX = 0
    backgroundScrollSpeed = 80

    -- initialize input table
    love.keyboard.keysPressed = {}
    --UPDATE .... initialized mouse input
    love.mouse.buttonsPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--SHINY UPDATE:function to hande mouse input
function love.mousepressed(x,y,button)
    love.mouse.buttonsPressed[button] = true
end

--SHINY UPDATE:funtion to determine if mouse has been pressed
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)
    -- scroll background, used across all states
    backgroundX = backgroundX - backgroundScrollSpeed * dt
    
    -- if we've scrolled the entire image, reset it to 0
    if backgroundX <= -1024 + VIRTUAL_WIDTH - 4 + 51 then
        backgroundX = 0
    end

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    --UPDATE: resets mouse table
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()

    -- scrolling background drawn behind every state
    love.graphics.draw(gTextures['background'], backgroundX, 0)
    
    gStateMachine:render()
    push:finish()
end