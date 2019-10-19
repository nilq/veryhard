local path = "src/entities/"
local player = require(path .. "player")
local block = require(path .. "block")
local floor = require(path .. "floor")
return {
  player = player,
  block = block,
  floor = floor
}
