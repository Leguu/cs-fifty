-- 
-- PIPE
--
Pipe = Object:extend()

Pipe.IMAGE = love.graphics.newImage('assets/pipe.png')
Pipe.WIDTH = Pipe.IMAGE:getWidth()

function Pipe:new(y)
  self.y = y
end

function Pipe:draw(x, facingDown)
  love.graphics.draw(Pipe.IMAGE, x, self.y, 0, 1, facingDown and -1 or 1)
end

--
-- PIPE PAIRS
--
PipePair = Object:extend()

PipePair.DISTANCE_MIN = 200
PipePair.DISTANCE_VAR = 50

PipePair.GAP_MINIMUM = 90
PipePair.GAP_VARIABILITY = 20

function PipePair:new(x)
  self.x = x

  local upperHeight = math.random(40, 100)
  local lowerHeight = upperHeight + PipePair.GAP_MINIMUM +
                          math.random(PipePair.GAP_VARIABILITY)

  self.upper = Pipe(upperHeight)
  self.lower = Pipe(lowerHeight)
end

function PipePair:draw(x)
  self.upper:draw(x, true)
  self.lower:draw(x, false)
end
