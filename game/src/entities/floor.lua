local make
make = function(x, y)
  local floor = { }
  floor.draw = function()
    do
      local _with_0 = love.graphics
      _with_0.setColor(189 / 255, 135 / 255, 49 / 255)
      _with_0.rectangle("fill", x, y, 24, 24)
      return _with_0
    end
  end
  return floor
end
return {
  make = make
}
