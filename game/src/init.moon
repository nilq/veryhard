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

show_pie = false

game.spawn = (k, x, y) ->
    game.camera = camera 0, 0, 1, 1, 0

    entities    = require "src/entities"
    entity_make = entities[k].make

    entity = entity_make x, y
    table.insert game.objects, entity
    entity\load! if entity.load

    if k == "player"
        game.player = entity

    entity

game.load = ->
    export world = bump.newWorld!
    game.objects = {}
    game.zoom    = 1

    export light_world = light
        ambient: { 0.75, 0.75, 0.75 }
        refractionStrength: 2.0,
        reflectionVisibility: 0
        shadowBlur: 5.0

    export light_player = light_world\newLight 0, 0, 1, 127/255, 63/255, 3000
    light_player\setSmooth 2
    light_player\setGlowStrength 0.3
    light_player\setGlowSize 170
    light_player.normalInvert = true

    map.load!

game.update = (dt) ->
    pie\attach! if show_pie
    
    game.camera.sx = game.zoom
    game.camera.sy = game.zoom

    game.zoom = math.lerp game.zoom, 3, dt / 1.5

    for entity in *game.objects
        entity\update dt if entity.update

    light_world\update dt

    pie\detach! if show_pie

game.draw = ->
    if game.map_view
        map.draw!
    else
        light_world\draw ->
            love.graphics.clear 0, 0, 0
            for entity in *game.objects
                entity\draw! if entity.draw
        
    love.graphics.print love.timer.getFPS!, 10, 10

    return unless show_pie

    love.graphics.push!
    love.graphics.scale 0.85, 0.85
    love.graphics.translate -400, -250

    pie\draw!

    love.graphics.pop!

game.keypressed = (key) ->
    if game.map_view
        map.keypressed key
    else
        if key == "tab"
            game.load!
        elseif key == "e"
            show_pie = not show_pie

        for entity in *game.objects
            entity\keypressed key if entity.keypressed

game.mousepressed = (x, y, button) ->
    for entity in *game.objects
        entity\mousepressed x, y, button if entity.mousepressed

game