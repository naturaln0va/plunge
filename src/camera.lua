
Camera = Object:extend()

function Camera:new(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function Camera:follow(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Camera:contain(bx, by, bw, bh)
  -- from the top left
  self.x = Clamp(self.x, bx, bx + bw)
  self.y = Clamp(self.y, by, by + bh)
end

function Camera:set()
  love.graphics.push()
  love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
  love.graphics.pop()
end
