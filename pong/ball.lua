local Ball = Object:extend()
Ball.SIZE = 5

-- Initializes it centered to x and y
function Ball:new(x, y) self:reset(x, y) end

function Ball:reset(x, y)
  self.x = x - Ball.SIZE / 2
  self.y = y - Ball.SIZE / 2

  local verticality = math.random() < 0.5 and -1 or 1

  self.velocity = {
    x = verticality * (math.random() * 40 + 30),
    y = math.random() < 0.5 and -100 or 100,
  }
end

function Ball:handleCollision()
  self.velocity.x = -self.velocity.x
  self.x = self.x + self.velocity.x * 0.05
end

function Ball:isColliding(paddle)
  return
      (paddle.x < self.x + Ball.SIZE and self.x < paddle.x + Paddle.WIDTH) and
          (paddle.y < self.y + Ball.SIZE and self.y < paddle.y + Paddle.HEIGHT)
end

function Ball:update(dt)
  if self.y < 0 or VIRTUAL_HEIGHT < self.y + Ball.SIZE then
    self.velocity.y = -self.velocity.y
  end

  self.x = self.x + self.velocity.x * dt
  self.y = self.y + self.velocity.y * dt
end

function Ball:draw()
  love.graphics.rectangle('fill', self.x, self.y, Ball.SIZE, Ball.SIZE)
end

return Ball
