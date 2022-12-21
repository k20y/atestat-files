Pacman = Class{}
local pacmanImg = love.graphics.newImage('assets_temp/pacman.png')
function Pacman:init(x,y)
    self.dx = 0
    self.dy = 1

    --queued direction

    self.qdx = 0
    self.qdy = 0

    self.x = x
    self.y = y

end

function Pacman:move()

    if not(maze[self.x + self.qdx][self.y + self.qdy] == -1) then
        self.dx = self.qdx
        self.dy = self.qdy
    end

    if self.x + self.dx == 15 and  self.y + self.dy == 29 then
        
        self.y = 1
    elseif self.x + self.dx == 15 and  self.y + self.dy == 0 then
        
        self.y = 28
    end
    if self.x + self.dx > 31 or  self.y + self.dy > 28 then
        return
    end

    if not(maze[self.x + self.dx][self.y + self.dy] == -1) then

        self.x = self.x + self.dx
        self.y = self.y + self.dy

    end
end

function Pacman:checkCollision()
    
end

function Pacman:render()
    love.graphics.draw(pacmanImg, (self.y-1)*8, 24 + (self.x-1)*8)
end