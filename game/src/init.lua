game = {
  map_view = false,
  objects = { }
}
local map = require("src/map")
local bump = require("libs/bump")
game.spawn = function(k, x, y)
  local entities = require("src/entities")
  local entity_make = entities[k].make
  local entity = entity_make(x, y)
  table.insert(game.objects, entity)
  if entity.load then
    return entity:load()
  end
end
game.load = function()
  world = bump.newWorld()
  game.objects = { }
  return map.load()
end
game.update = function(dt)
  local _list_0 = game.objects
  for _index_0 = 1, #_list_0 do
    local entity = _list_0[_index_0]
    if entity.update then
      entity:update(dt)
    end
  end
end
game.draw = function()
  if game.map_view then
    return map.draw()
  else
    local _list_0 = game.objects
    for _index_0 = 1, #_list_0 do
      local entity = _list_0[_index_0]
      if entity.draw then
        entity:draw()
      end
    end
  end
end
game.keypressed = function(key)
  if game.map_view then
    return map.keypressed(key)
  else
    if key == "tab" then
      game.load()
    end
    local _list_0 = game.objects
    for _index_0 = 1, #_list_0 do
      local entity = _list_0[_index_0]
      if entity.keypressed then
        entity:keypressed(key)
      end
    end
  end
end
return game
