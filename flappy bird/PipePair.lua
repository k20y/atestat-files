PipePair = Class{}

local PIPE_HEIGHT = love.graphics.newImage('assets/pipe.png'):getHeight()
local PIPE_WIDTH = love.graphics.newImage('assets/pipe.png'):getWidth()
local GAP_HEIGHT = 80

local PIPE_SPEED = 140

function PipePair:init(y)

    self.x = VIRTUAL_WIDTH
    self.y = y

    self.pipes = 
    {
        ['upper'] = Pipe('top',self.y),
        ['lower'] = Pipe('bottom',self.y + GAP_HEIGHT + PIPE_HEIGHT)
    }

    self.remove = false
    self.scored = false
end

function PipePair:update(dt)

    if self.x > - PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED *dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end 
end

function PipePair:render()
    for i,pipe in pairs(self.pipes) do
        pipe:render()
    end
end