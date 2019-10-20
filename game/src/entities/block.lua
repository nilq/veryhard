local make
make = function(x, y)
  local block = {
    x = x,
    y = y
  }
  block.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 1)
      _with_0.draw(sprites.rock, x, y, 0, 24 / sprites.grass:getWidth(), 24 / sprites.grass:getHeight())
      return _with_0
    end
  end
  world:add(block, x, y, 24, 24)
  light_world:newRectangle(x + 12, y + 12, 24, 24)
  return block
end
return {
  make = make
}
