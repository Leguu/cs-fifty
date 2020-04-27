Object = require('utils/classic')
push = require('utils/push')

require('const')

local Bird = require('bird')
local bird = Bird()

local Camera = require('camera')
local camera = Camera()

local PipePair = require('pipe')
local pipes = {PipePair(300)}
local nextPipe = pipes[1].x + 200

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

  if pipes[1].x < VIRTUAL_WIDTH then
    table.insert(pipes, PipePair(nextPipe))
    nextPipe = nextPipe + PipePair.DISTANCE_MIN +
                   math.random(PipePair.DISTANCE_VAR)
  end

  for i, pipe in pairs(pipes) do
    if pipe.x + PipePair.WIDTH < camera.x then table.remove(pipes, i) end
  end

  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()

  camera:draw(background, 0.35)

  for i, pipe in pairs(pipes) do camera:draw(pipe) end

  camera:draw(foreground)

  camera:draw(bird)

  push:finish()
end
