export game = {
    map_view: true
}

map = require 'src/map'

game.load = ->
    map.load!

game.update = (dt) ->
    return

game.draw = ->
    if game.map_view
        map.draw!

game.keypressed = (key) ->
    if game.map_view
        map.keypressed key

game