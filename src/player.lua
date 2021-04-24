Player = Object:extend()

function Player:new(x, y)
  self.x = x
  self.y = y
  self.hsp = 0
  self.vsp = 0
  self.hdir = 1
  self.vdir = 1
  self.angle = 0
  self.standImage = love.graphics.newImage('res/diver-stand.png')

  self.inBoat = true

  self.boatSpeed = 5
  self.boatAccel = 0.025

  self.swimSpeed = 7
  self.swimAccel = 0.07

  self.speed = self.boatSpeed
  self.accel = self.boatAccel
end

function Player:update(dt, input)
  if input.hPressed then
    if input.rightPressed then
      self.hdir = -1
    elseif input.leftPressed then
      self.hdir = 1
    end

    self.hsp = self.hsp + (-self.hdir * self.accel)
    self.hsp = Clamp(self.hsp, 1, -1)
  else
    self.hsp = Approach(self.hsp, 0, self.accel)
  end

  self.x = self.x + (self.hsp * self.speed)

  if self.inBoat and (input.jumpPressed or input.upPressed) then
    self.inBoat = false
    self.speed = self.swimSpeed
    self.accel = self.swimAccel
    -- dive out, and restrict vertical movement. still stear as diving
  end

  if self.inBoat then
    return
  end

  if input.vPressed then
    if input.upPressed then
      self.vdir = 1
    elseif input.downPressed then
      self.vdir = -1
    end

    self.vsp = self.vsp + (-self.vdir * self.accel)
    self.vsp = Clamp(self.vsp, 1, -1)
  else
    self.vsp = Approach(self.vsp, 0, self.accel)
  end

  self.y = self.y + (self.vsp * self.speed)
end

function Player:draw()
  local imageToDraw = self.standImage

  love.graphics.draw(
    imageToDraw,
    self.x,
    self.y,
    self.angle,
    self.hdir,
    self.vdir,
    imageToDraw:getWidth() / 2,
    imageToDraw:getHeight()
  )
end
