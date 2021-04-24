Player = Object:extend()

function Player:new(x, y)
  self.x = x
  self.y = y
  self.hsp = 0
  self.vsp = 0
  self.dir = 1
  self.angle = 0
  self.standImage = love.graphics.newImage('res/diver-stand.png')

  self.inBoat = true

  self.boatSpeed = 5
  self.boatAccel = 0.025

  self.speed = self.boatSpeed
  self.accel = self.boatAccel
end

function Player:update(dt, input)
  if input.hPressed then
    if input.rightPressed then
      self.dir = -1
    elseif input.leftPressed then
      self.dir = 1
    end

    self.hsp = self.hsp + (-self.dir * self.accel)
    self.hsp = clamp(self.hsp, 1, -1)
  else
    self.hsp = approach(self.hsp, 0, self.accel)
  end

  self.x = self.x + (self.hsp * self.speed)
end

function Player:draw()
  local imageToDraw = self.standImage

  love.graphics.draw(
    imageToDraw,
    self.x,
    self.y,
    self.angle,
    self.dir,
    1,
    imageToDraw:getWidth() / 2,
    imageToDraw:getHeight()
  )
end
