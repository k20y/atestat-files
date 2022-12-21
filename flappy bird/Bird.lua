Bird = Class{}

local GRAVITY = 25
local JUMPFORCE  = 8

local PIPE_HEIGHT = love.graphics.newImage('assets/pipe.png'):getHeight()
local PIPE_WIDTH = love.graphics.newImage('assets/pipe.png'):getWidth()

function Bird:init()
    self.image = love.graphics.newImage('assets/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2

    self.dy = 0

end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY*dt

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self:jump()
    end

    self.y = self.y + self.dy
end

function Bird:jump()
    self.dy = - JUMPFORCE
    sounds['jump']:stop()
    sounds['jump']:play()
end

--[[
    AABB collision that expects a pipe, which will have an X and Y and reference
    global pipe width and height values.
]]
function Bird:collides(pipe)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH and
         (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        
    end

    return false
end

function Bird:render()
    love.graphics.draw(self.image,self.x,self.y)
end