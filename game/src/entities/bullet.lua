local make
make = function(x, y)
  local bullet = {
    x = x,
    y = y,
    angle = 0,
    speed = 1000,
    dx = 1,
    dy = 1
  }
  bullet.update = function(self, dt)
    self.x, self.y = self.x + dt * self.speed * (math.cos(self.dx * self.angle)), self.y + dt * self.speed * math.sin(self.dy * self.angle)
  end
  bullet.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 0)
      _with_0.line(self.x, self.y, (self.x + 20 * math.cos(self.angle)), self.y + 20 * math.sin(self.angle))
      return _with_0
    end
  end
  return bullet
end
return {
  make = make
}
