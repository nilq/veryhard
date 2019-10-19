local make
make = function(x, y)
  local block = {
    x = x,
    y = y
  }
  block.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(107 / 2 / 255, 74 / 2 / 255, 22 / 2 / 255)
      _with_0.rectangle("fill", self.x, self.y, 20, 20)
      return _with_0
    end
  end
  world:add(block, x, y, 20, 20)
  return block
end
return {
  make = make
}
