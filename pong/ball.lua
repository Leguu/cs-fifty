local Ball = Object:extend()
Ball.SIZE = 5

-- Initializes it centered to x and y
function Ball:new(x, y) self:reset(x, y) end

function Ball:reset(x, y)
  self.x = x - Ball.SIZE / 2
  self.y = y - Ball.SIZE / 2

  self.velocity = {
    x = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100),
    y = math.random(2) == 1 and -100 or 100,
  }
end

function Ball:handleCollision(dt, paddle)
  self.velocity.x = -self.velocity.x * 1.03

  -- Set the velocity going in the same direction, but random
  self.velocity.y = self.velocity.y > 0 and math.random(10, 150) or
                        -math.random(10, 150)
  -- If the ball hit the paddle in the edges, make it faster
  self.velocity.y = self.velocity.y *
                        math.abs(
                            ((paddle.y + Paddle.HEIGHT / 2) -
                                (ball.y + Ball.SIZE / 2))
                        ) / 10

  self.x = self.x + self.velocity.x * dt
end

function Ball:isColliding(paddle)
  return
      (paddle.x < self.x + Ball.SIZE and self.x < paddle.x + Paddle.WIDTH) and
          (paddle.y < self.y + Ball.SIZE and self.y < paddle.y + Paddle.HEIGHT)
end

function Ball:update(dt)
  if self.y < 0 or VIRTUAL_HEIGHT < self.y + Ball.SIZE then
    self.velocity.y = -self.velocity.y
    love.audio.play(sounds.wall_hit)
  end

  self.x = self.x + self.velocity.x * dt
  self.y = self.y + self.velocity.y * dt
end

function Ball:draw()
  love.graphics.rectangle('fill', self.x, self.y, Ball.SIZE, Ball.SIZE)
end

return Ball
