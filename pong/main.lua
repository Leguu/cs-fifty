WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

Object = require 'classic'
push = require 'push'

Ball = require 'Ball'
Paddle = require 'Paddle'

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  font = love.graphics.setNewFont('font.ttf', 8)

  math.randomseed(os.time())

  ball = Ball(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)

  player = Paddle(10, 20)
  enemy = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 20 - Paddle.HEIGHT)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

  state = 'off'
end

function love.keypressed(key)
  if key == 'q' then love.event.quit() end

  if key == 'space' and state == 'off' then
    state = 'on'
  elseif key == 'space' and state == 'on' then
    state = 'off'
    ball:reset(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)
  end
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    player:ascend(dt)
  elseif love.keyboard.isDown('s') then
    player:descend(dt)
  end

  if love.keyboard.isDown('up') then
    enemy:ascend(dt)
  elseif love.keyboard.isDown('down') then
    enemy:descend(dt)
  end

  if state ~= 'on' then return end

  ball:update(dt)
end

function love.draw()
  push:apply('start')

  love.graphics.clear(40 / 255, 45 / 255, 52 / 255)

  love.graphics.printf('Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

  ball:draw()

  player:draw()
  enemy:draw()

  push:apply('end')
end
