local state = require('src')
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
