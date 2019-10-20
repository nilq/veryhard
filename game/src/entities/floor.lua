local make
make = function(x, y)
  local floor = { }
  floor.draw = function()
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 1)
      _with_0.draw(sprites.grass, x, y, 0, 24 / sprites.grass:getWidth(), 24 / sprites.grass:getHeight())
      return _with_0
    end
  end
  return floor
end
return {
  make = make
}
