Object = require('utils/classic')
push = require('utils/push')

require('const')

local bird = require('bird')()
local camera = require('camera')(0, 0)

function love.load()
  love.window.setTitle('Flappy Bird')

  love.graphics.setDefaultFilter('nearest', 'nearest')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  if key == 'q' then love.event.quit() end
end

function love.update(dt)
  bird:update(dt)
end

function love.draw()
  push:start()

  camera:draw(background, 0.35)
  camera:draw(foreground, 0.9)

  camera:draw(bird)

  push:finish()
end
