local Camera = Object:extend()

function Camera:new(x, y)
  self.x = x
  self.y = y
end

function Camera:follow(entity, distance)
  if entity.pos.x > distance then self.x = entity.pos.x - distance end
end

function Camera:draw(entity, parallax)
  local parallax = parallax or 1
  local pos = entity.pos or {x = entity.x or 0, y = entity.y or 0}
  entity:draw((pos.x - self.x) * parallax, (pos.y - self.y) * parallax)
end

return Camera
