
Input = Object:extend()

function Input:new()
  self.hNormal = 0
  self.vNormal = 0
  self.hPressed = false
  self.leftPressed = false
  self.rightPressed = false
  self.upPressed = false
  self.downPressed = false
  self.jumpPressed = false
end

function Input:update(dt)
  self.hNormal = 0
  self.vNormal = 0
  self.hPressed = false
  self.leftPressed = false
  self.rightPressed = false
  self.upPressed = false
  self.downPressed = false

  if love.keyboard.isDown('a', 'left') then
    self.leftPressed = true
  end

  if love.keyboard.isDown('d', 'right') then
    self.rightPressed = true
  end

  if love.keyboard.isDown('w', 'up') then
    self.upPressed = true
  end

  if love.keyboard.isDown('s', 'down') then
    self.downPressed = true
  end

  self.hNormal = boolToNumber(self.rightPressed) - boolToNumber(self.leftPressed)
  self.vNormal = boolToNumber(self.upPressed) - boolToNumber(self.downPressed)

  self.jumpPressed = love.keyboard.isDown('space')
  self.hPressed = self.leftPressed or self.rightPressed
end

function love.keypressed(key, scancode)
  if key == 'k' then
    DEBUG = not DEBUG
  elseif key == 'p' then
    PAUSE = not PAUSE
  end
end
