-- REQUIREMENTS

push = require 'push'
Class = require 'class'

require 'Pacman'
require 'Ghost'

    -- SCREEN VARIABLES

-- 28 x 31 maze; 28 x 36 screen 0.9 aspect ratio
-- 1 tile = 8x8 px 1 sprite = 16x16/15x15??

WINDOW_WIDTH = 448  
WINDOW_HEIGHT = 576

VIRTUAL_WIDTH = 224
VIRTUAL_HEIGHT = 288

--sprites
local mazeImg = love.graphics.newImage('assets/maze.png')

local blinkyImg = love.graphics.newImage('assets_temp/blinky.png')
local pinkyImg = love.graphics.newImage('assets_temp/pinky.png')
local inkyImg = love.graphics.newImage('assets_temp/inky.png')
local clydeImg = love.graphics.newImage('assets_temp/clyde.png')

-- START
function love.load()
    
    love.window.setTitle("PACMAN")

    -- get random seed
    math.randomseed(os.time())


    --initialize screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    

    -- -1 = block
    --  0 = empty
    --  2 = pellet
    --  3 = powerpellet
    --  4 = intersection
    --  5 = special intersection
    maze ={} 
        maze[1]={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
        maze[2]={-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1};
        maze[3]={-1,0,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,0,-1};
        maze[4]={-1,0,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,0,-1};
        maze[5]={-1,0,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,0,-1};
        maze[6]={-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1};
        maze[7]={-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1};
        maze[8]={-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1};
        maze[9]={-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1};
        maze[10]={-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[11]={-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[12]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,5,0,0,5,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[13]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[14]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[15]={0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0};
        maze[16]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[17]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[18]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[19]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[20]={-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1};
        maze[21]={-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1};
        maze[22]={-1,0,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,0,-1};
        maze[23]={-1,0,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,0,-1};
        maze[24]={-1,0,0,0,-1,-1,0,0,0,0,0,0,5,0,0,5,0,0,0,0,0,0,-1,-1,0,0,0,-1};
        maze[25]={-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1};
        maze[26]={-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1};
        maze[27]={-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1};
        maze[28]={-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1};
        maze[29]={-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1};
        maze[30]={-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1};
        maze[31]={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    
    
    
   --

    pacman = Pacman(12,14)
    blinky = Blinky(18,10,-2,26)
    pinky =  Pinky(2,3,-2,3)
    inky = Inky(2,18,33,28)
    clyde = Clyde(5,2,33,1)
    --font
    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont('Font.ttf', 4)
    --sounds

end

-- UPDATE

function love.update(dt)
    
    pacman:move()

    blinky:Handler()
    pinky:Handler()
    inky:Handler()
    clyde:Handler()

    love.timer.sleep(.05)

end

--FUNCTIONS

function love.keypressed(key)

    if(key == 'left') then
        pacman.qdx = 0
        pacman.qdy = -1
    end
    
    if(key == 'right') then
        pacman.qdx = 0
        pacman.qdy = 1
    end

    if(key == 'up') then
        pacman.qdx = -1
        pacman.qdy = 0
    end

    if(key == 'down') then
        pacman.qdx = 1
        pacman.qdy = 0
    end

end

-- RENDER

function love.draw()
    push:start()
        --draw maze
--[[
        for i = 1, 31, 1 do
            for j = 1, 28, 1 do
                if maze[i][j] == -1 then
                    love.graphics.draw(mazeImg, (j-1)*8, 24 + (i-1)*8)
                end
            end
        end
]]--
        love.graphics.draw(mazeImg,0,24)
        pacman:render()
        blinky:render(blinkyImg)
        pinky:render(pinkyImg)
        inky:render(inkyImg)
        clyde:render(clydeImg)

        -- debug = tostring(inky.targetx)..' '..tostring(inky.targety)..' '..tostring(blinky.x)..' '..tostring(blinky.y)
       --  ..' '..tostring(pacman.x + 2*pacman.dx)..' '..tostring(pacman.y + 2*pacman.dy)
        -- love.graphics.print(debug,0,0)
        -- love.graphics.draw(debugImg, (pacman.y + 2*pacman.dy-1)*8, 24 + (pacman.x + 2*pacman.dx-1)*8)
        -- love.graphics.draw(debugImg, (inky.targety-1)*8, 24 + (inky.targetx-1)*8)
    push:finish()
end
