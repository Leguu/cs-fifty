local Bird = Object:extend()

function Bird:new()
  self.image = love.graphics.newImage('assets/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.pos = {
    x = VIRTUAL_WIDTH / 2 - (self.width / 2),
    y = VIRTUAL_HEIGHT / 2 - (self.height / 2),
  }
  self.pre = {x = self.pos.x, y = self.pos.y}
end

function Bird:update(dt)
  local dx = self.pos.x - self.pre.x
  local dy = self.pos.y - self.pre.y

  dy = dy + GRAVITY * dt

  self.pre.x = self.pos.x
  self.pre.y = self.pos.y

  self.pos.x = self.pos.x + dx
  self.pos.y = self.pos.y + dy
end

function Bird:draw(x, y)
  love.graphics.draw(self.image, x, y)
end

return Bird
