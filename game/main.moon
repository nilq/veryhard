state = require 'src'

math.lerp = (a, b, t) ->
    (1 - t) * a + t * b

math.sign = (a) ->
    if a < 0
        -1
    elseif a > 0
        1
    else
        0

love.load = ->
    state.load!

love.update = (dt) ->
    state.update dt

love.draw = ->
    state.draw!

love.keypressed = (key) ->
    state.keypressed key

love.mousepressed = (x, y, button) ->
    state.mousepressed x, y, button