make = (x, y) ->
    block = {
        :x
        :y
        tag: "block"
    }

    block.draw = =>
        with love.graphics
            .setColor 1, 1, 1
            .draw sprites.rock, x, y, 0, 24 / sprites.grass\getWidth!, 24 / sprites.grass\getHeight!

    world\add block, x, y, 24, 24
    light_world\newRectangle x + 12, y + 12, 24, 24

    block

{
    :make
}