export game = {
    map_view: false
    objects: {}
}

map = require "src/map"
bump = require "libs/bump"
camera = require "libs/camera"

game.spawn = (k, x, y) ->
    game.camera = camera 0, 0, 3, 3, 0

    entities    = require "src/entities"
    entity_make = entities[k].make

    entity = entity_make x, y
    table.insert game.objects, entity
    entity\load! if entity.load

game.load = ->
    export world = bump.newWorld!
    game.objects = {}

    map.load!

game.update = (dt) ->
    for entity in *game.objects
        entity\update dt if entity.update

game.draw = ->
    if game.map_view
        map.draw!
    else
        game.camera\set!

        for entity in *game.objects
            entity\draw! if entity.draw

        game.camera\unset!

game.keypressed = (key) ->
    if game.map_view
        map.keypressed key
    else
        if key == "tab"
            game.load!

        for entity in *game.objects
            entity\keypressed key if entity.keypressed

game