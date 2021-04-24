
DEBUG = false
PAUSE = false

function love.load()
  -- load files
  Object = require 'src.classic'

  debugFont = love.graphics.newFont('res/express-mono.ttf', 18)

  love.graphics.setBackgroundColor(1, 0, 1, 1)
end

function love.update(dt)
  if PAUSE or not love.window.hasFocus() then
    return
  end


end

function love.keypressed(key)
  if key == 'd' then
    DEBUG = not DEBUG
  elseif key == 'p' then
    PAUSE = not PAUSE
  end
end

function love.draw()
  if DEBUG then
    love.graphics.setFont(debugFont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(table.concat({
      'paused: ' .. tostring(PAUSE),
      'fps: ' .. love.timer.getFPS()
    }, '\n'), 20, 20)
  end
end