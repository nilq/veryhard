local path = "src/entities/"
local player = require(path .. "player")
local block = require(path .. "block")
local floor = require(path .. "floor")
local enemy = require(path .. "enemy")
local bullet = require(path .. "bullet")
return {
  player = player,
  block = block,
  floor = floor,
  enemy = enemy,
  bullet = bullet
}
