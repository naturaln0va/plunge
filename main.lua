
DEBUG = false
PAUSE = false

function love.load()
  -- load files
  Object = require 'src.classic'
  require 'src.util'
  require 'src.input'
  require 'src.world'
  require 'src.player'
  require 'src.boat'

  -- graphics setup
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.graphics.setBackgroundColor(178 / 255, 234 / 255, 1, 1)

  function setupGame()
    world = World(love.graphics.getWidth(), love.graphics.getHeight())
    player = Player(world.width * 0.5, world.width * 0.45)
    boat = Boat(player)
    input = Input()
  end

  setupGame()
end

function love.update(dt)
  input:update(dt)

  if PAUSE or not love.window.hasFocus() then
    return
  end

  world:update(dt)

  player:update(dt, input)
  boat:update(dt)
end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)

  player:draw()
  boat:draw()
  world:drawWater(boat.y - 7)

  if DEBUG then
    debugParts = {
      'paused: ' .. tostring(PAUSE),
      'player coords: ' .. string.format('(%d, %d)', player.x, player.y),
      'player hsp: ' .. string.format('%.2f', player.hsp),
      'player in boat: ' .. tostring(player.inBoat),
      'fps: ' .. love.timer.getFPS()
    }
    debugMessage = table.concat(debugParts, '\n')

    love.graphics.setFont(world.debugFont)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle(
      'fill', 
      10, 
      10, 
      world.debugFont:getWidth(debugMessage) + 20, 
      (world.debugFont:getHeight(debugMessage) * 5) + 20
    )
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(debugMessage, 20, 20)
  end
end