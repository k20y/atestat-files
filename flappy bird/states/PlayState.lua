PlayState = Class{__includes = BaseState}

local PIPE_HEIGHT = love.graphics.newImage('assets/pipe.png'):getHeight()
local PIPE_WIDTH = love.graphics.newImage('assets/pipe.png'):getWidth()
local GAP_HEIGHT = 80

local SPAWN_TIMER_VALUE = 2

function PlayState:init()
    
    self.bird = Bird()
    self.pipePairs = {}
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    self.spawn_timer = 0
    self.score = 0
end

function PlayState:enter()
    self.spawn_timer = 0
    self.bird:jump()
end

function PlayState:update(dt)
    

    self.spawn_timer = self.spawn_timer + dt

    if self.spawn_timer > SPAWN_TIMER_VALUE then
        
        local y = math.max(-PIPE_HEIGHT +30, math.min(self.lastY + math.random(-50,50), VIRTUAL_HEIGHT - GAP_HEIGHT - PIPE_HEIGHT))
        table.insert(self.pipePairs,PipePair(y))

        self.spawn_timer = 0
    end

    for i,pair in pairs(self.pipePairs) do
        pair:update(dt)

        for j,pipe in pairs(pair.pipes) do

            if self.bird:collides(pipe) then
                sounds['explosion']:stop()
                sounds['explosion']:play()
                sounds['hurt']:play()
                gStateMachine:change('score',{
                    score = self.score
                })
            end
        end

        if not pair.scored then
            
            if self.bird.x > pair.x + PIPE_WIDTH then
                pair.scored = true
                self.score = self.score +1
                sounds['score']:play()
            end

        end
    end

    for i,pair in pairs(self.pipePairs) do
        
        if pair.remove == true then
            table.remove(self.pipePairs,i)
        end
    end

    self.bird:update(dt)

    if self.bird.y + self.bird.height> VIRTUAL_HEIGHT- 15 or self.bird.y < -self.bird.height then
        sounds['explosion']:stop()
        sounds['explosion']:play()
        sounds['hurt']:play()
        gStateMachine:change('score',{
            score = self.score
        })
    end


end

function PlayState:render()
    for i,pair in pairs(self.pipePairs) do
        
        pair:render()

    end
    self.bird:render()

    -- scrie scorul
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end