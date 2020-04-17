local Ball = Object:extend()
Ball.SIZE = 5

-- Initializes it centered to x and y
function Ball:new(x, y) self:reset(x, y) end

function Ball:reset(x, y)
  self.x = x - Ball.SIZE / 2
  self.y = y - Ball.SIZE / 2

  self.velocity = {
    x = math.random(-50, 50),
    y = math.random() < 0.5 and -100 or 100,
  }
end

function Ball:update(dt)
  self.x = self.x + self.velocity.x * dt
  self.y = self.y + self.velocity.y * dt
end

function Ball:draw()
  love.graphics.rectangle('fill', self.x, self.y, Ball.SIZE, Ball.SIZE)
end

return Ball
