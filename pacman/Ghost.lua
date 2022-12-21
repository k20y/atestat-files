Ghost = Class{}

function Ghost:init(x,y,stargetx,stargety)
    

    -- position
    self.x = x
    self.y = y

    -- 
    self.targetx = 0
    self.targety= 0

    -- direction
    self.dx = 1
    self.dy = 0

    -- scatter target
    self.stargetx = stargetx
    self.stargety = stargety


    self.state = 'chase'

end

function Ghost:Handler()
    
    if self.state == 'chase' then
        self:getTarget()
    elseif self.state == 'scatter' then
        self.targetx = self.stargetx
        self.targety = self.stargety
    elseif self.state == 'eaten' then
        self.targetx = 13
        self.targety = 14 --or 15?
    end

    if not(self.state == 'frightened')then self:changeDirection()
    end
    self:move()
end


function  Ghost:changeDirection()
    
    -- add special case for frightened mode

    if self.state == 'frightened' then
        
    end

    --add special case at the beginning of a round

    local targetDist = nil

    --explanation goes brrrrr

    --up - cant go up on the special tiles

    

    local temp1 = math.sqrt((self.x-1 - self.targetx)*(self.x-1 - self.targetx) + (self.y - self.targety)*(self.y - self.targety))
    local temp2 = math.sqrt((self.x - self.targetx)*(self.x - self.targetx) + (self.y-1 - self.targety)*(self.y -1- self.targety))
    local temp3 = math.sqrt((self.x+1 - self.targetx)*(self.x+1 - self.targetx) + (self.y - self.targety)*(self.y - self.targety))
    local temp4 = math.sqrt((self.x - self.targetx)*(self.x - self.targetx) + (self.y+1 - self.targety)*(self.y +1- self.targety))
    
    local dx = self.dx
    local dy = self.dy

    if not(maze[self.x-1][self.y ] == -1) and (targetDist == nil or temp1 < targetDist) and not(maze[self.x][self.y] == 5) 
    and not(self.dx == 1)
    then
        dx = -1
        dy =  0
        targetDist = temp1
    end
    
    --left
    if not(maze[self.x ][self.y-1] == -1) and (targetDist == nil or temp2 < targetDist) 
    and not(self.dy == 1) then
        dx = 0
        dy = -1
        targetDist = temp2
    end

    --down
    if not(maze[self.x+1][self.y ] == -1) and (targetDist == nil or temp3 < targetDist) 
    and not(self.dx == -1) then
        dx = 1
        dy = 0
        targetDist = temp3
    end

    --right
    if not(maze[self.x ][self.y+1] == -1) and (targetDist == nil or temp4 < targetDist) 
    and not(self.dy == -1)then
        dx = 0
        dy = 1
        targetDist = temp4
    end
    self.dx = dx
    self.dy = dy
    
end
function Ghost:move()

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
function Ghost:render(image)
    love.graphics.draw(image,(self.y-1)*8, 24 + (self.x-1)*8)
end

function Ghost:getTarget()
end

Blinky = Class{__includes = Ghost}


function Blinky:getTarget()
    self.targetx = pacman.x
    self.targety = pacman.y
end

Pinky = Class{__includes = Ghost}


function Pinky:getTarget()
    self.targetx = pacman.x + 4*pacman.dx
    self.targety = pacman.y + 4*pacman.dy

    --simulate the overflow
    if pacman.dx == -1 then
        self.targety = self.targety - 4;
    end
end

Inky = Class{__includes = Ghost}

function Inky:getTarget()

    local ptargetx = pacman.x + 2*pacman.dx
    local ptargety = pacman.y + 2*pacman.dy

    if pacman.dx == -1 then
        ptargety = ptargety - 2
    end

    self.targetx =  blinky.x + 2*(ptargetx - blinky.x)
    self.targety =  blinky.y + 2*(ptargety - blinky.y) 
end

Clyde = Class{__includes = Ghost}

function Clyde:getTarget()

    if(math.sqrt((self.x - pacman.x)*(self.x - pacman.x) +(self.y - pacman.y)*(self.y - pacman.y)) <= 8) then
        self.targetx = self.stargetx
        self.targety = self.stargety
    else
        self.targetx = blinky.targetx
        self.targety = blinky.targety
    end

end