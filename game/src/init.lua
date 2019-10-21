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
local show_pie = false
game.spawn = function(k, x, y)
  game.camera = camera(0, 0, 1, 1, 0)
  local entities = require("src/entities")
  local entity_make = entities[k].make
  local entity = entity_make(x, y)
  table.insert(game.objects, entity)
  if entity.load then
    entity:load()
  end
  if k == "player" then
    game.player = entity
  end
  return entity
end
game.load = function()
  world = bump.newWorld()
  game.objects = { }
  game.zoom = 1
  light_world = light({
    ambient = {
      0.75,
      0.75,
      0.75
    },
    refractionStrength = 2.0,
    reflectionVisibility = 0,
    shadowBlur = 5.0
  })
  light_player = light_world:newLight(0, 0, 1, 127 / 255, 63 / 255, 3000)
  light_player:setSmooth(2)
  light_player:setGlowStrength(0.3)
  light_player:setGlowSize(170)
  light_player.normalInvert = true
  return map.load()
end
game.update = function(dt)
  if show_pie then
    pie:attach()
  end
  game.camera.sx = game.zoom
  game.camera.sy = game.zoom
  game.zoom = math.lerp(game.zoom, 3, dt / 1.5)
  local _list_0 = game.objects
  for _index_0 = 1, #_list_0 do
    local entity = _list_0[_index_0]
    if entity.update then
      entity:update(dt)
    end
  end
  light_world:update(dt)
  if show_pie then
    return pie:detach()
  end
end
game.draw = function()
  if game.map_view then
    map.draw()
  else
    light_world:draw(function()
      love.graphics.clear(0, 0, 0)
      local _list_0 = game.objects
      for _index_0 = 1, #_list_0 do
        local entity = _list_0[_index_0]
        if entity.draw then
          entity:draw()
        end
      end
    end)
  end
  love.graphics.print(love.timer.getFPS(), 10, 10)
  if not (show_pie) then
    return 
  end
  love.graphics.push()
  love.graphics.scale(0.85, 0.85)
  love.graphics.translate(-400, -250)
  pie:draw()
  return love.graphics.pop()
end
game.keypressed = function(key)
  if game.map_view then
    return map.keypressed(key)
  else
    if key == "tab" then
      game.load()
    elseif key == "e" then
      show_pie = not show_pie
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
