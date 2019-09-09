--[[
   CMPE40032
    Candy Crush Clone (Match 3 Game)



    -- Dependencies --

    A file to organize all of the global dependencies for our project, as
    well as the assets for our game, rather than pollute our main.lua file.
]]


--
-- libraries
--
Class = require 'lib/class'

push = require 'lib/push'

-- used for timers and tweening
Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/StateMachine'
require 'src/Util'

-- game pieces
require 'src/Board'
require 'src/Tile'

-- game states
require 'src/states/BaseState'
require 'src/states/BeginGameState'
require 'src/states/GameOverState'
require 'src/states/PlayState'
require 'src/states/StartState'

gSounds = {
    ['music'] = love.audio.newSource('sounds/twice.mp3'),
    ['select'] = love.audio.newSource('sounds/select.wav'),
    ['error'] = love.audio.newSource('sounds/error.wav'),
    ['match'] = love.audio.newSource('sounds/match.wav'),
    ['clock'] = love.audio.newSource('sounds/clock.wav'),
    ['game-over'] = love.audio.newSource('sounds/game-over.wav'),
    ['next-level'] = love.audio.newSource('sounds/next-level.wav')
}

gTextures = {
    ['main'] = love.graphics.newImage('graphics/crush3.png'),
    ['background'] = love.graphics.newImage('graphics/background.png')
}

gFrames = {
    -- divided into sets for each tile type in this game, instead of one large
    -- table of Quads
    ['tiles'] = GenerateTileQuads(gTextures['main'])
}

-- this time, we're keeping our fonts in a global table for readability
gFonts = {
    ['small'] = love.graphics.newFont('fonts/nn.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/nn.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/nn.ttf', 32)
}

-- CS50
DEBUG = false