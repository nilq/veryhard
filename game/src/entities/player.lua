local make
make = function(x, y)
  local player = {
    x = x,
    y = y,
    dx = 0,
    dy = 0,
    speed = 20,
    friction = 5
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
      return _with_0
    end
  end
  player.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 0)
      _with_0.rectangle("fill", self.x, self.y, 12, 12)
      local mouse_x = (game.camera.x + love.mouse.getX() / game.camera.sx)
      local mouse_y = (game.camera.y + love.mouse.getY() / game.camera.sy)
      _with_0.setColor(1, 0, 0)
      _with_0.line(mouse_x, mouse_y, self.x, self.y)
      return _with_0
    end
  end
  world:add(player, x, y, 12, 12)
  return player
end
return {
  make = make
}
