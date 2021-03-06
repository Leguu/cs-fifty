FPS_ENABLED = false

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

  sounds = {
    ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
  }

  math.randomseed(os.time())

  player = Paddle(10, 20)
  enemy = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 20 - Paddle.HEIGHT)
  ball = Ball(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

  state = 'serve'
end

function love.resize(w, h) push:resize(w, h) end

function love.keypressed(key)
  if key == 'q' or key == 'escape' then love.event.quit() end

  if key == 'space' and state == 'serve' then
    ball.velocity.x = (player.score + enemy.score) % 2 == 0 and
                          math.abs(ball.velocity.x) or
                          -math.abs(ball.velocity.x)
    ball.velocity.y = math.random(-20, 20)
    state = 'on'
  elseif key == 'space' and (state == 'on' or state == 'win') then
    player.score = 0
    enemy.score = 0
    state = 'serve'
    reset()
    player:reset(10, 20)
    enemy:reset(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 20 - Paddle.HEIGHT)
  end
end

function reset() ball:reset(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2) end

function love.update(dt)
  if love.keyboard.isDown('w') then player:ascend(dt) end
  if love.keyboard.isDown('s') then player:descend(dt) end

  -- if love.keyboard.isDown('up') then enemy:ascend(dt) end
  -- if love.keyboard.isDown('down') then enemy:descend(dt) end
  if ball.y < enemy.y then
    enemy:ascend(dt / 2)
  elseif ball.y > enemy.y + Paddle.HEIGHT then
    enemy:descend(dt / 2)
  end

  -- Only move the ball while the game is on
  if state ~= 'on' then return end

  ball:update(dt)

  if ball:isColliding(player) or ball:isColliding(enemy) then
    ball:handleCollision(dt, ball:isColliding(player) and player or enemy)
    love.audio.play(sounds.paddle_hit)
  end

  if ball.x + Ball.SIZE < 0 then
    enemy.score = enemy.score + 1
    state = 'serve'
    reset()
    love.audio.play(sounds.score)
  elseif ball.x > VIRTUAL_WIDTH then
    player.score = player.score + 1
    state = 'serve'
    reset()
    love.audio.play(sounds.score)
  end

  if player.score > 4 or enemy.score > 4 then state = 'win' end
end

function love.draw()
  push:start()
  love.graphics.clear(40 / 255, 45 / 255, 52 / 255)

  if state == 'serve' then
    local servingPlayer = (player.score + enemy.score) % 2 == 0 and 'left' or
                              'right'
    love.graphics.printf(
        'Player ' .. servingPlayer .. ' serves', 0, 20, VIRTUAL_WIDTH, 'center'
    )
    love.graphics.printf('Press SPACE to serve', 0, 30, VIRTUAL_WIDTH, 'center')
  end

  if state == 'win' then
    local winningPlayer = player.score > enemy.score and 'left' or 'right'

    love.graphics.printf(
        'Player ' .. winningPlayer .. ' has won!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center'
    )

    goto cleanup
  end

  if FPS_ENABLED then
    love.graphics.printf(love.timer.getFPS(), 20, 5, VIRTUAL_WIDTH, 'left')
  end

  player:draw()
  enemy:draw()
  ball:draw()

  ::cleanup::
  push:finish()
end
