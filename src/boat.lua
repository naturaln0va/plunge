Boat = Object:extend()

function Boat:new(player)
  self.x = player.x
  self.y = player.y
  self.player = player
  self.angle = 0
  self.image = love.graphics.newImage('res/boat.png')
end

function Boat:update(dt)
  if self.player.inBoat then
    self.x = self.player.x
    self.y = self.player.y
  end
end

function Boat:draw()
  love.graphics.draw(
    self.image,
    self.x,
    self.y,
    self.angle,
    1,
    1,
    self.image:getWidth() / 2,
    self.image:getHeight()
  )
end
