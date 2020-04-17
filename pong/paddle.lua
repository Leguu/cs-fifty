local Paddle = Object:extend()
Paddle.SPEED = 200
Paddle.WIDTH = 5
Paddle.HEIGHT = 20

function Paddle:new(x, y)
  self.x = x
  self.y = y
end

function Paddle:ascend(dt) self.y = math.max(0, self.y - Paddle.SPEED * dt) end

function Paddle:descend(dt)
  self.y = math.min(VIRTUAL_HEIGHT - Paddle.HEIGHT, self.y + Paddle.SPEED * dt)
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, Paddle.WIDTH, Paddle.HEIGHT)
end

return Paddle
