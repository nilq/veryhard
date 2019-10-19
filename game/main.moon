state = require 'src'

love.load = ->
    state.load!

love.update = (dt) ->
    state.update dt

love.draw = ->
    state.draw!

love.keypressed = (key) ->
    state.keypressed key