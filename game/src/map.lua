local map_generator = { }
local map = { }
local square = 20
local width = love.graphics.getWidth() / square
local height = love.graphics.getHeight() / square - 1
love.graphics.setBackgroundColor(189 / 255, 135 / 255, 49 / 255)
local turn_prop = 0.3
local worm_prop = 0.1
local player_set = false
local playerx = 0
local playery = 0
local lonely_max = 3
local start_steps = 1000
local steps = start_steps
local dir = {
  left = 0,
  up = 1,
  right = 2,
  down = 3
}
local clamp
clamp = function(a, b, x)
  if x < a then
    return a
  elseif x > b then
    return b
  else
    return x
  end
end
local mapgen
mapgen = function(x, y)
  local player = math.random(0, steps)
  local wormx = x or math.floor(width / 2)
  local wormy = y or math.floor(height / 2)
  local wormr = math.random(0, 3)
  local rotate
  rotate = function()
    wormr = math.random(0, 3)
  end
  local forward
  forward = function()
    local _exp_0 = wormr
    if dir.left == _exp_0 then
      wormx = wormx - 1
    elseif dir.up == _exp_0 then
      wormy = wormy - 1
    elseif dir.down == _exp_0 then
      wormy = wormy + 1
    elseif dir.right == _exp_0 then
      wormx = wormx + 1
    end
    wormx = clamp(0, #map, wormx)
    wormy = clamp(0, #map[0], wormy)
  end
  for i = 0, steps do
    local _continue_0 = false
    repeat
      forward()
      if (math.random(0, 1000)) / 1000 < turn_prop then
        rotate()
      end
      if (math.random(0, 1000)) / 1000 < worm_prop then
        steps = steps / 2
        mapgen(wormx, wormy)
      end
      if wormx < #map - 1 and wormy < #map[0] - 1 and wormx > 1 and wormy > 1 then
        map[wormx][wormy] = 1
        rotate()
        if i > player and not player_set then
          if map[wormx][wormy] ~= 1 then
            _continue_0 = true
            break
          end
          playerx, playery = wormx, wormy
          player_set = true
        end
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
local count_neighbors
count_neighbors = function(x, y, a)
  local accum = 0
  for dx = -1, 1 do
    for dy = -1, 1 do
      if map[x + dx] and map[x + dx][y + dy] then
        if map[x + dx][y + dy] == a then
          accum = accum + 1
        end
      end
    end
  end
  return accum
end
local postfix
postfix = function()
  for x = 0, width do
    for y = 0, height do
      local _continue_0 = false
      repeat
        if (count_neighbors(x, y, 0)) > lonely_max or map[x][y] == 1 then
          _continue_0 = true
          break
        end
        map[x][y] = 1
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
  end
  for x = 0, width do
    for y = 0, height do
      local _continue_0 = false
      repeat
        if map[x][y] == 0 and (count_neighbors(x, y, 1)) > 0 then
          map[x][y] = 2
          _continue_0 = true
          break
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
  end
end
map_generator.load = function()
  steps = start_steps
  math.randomseed(os.time())
  map = { }
  player_set = false
  for x = 0, width do
    local row = { }
    for y = 0, height do
      row[y] = 0
    end
    map[x] = row
  end
  mapgen()
  return postfix()
end
map_generator.draw = function()
  for x = 0, width do
    for y = 0, width do
      local _continue_0 = false
      repeat
        do
          local _with_0 = love.graphics
          if playerx == x and playery == y then
            _with_0.setColor(1, 1, 0)
            _with_0.rectangle("fill", x * square, y * square, square, square)
            _continue_0 = true
            break
          end
          local _exp_0 = map[x][y]
          if 0 == _exp_0 then
            _with_0.setColor(107 / 255, 74 / 255, 22 / 255)
            _with_0.rectangle("fill", x * square, y * square, square, square)
          elseif 3 == _exp_0 then
            _with_0.setColor(1, 0, 0)
            _with_0.rectangle("fill", x * square, y * square, square, square)
          elseif 2 == _exp_0 then
            local a = 2
            _with_0.setColor(107 / a / 255, 74 / a / 255, 22 / a / 255)
            _with_0.rectangle("fill", x * square, y * square, square, square)
          elseif 1 == _exp_0 then
            _continue_0 = true
            break
          end
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
  end
end
map_generator.keypressed = function(key)
  if key == "space" then
    return love.load()
  end
end
return map_generator
