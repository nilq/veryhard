local make
make = function(x, y, name)
  local enemy = {
    x = x,
    y = y,
    w = 16,
    h = 16,
    dx = 0,
    dy = 0,
    friction = 5,
    speed = 100,
    weapon = { },
    death_angle = 0,
    death_timer = 0,
    death_time = 0.4,
    shoot_interval = 1,
    shoot_clock = 0,
    dead = false,
    current_sprite = sprites.enemies[name].normal,
    name = name
  }
  enemy.update = function(self, dt)
    if self.dead then
      return 
    end
    self.shoot_clock = self.shoot_clock + dt
    if self.shoot_clock >= self.shoot_interval then
      if (math.random(0, 100)) / 100 < 30 then
        self.weapon.right:shoot(game.player.x, game.player.y)
      end
      self.shoot_clock = 0
    end
    if not (self.death_timer > 0) then
      local angle = math.atan2(game.player.y - self.y, game.player.x - self.x)
      self.dx = self.speed * math.cos(angle)
      self.dy = self.speed * math.sin(angle)
      self.dx = math.lerp(self.dx, 0, dt * self.friction)
      self.dy = math.lerp(self.dy, 0, dt * self.friction)
    end
    local collisions
    self.x, self.y, collisions = world:move(self, self.x + self.dx * dt, self.y + self.dy * dt)
    self.rect:setPosition(self.x + enemy.w / 2.5, self.y + enemy.h / 2)
    if self.weapon.right then
      self.weapon.right:update(dt, game.player.x, game.player.y)
    end
    if self.death_timer > 0 then
      self.death_timer = self.death_timer - dt
      if self.death_timer > self.death_time * 0.95 then
        self.dx = 200 * math.cos(self.death_angle)
        self.dy = 200 * math.sin(self.death_angle)
      end
      if self.death_timer <= 0 then
        for i, e in ipairs(game.objects) do
          if self == e then
            self.current_sprite = sprites.enemies[name].dead
            world:remove(self)
            self.dead = true
          end
        end
      end
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
      local w = self.current_sprite:getWidth()
      local h = self.current_sprite:getHeight()
      _with_0.setColor(1, 1, 1)
      _with_0.draw(self.current_sprite, self.x + w / 2, self.y + h / 2, 0, self.weapon.right.flip * self.w / w, self.h / h, w / 2, h / 2)
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
  enemy.die = function(self, angle)
    self.death_timer = self.death_time
    self.death_angle = angle
    self.current_sprite = sprites.enemies[name].shot
  end
  world:add(enemy, enemy.x, enemy.y, enemy.w, enemy.h)
  enemy.rect = light_world:newRectangle(x + enemy.w / 2.5, y + enemy.h / 2, 8, 12)
  enemy.weapon.right = weapons.gun.make(enemy, "regular", true)
  return enemy
end
return {
  make = make
}
