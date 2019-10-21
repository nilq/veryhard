local make
make = function(parent, name, right)
  local gun = {
    x = parent.x,
    y = parent.y,
    sprite = sprites.guns[name],
    rotation = 0,
    flip = 1,
    radius = 4,
    right = right,
    parent = parent,
    shoot_timer = 0
  }
  do
    gun.w = gun.sprite:getWidth()
    gun.h = gun.sprite:getHeight()
  end
  gun.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 1)
      _with_0.draw(self.sprite, self.x, self.y, self.rotation, 0.8, 0.8 * self.flip, self.w / 2, self.h / 2)
      return _with_0
    end
  end
  gun.update = function(self, dt, x, y)
    self.rotation = math.atan2((self.y + self.h / 2) - y, (self.x + self.w / 2) - x)
    local a = -math.sign(x - self.x)
    if a ~= 0 then
      if 10 < math.abs(x - self.x) then
        self.flip = a
      end
    end
    if self.right then
      self.x, self.y = self.parent:weapon_pos_right()
    else
      self.x, self.y = self.parent:weapon_pos_left()
    end
    self.x = self.x - (self.radius * math.cos(self.rotation))
    self.y = self.y - (self.radius * math.sin(self.rotation))
    if self.shoot_timer > 0 then
      self.shoot_timer = self.shoot_timer - dt
    end
  end
  gun.shoot = function(self, x, y)
    if self.shoot_timer <= 0 then
      self.shoot_timer = 0.3
      local bullet = game.spawn("bullet", self.x, self.y)
      bullet.angle = math.atan2(y - (self.y + self.h / 2), x - (self.x + self.w / 2))
    end
  end
  return gun
end
return {
  make = make
}
