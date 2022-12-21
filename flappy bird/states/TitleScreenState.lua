TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    -- afiseaza titlul si press enter
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Space or Click', 0, 100, VIRTUAL_WIDTH, 'center')
end