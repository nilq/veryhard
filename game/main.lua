local state = require('src')
math.lerp = function(a, b, t)
  return (1 - t) * a + t * b
end
math.sign = function(a)
  if a < 0 then
    return -1
  elseif a > 0 then
    return 1
  else
    return 0
  end
end
love.load = function()
  return state.load()
end
love.update = function(dt)
  return state.update(dt)
end
love.draw = function()
  return state.draw()
end
love.keypressed = function(key)
  return state.keypressed(key)
end
love.mousepressed = function(x, y, button)
  return state.mousepressed(x, y, button)
end
