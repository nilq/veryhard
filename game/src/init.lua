game = {
  map_view = true
}
local map = require('src/map')
game.load = function()
  return map.load()
end
game.update = function(dt) end
game.draw = function()
  if game.map_view then
    return map.draw()
  end
end
game.keypressed = function(key)
  if game.map_view then
    return map.keypressed(key)
  end
end
return game
