WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

background = {
  image = love.graphics.newImage('assets/background.png'),
  LOOPING_POINT = -413,
}

foreground = {
  image = love.graphics.newImage('assets/ground.png'),
  LOOPING_POINT = -VIRTUAL_WIDTH,
}

DRAG = {HORIZONTAL = 0.995, VERTICAL = 0.99}

function background:draw(x)
  love.graphics.draw(background.image, x % background.LOOPING_POINT)
end

function foreground:draw(x)
  love.graphics.draw(
      foreground.image, x % foreground.LOOPING_POINT,
      VIRTUAL_HEIGHT - foreground.image:getHeight()
  )
end

GRAVITY = 15
