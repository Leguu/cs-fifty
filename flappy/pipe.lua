local Pipe = Object:extend()

Pipe.IMAGE = love.graphics.newImage('assets/pipe.png')
Pipe.WIDTH = Pipe.IMAGE:getWidth()

function Pipe:new()
  self.x = 400

  self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)
end

function Pipe:draw(x, y)
  love.graphics.draw(Pipe.IMAGE, x, y)
end

return Pipe
