local Bird = Object:extend()

Bird.IMAGE = love.graphics.newImage('assets/bird.png')
Bird.WIDTH = Bird.IMAGE:getWidth()
Bird.HEIGHT = Bird.IMAGE:getHeight()

function Bird:new()
  self.pos = {x = 50, y = VIRTUAL_HEIGHT / 2 - (Bird.HEIGHT / 2)}
  self.pre = {x = self.pos.x, y = self.pos.y}
end

-- Bird's physics is based on verlet integration
function Bird:update(dt)
  -- Get the velocity based on previous and new values
  local dx = self.pos.x - self.pre.x
  local dy = self.pos.y - self.pre.y

  dy = dy + GRAVITY * dt

  if love.keyboard.wasPressed('space') then
    dy = dy - 700 * dt
    dx = dx + 50 * dt
  end

  -- Set the previous value to be the current value
  self.pre.x = self.pos.x
  self.pre.y = self.pos.y

  -- Augment the position by the velocity
  self.pos.x = self.pos.x + dx * DRAG.HORIZONTAL
  self.pos.y = self.pos.y + dy * DRAG.VERTICAL
end

function Bird:draw(x, y)
  love.graphics.draw(Bird.IMAGE, x, y)
end

return Bird
