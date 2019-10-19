local state = require('src')
math.lerp = function(a, b, t)
  return (1 - t) * a + t * b
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
