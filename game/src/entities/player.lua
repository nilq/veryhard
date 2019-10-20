local make
make = function(x, y)
  local player = {
    x = x,
    y = y,
    w = 16,
    h = 16,
    direction = 1,
    dx = 0,
    dy = 0,
    speed = 20,
    friction = 5,
    weapon = { }
  }
  player.input = function(self, dt)
    local dx, dy = 0, 0
    if love.keyboard.isDown("w") then
      dy = -1
    elseif love.keyboard.isDown("s") then
      dy = 1
    end
    if love.keyboard.isDown("a") then
      dx = -1
    elseif love.keyboard.isDown("d") then
      dx = 1
    end
    if dy ~= 0 and dy ~= 0 then
      local len = math.sqrt(dx ^ 2 + dy ^ 2)
      self.dx = self.dx + ((dx / len) * self.speed * dt)
      self.dy = self.dy + ((dy / len) * self.speed * dt)
    else
      self.dx = self.dx + (dx * self.speed * dt)
      self.dy = self.dy + (dy * self.speed * dt)
    end
    if not (0 == math.sign(self.dx)) then
      self.direction = -math.sign(self.dx)
    end
  end
  player.update = function(self, dt)
    self:input(dt)
    local collisions
    self.x, self.y, collisions = world:move(self, self.x + self.dx, self.y + self.dy)
    for _index_0 = 1, #collisions do
      local c = collisions[_index_0]
      if c.normal.x ~= 0 then
        self.dx = 0
      end
      if c.normal.y ~= 0 then
        self.dy = 0
      end
    end
    self.dx = math.lerp(self.dx, 0, dt * self.friction)
    self.dy = math.lerp(self.dy, 0, dt * self.friction)
    do
      local _with_0 = game.camera
      _with_0.x = math.lerp(_with_0.x, self.x - love.graphics.getWidth() / 2 / game.camera.sx, dt * 5)
      _with_0.y = math.lerp(_with_0.y, self.y - love.graphics.getHeight() / 2 / game.camera.sy, dt * 5)
    end
    do
      local _with_0 = light_world
      _with_0.l = math.lerp(_with_0.l, -self.x * 5 + love.graphics.getWidth() / 2, dt * 5)
      _with_0.t = math.lerp(_with_0.t, -self.y * 5 + love.graphics.getHeight() / 2, dt * 5)
      _with_0.s = 5
    end
    if self.weapon.left then
      self.weapon.left:update(dt)
    end
    if self.weapon.right then
      self.weapon.right:update(dt)
    end
    return light_player:setPosition(self.x + self.w / 2, self.y + self.h / 2)
  end
  player.draw = function(self)
    if self.weapon.right.flip == 1 then
      if self.weapon.right then
        self.weapon.right:draw()
      end
    else
      if self.weapon.left then
        self.weapon.left:draw()
      end
    end
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 1)
      local w = sprites.player:getWidth()
      local h = sprites.player:getHeight()
      _with_0.draw(sprites.player, self.x + self.w / 2, self.y + self.h / 2, 0, self.weapon.right.flip * self.w / w, self.h / h, w / 2, h / 2)
    end
    if self.weapon.right.flip == -1 then
      if self.weapon.right then
        return self.weapon.right:draw()
      end
    else
      if self.weapon.left then
        return self.weapon.left:draw()
      end
    end
  end
  player.weapon_pos_right = function(self)
    if self.weapon.right.flip == 1 then
      return self.x + self.w / 5, self.y + self.h / 1.35
    else
      return self.x + self.w / 2, self.y + self.h / 1.25
    end
  end
  player.weapon_pos_left = function(self)
    if self.weapon.left.flip == -1 then
      return self.x + self.w / 1.6, self.y + self.h / 1.45
    else
      return self.x + self.w / 2, self.y + self.h / 1.25
    end
  end
  player.mousepressed = function(self, x, y, button)
    if self.weapon.left then
      self.weapon.left:mousepressed(x, y, button)
    end
    if self.weapon.right then
      return self.weapon.right:mousepressed(x, y, button)
    end
  end
  world:add(player, x, y, player.w, player.h)
  player.weapon.right = weapons.gun.make(player, "regular", true)
  player.weapon.left = weapons.gun.make(player, "regular", false)
  return player
end
return {
  make = make
}
