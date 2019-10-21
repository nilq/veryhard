local make
make = function(x, y)
  local enemy = {
    x = x,
    y = y,
    w = 16,
    h = 16,
    dx = 0,
    dy = 0,
    friction = 5,
    speed = 100,
    weapon = { }
  }
  enemy.update = function(self, dt)
    local angle = math.atan2(game.player.y - self.y, game.player.x - self.x)
    self.dx = self.speed * math.cos(angle)
    self.dy = self.speed * math.sin(angle)
    self.dx = math.lerp(self.dx, 0, dt * self.friction)
    self.dy = math.lerp(self.dy, 0, dt * self.friction)
    local collisions
    self.x, self.y, collisions = world:move(self, self.x + self.dx * dt, self.y + self.dy * dt)
    self.rect:setPosition(self.x + enemy.w / 2.5, self.y + enemy.h / 2)
    if self.weapon.right then
      return self.weapon.right:update(dt, game.player.x, game.player.y)
    end
  end
  enemy.draw = function(self)
    if self.weapon.right.flip == 1 then
      if self.weapon.right then
        self.weapon.right:draw()
      end
    end
    do
      local _with_0 = love.graphics
      local w = sprites.enemies.tony:getWidth()
      local h = sprites.enemies.tony:getHeight()
      _with_0.setColor(1, 1, 1)
      _with_0.draw(sprites.enemies.tony, self.x + w / 2, self.y + h / 2, 0, self.weapon.right.flip * self.w / w, self.h / h, w / 2, h / 2)
    end
    if self.weapon.right.flip == -1 then
      if self.weapon.right then
        return self.weapon.right:draw()
      end
    end
  end
  enemy.weapon_pos_right = function(self)
    if self.weapon.right.flip == 1 then
      return self.x + self.w / 5, self.y + self.h / 1.35
    else
      return self.x + self.w / 2, self.y + self.h / 1.25
    end
  end
  enemy.mousepressed = function(self, x, y, button) end
  world:add(enemy, enemy.x, enemy.y, enemy.w, enemy.h)
  enemy.rect = light_world:newRectangle(x + enemy.w / 2.5, y + enemy.h / 2, 8, 12)
  enemy.weapon.right = weapons.gun.make(enemy, "regular", true)
  return enemy
end
return {
  make = make
}
