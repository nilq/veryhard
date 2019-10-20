make = (x, y) ->
    floor = {}

    floor.draw = ->
        with love.graphics
            .setColor 1, 1, 1
            .draw sprites.grass, x, y, 0, 24 / sprites.grass\getWidth!, 24 / sprites.grass\getHeight!

    floor

{
    :make
}