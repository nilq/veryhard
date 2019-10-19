state = require 'src'

math.lerp = (a, b, t) ->
    (1 - t) * a + t * b

love.load = ->
    state.load!

love.update = (dt) ->
    state.update dt

love.draw = ->
    state.draw!

love.keypressed = (key) ->
    state.keypressed key