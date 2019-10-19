make = (x, y) ->
    floor = {}

    floor.draw = ->
        with love.graphics
            .setColor 107 / 255, 74 / 255, 22 / 255
            .rectangle "fill", x, y, 20, 20

    floor

{
    :make
}