Ai = Class{}

function Ai:init(state)
    
    self.state=state -- active / idle
    self.input=0
    self.y = nil
    self.debugy = 0
end

function Ai:move()
    
    if self.y == nil then
        self.input = 0
        return
    end

    if math.abs(math.floor(player2.y) - math.floor(self.y)) > 5  then

        if(math.floor(player2.y) > math.floor(self.y)) then
            self.input = -1
        else
            self.input = 1
        end

    else
        self.input = 0
    end

    if math.floor(player2.y) == math.floor(self.y) then
        self:goIdle()
    end

end

function Ai:goIdle()
    self.state = 'idle'
    self.input = 0
    self.y = nil
end

function Ai:calculate(x,y,dx,dy)

    t = (VIRTUAL_WIDTH-x-10)/dx
    self.y = math.floor(y + dy*t)

    nr = 0

    while self.y < 0 do
    self.y = self.y + VIRTUAL_HEIGHT
    nr = nr+1
    end

    while self.y > VIRTUAL_HEIGHT do
    self.y = self.y - VIRTUAL_HEIGHT
    nr = nr+1
    end

    if nr % 2 == 1 then
        self.y = VIRTUAL_HEIGHT - self.y
    end

    self.y = self.y - 10

end

