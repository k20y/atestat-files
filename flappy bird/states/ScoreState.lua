ScoreState = Class{__includes = BaseState}

function ScoreState:enter(enterParams)
    
    self.score = enterParams.score

end

function ScoreState:update(dt)

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        gStateMachine:change('play')

    end
end

function ScoreState:render()
    
    -- scrie scorul 

    love.graphics.setFont(flappyFont)
    love.graphics.printf('You lost lmao!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Space or Click to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

end