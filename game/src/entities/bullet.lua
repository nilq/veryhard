local make
make = function(x, y)
  local bullet = {
    x = x,
    y = y,
    angle = 0,
    speed = 400,
    dx = 1,
    dy = 1,
    tag = "bullet"
  }
  bullet.update = function(self, dt)
    local collisions
    self.x, self.y, collisions = world:move(self, self.x + dt * self.speed * (math.cos(self.dx * self.angle)), self.y + dt * self.speed * (math.sin(self.dy * self.angle)), function(bullet, c)
      if c.tag == "player" then
        return nil
      else
        return "slide"
      end
    end)
    for _index_0 = 1, #collisions do
      local c = collisions[_index_0]
      if not (c.other.tag == "player") then
        if c.other.die then
          c.other:die(self.angle)
        end
        for i, b in ipairs(game.bullets) do
          if self == b then
            table.remove(game.bullets, i)
            world:remove(self)
          end
        end
      end
    end
  end
  bullet.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 0)
      _with_0.line(self.x, self.y, (self.x + 20 * math.cos(self.angle)), self.y + 20 * math.sin(self.angle))
      return _with_0
    end
  end
  world:add(bullet, bullet.x, bullet.y, 2, 2)
  return bullet
end
return {
  make = make
}
