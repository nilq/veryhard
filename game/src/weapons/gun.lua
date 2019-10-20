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
      if self.shoot_timer > 0 then
        local mouse_x = game.camera.x + love.mouse.getX() / game.camera.sx
        local mouse_y = game.camera.y + love.mouse.getY() / game.camera.sy
        _with_0.line(self.x, self.y, mouse_x, mouse_y)
      end
      _with_0.draw(self.sprite, self.x, self.y, self.rotation, 0.8, 0.8 * self.flip, self.w / 2, self.h / 2)
      return _with_0
    end
  end
  gun.update = function(self, dt)
    local mouse_x = game.camera.x + love.mouse.getX() / game.camera.sx
    local mouse_y = game.camera.y + love.mouse.getY() / game.camera.sy
    self.rotation = math.atan2((self.y + self.h / 2) - mouse_y, (self.x + self.w / 2) - mouse_x)
    local a = -math.sign(mouse_x - self.x)
    if a ~= 0 then
      if 10 < math.abs(mouse_x - self.x) then
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
  gun.mousepressed = function(self, x, y, button)
    if button == 1 then
      self.shoot_timer = 0.15
    end
  end
  return gun
end
return {
  make = make
}
