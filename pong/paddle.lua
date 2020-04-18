local Paddle = Object:extend()
Paddle.SPEED = 200
Paddle.WIDTH = 5
Paddle.HEIGHT = 20

function Paddle:new(x, y)
  self:reset(x, y)
  self.score = 0
end

function Paddle:reset(x, y)
  self.x = x
  self.y = y
end

function Paddle:ascend(dt) self.y = math.max(0, self.y - Paddle.SPEED * dt) end

function Paddle:descend(dt)
  self.y = math.min(VIRTUAL_HEIGHT - Paddle.HEIGHT, self.y + Paddle.SPEED * dt)
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, Paddle.WIDTH, Paddle.HEIGHT)
  love.graphics.printf(
      self.score, self.x - 10, self.y - 15, Paddle.WIDTH + 20, 'center'
  )
end

return Paddle
