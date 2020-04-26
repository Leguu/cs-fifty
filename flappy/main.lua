Object = require('utils/classic')
push = require('utils/push')

require('const')

local Pipe = require('pipe')

local pipe = Pipe()

local bird = require('bird')()
local camera = require('camera')(0, 0)

function love.load()
  -- Library setup
  love.window.setTitle('Flappy Bird')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

  -- Game setup
  math.randomseed(os.time())

  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  if key == 'q' then love.event.quit() end

  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key] and true or false
end

function love.update(dt)
  bird:update(dt)
  camera:follow(bird, 150)

  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()

  camera:draw(background, 0.35)
  camera:draw(foreground, 0.9)
  camera:draw(pipe)

  camera:draw(bird)

  push:finish()
end
