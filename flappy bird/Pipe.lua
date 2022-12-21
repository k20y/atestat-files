Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('assets/pipe.png')

function Pipe:init(orientation,y)
    self.x = VIRTUAL_WIDTH
    self.y = y

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_IMAGE:getHeight()

    self.orientation = orientation
end

function Pipe:render()

        love.graphics.draw(PIPE_IMAGE,self.x,self.orientation == 'top' and self.y + self.height or self.y , 0, 1, self.orientation == 'top' and -1 or 1)
end