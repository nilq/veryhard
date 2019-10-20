export game = {
    map_view: false
    objects: {}
}

export sprites = require "src/sprites"
export weapons = require "src/weapons"

light   = require "libs/light"
map = require "src/map"
bump = require "libs/bump"
camera = require "libs/camera"
piefiller = require "libs/piefiller"

pie = piefiller\new!

game.spawn = (k, x, y) ->
    game.camera = camera 0, 0, 5, 5, 0

    entities    = require "src/entities"
    entity_make = entities[k].make

    entity = entity_make x, y
    table.insert game.objects, entity
    entity\load! if entity.load

game.load = ->
    export world = bump.newWorld!
    game.objects = {}

    export light_world = light
        ambient: { 155, 155, 155 }
        refractionStrength: 32.0,
        reflectionVisibility: 2
        shadowBlur: 2.0

    export light_player = light_world\newLight 0, 0, 1, 127/255, 63/255, 500
    light_player\setSmooth 2

    map.load!

game.update = (dt) ->
    for entity in *game.objects
        entity\update dt if entity.update

    light_world\update dt

game.draw = ->
    if game.map_view
        map.draw!
    else
        light_world\draw ->
            love.graphics.rectangle "fill", 0, 0, 0, 0 
            for entity in *game.objects
                entity\draw! if entity.draw
        
    love.graphics.print love.timer.getFPS!, 10, 10

game.keypressed = (key) ->
    if game.map_view
        map.keypressed key
    else
        if key == "tab"
            game.load!

        for entity in *game.objects
            entity\keypressed key if entity.keypressed

game.mousepressed = (x, y, button) ->
    for entity in *game.objects
        entity\mousepressed x, y, button if entity.mousepressed

game