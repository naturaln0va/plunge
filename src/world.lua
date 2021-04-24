World = Object:extend()

function World:new(w, h, offset)
  self.width = w or 0
  self.height = h or 0
  self.offset = offset or 0

  self.bounds = {
    width = w * 4,
    height = h * 6
  }
  self.bounds.x = (self.bounds.width * -0.5) + (self.width / 2)
  self.bounds.y = 0

  -- load fonts
  self.debugFont = love.graphics.newFont('res/express-mono.ttf', 18)

  -- load sprites
  self.cloudImage = love.graphics.newImage('res/clouds.png')
  self.cloudImage:setWrap('repeat')

  self.cloudQuad = love.graphics.newQuad(
    0,
    0,
    self.cloudImage:getWidth() * 18,
    self.cloudImage:getHeight(),
    self.cloudImage:getDimensions()
  )
end

function World:update(dt)
end

function World:draw()
  love.graphics.setColor(70 / 255, 90 / 255, 216 / 255, 0.8)

  love.graphics.rectangle(
    'fill',
    self.bounds.x,
    self.offset,
    self.bounds.width,
    self.bounds.height
  )
end

function World:drawBackground()
  love.graphics.setColor(1, 1, 1, 1)

  local x, y, cloudsWidth, cloudsHeight = self.cloudQuad:getViewport()

  love.graphics.draw(
    self.cloudImage,
    self.cloudQuad,
    self.width / 2,
    self.offset,
    0,
    1,
    1,
    cloudsWidth / 2,
    self.cloudImage:getHeight()
  )
end