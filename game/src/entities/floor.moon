make = (x, y) ->
    floor = {}

    floor.draw = ->
        with love.graphics
            .setColor 189 / 255, 135 / 255, 49 / 255
            .rectangle "fill", x, y, 24, 24

    floor

{
    :make
}