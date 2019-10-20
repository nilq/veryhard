game = {
  map_view = false,
  objects = { }
}
sprites = require("src/sprites")
weapons = require("src/weapons")
local light = require("libs/light")
local map = require("src/map")
local bump = require("libs/bump")
local camera = require("libs/camera")
local piefiller = require("libs/piefiller")
local pie = piefiller:new()
game.spawn = function(k, x, y)
  game.camera = camera(0, 0, 5, 5, 0)
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
  light_world = light({
    ambient = {
      155,
      155,
      155
    },
    refractionStrength = 32.0,
    reflectionVisibility = 2,
    shadowBlur = 2.0
  })
  light_player = light_world:newLight(0, 0, 1, 127 / 255, 63 / 255, 500)
  light_player:setSmooth(2)
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
  return light_world:update(dt)
end
game.draw = function()
  if game.map_view then
    map.draw()
  else
    light_world:draw(function()
      love.graphics.rectangle("fill", 0, 0, 0, 0)
      local _list_0 = game.objects
      for _index_0 = 1, #_list_0 do
        local entity = _list_0[_index_0]
        if entity.draw then
          entity:draw()
        end
      end
    end)
  end
  return love.graphics.print(love.timer.getFPS(), 10, 10)
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
game.mousepressed = function(x, y, button)
  local _list_0 = game.objects
  for _index_0 = 1, #_list_0 do
    local entity = _list_0[_index_0]
    if entity.mousepressed then
      entity:mousepressed(x, y, button)
    end
  end
end
return game
