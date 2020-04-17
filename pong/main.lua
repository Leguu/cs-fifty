WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

Object = require 'utils/classic'
push = require 'utils/push'

Ball = require 'ball'
Paddle = require 'paddle'

function love.load()
  love.window.setTitle('Pong!')
  love.graphics.setDefaultFilter('nearest', 'nearest')

  font = love.graphics.setNewFont('font.ttf', 8)

  math.randomseed(os.time())

  player = Paddle(10, 20)
  enemy = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 20 - Paddle.HEIGHT)
  ball = Ball(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)

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

  -- Only move the ball while the game is on
  if state ~= 'on' then return end

  ball:update(dt)

  if ball:isColliding(player) or ball:isColliding(enemy) then
    ball:handleCollision()
  end
end

function love.draw()
  push:start()
  love.graphics.clear(40 / 255, 45 / 255, 52 / 255)

  love.graphics.printf('Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
  love.graphics.printf(love.timer.getFPS(), 20, 5, VIRTUAL_WIDTH, 'left')

  player:draw()
  enemy:draw()
  ball:draw()

  push:finish()
end
