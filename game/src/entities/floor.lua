local make
make = function(x, y)
  local floor = { }
  floor.draw = function()
    do
      local _with_0 = love.graphics
      _with_0.setColor(107 / 255, 74 / 255, 22 / 255)
      _with_0.rectangle("fill", x, y, 20, 20)
      return _with_0
    end
  end
  return floor
end
return {
  make = make
}
