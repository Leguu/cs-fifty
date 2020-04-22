push = require 'utils/push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('assets/background.png')
local ground = love.graphics.newImage('assets/ground.png')

function love.load()
  love.window.setTitle('Flappy Bird')

  love.graphics.setDefaultFilter('nearest', 'nearest')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

end

function love.resize(w, h) push:resize(w, h) end

function love.keypressed(key) if key == 'q' then love.event.quit() end end

function love.draw()
  push:start()

  love.graphics.draw(background)
  love.graphics.draw(ground, 0, VIRTUAL_HEIGHT - 16)

  push:finish()
end
