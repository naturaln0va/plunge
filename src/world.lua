World = Object:extend()

function World:new(w, h)
  self.width = w or 0
  self.height = h or 0

  -- load fonts
  self.debugFont = love.graphics.newFont('res/express-mono.ttf', 18)
end

function World:update(dt)
end

function World:drawWater(offset)
  love.graphics.setColor(70 / 255, 90 / 255, 216 / 255, 0.8)

  local largeWidth = self.width * 3
  love.graphics.rectangle('fill', -(largeWidth / 2), offset, largeWidth, self.height * 3)
end