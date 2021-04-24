
DEBUG = false
PAUSE = false

local world = {}
local player = {}
local boat = {}
local input = {}
local camera = {}

local function setupGame()
  local screenHeight = love.graphics.getHeight()
  local skyOffset = (screenHeight * 0.8)

  world = World(love.graphics.getWidth(), screenHeight, skyOffset - 7)
  player = Player(world.width * 0.5, skyOffset)
  boat = Boat(player)
  input = Input()
  camera = Camera(player.x, player.y)
end

function love.load()
  -- load files
  Object = require 'src.classic'
  require 'src.util'
  require 'src.input'
  require 'src.camera'
  require 'src.world'
  require 'src.player'
  require 'src.boat'

  -- graphics setup
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.graphics.setBackgroundColor(178 / 255, 234 / 255, 1, 1)

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

  local camCoord = {}
  
  if player.inBoat then
    camCoord.x = 0
    camCoord.y = 0
  else
    local camFollowDelay = 7

    local xTarget = player.x - (world.width / 2)
    camCoord.x = Approach(camera.x, xTarget, camFollowDelay)

    local yTarget = player.y - (world.height / 2)
    camCoord.y = Approach(camera.y, yTarget, camFollowDelay)
  end

  camera:follow(
    camCoord.x,
    camCoord.y
  )
  camera:contain(
    world.bounds.x,
    world.bounds.y,
    world.bounds.width - world.width,
    world.bounds.height - world.offset
  )
end

function love.draw()
  camera:set()
  love.graphics.setColor(1, 1, 1, 1)

  world:drawBackground()
  player:draw()
  boat:draw()
  world:draw()
  camera:unset()

  if DEBUG then
    local debugParts = {
      'paused: ' .. tostring(PAUSE),
      'player coords: ' .. string.format('(%d, %d)', player.x, player.y),
      'player hsp: ' .. string.format('%.2f', player.hsp),
      'player in boat: ' .. tostring(player.inBoat),
      'fps: ' .. love.timer.getFPS()
    }
    local debugMessage = table.concat(debugParts, '\n')

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