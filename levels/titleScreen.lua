TitleScreen = Middleclass('TitleScreen')

function TitleScreen:initialize()
  self.creation_time = love.timer.getTime()
  --self.current_time  = 0
end

function TitleScreen:update(dt)
  --self.current_time = self.current_time + dt
end

function TitleScreen:draw()
    love.graphics.print('This is the level: TitleScreen. It is not very exciting now, but just you wait until I make graphics for it!', 0, 100 )
    love.graphics.print('(It might be slightly more exciting)', 10, 110)
    --love.graphcis.print('The title screen has been active for'..self.current_time..'seconds', 0, 150)
end
