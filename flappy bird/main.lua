Class = require 'class'
push = require 'push'
tick = require 'tick'

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/PlayState'
require 'states/ScoreState'

WINDOW_WIDTH = 960 --960
WINDOW_HEIGHT = 540 --540

VIRTUAL_WIDTH = 512 --512
VIRTUAL_HEIGHT = 288 --288

local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30 
local GROUND_SCROLL_SPEED = 80 

local BACKGROUND_LOOPING_POINT = 413

function love.load()

    tick.framerate = 60
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest','nearest')

    love.window.setTitle('Flappy Bird')
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{

        vsync = true,
        fullscreen = false,
        resizable= true
    })

    smallFont = love.graphics.newFont('assets/font.ttf', 8)
    mediumFont = love.graphics.newFont('assets/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('assets/flappy.ttf', 28)
    love.graphics.setFont(flappyFont)

    sounds ={
        ['hurt']  = love.audio.newSource('assets/hurt.wav','static'),
        ['jump']  = love.audio.newSource('assets/jump.wav','static'),
        ['score'] = love.audio.newSource('assets/score.wav','static'),
        ['explosion'] = love.audio.newSource('assets/explosion.wav','static')
    }
    for i, sound in pairs(sounds) do
        
        sound:setVolume(.20)
    end

    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end ,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }

    gStateMachine:change('title')

    love.keyboard.pressedKeys={}
    love.mouse.pressedButtons={}

    scrolling = true
end

function love.update(dt)
     
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED*dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED*dt) % VIRTUAL_WIDTH

    gStateMachine:update(dt)

    love.keyboard.pressedKeys={}
    love.mouse.pressedButtons={}

end

function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)

    love.keyboard.pressedKeys[key] = true
end

function love.mousepressed(x,y,button)
    love.mouse.pressedButtons[button] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.pressedKeys[key]
end

function love.mouse.wasPressed(button)
    return love.mouse.pressedButtons[button]
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function love.draw()
    push:start()
        love.graphics.draw(background, -backgroundScroll,0)

        gStateMachine:render()

        love.graphics.draw(ground, -groundScroll,VIRTUAL_HEIGHT - 16)
    push:finish()
end