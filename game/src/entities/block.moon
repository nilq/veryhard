make = (x, y) ->
    block = {
        :x
        :y
    }

    block.draw = =>
        with love.graphics
            .setColor 107 / 2 / 255, 74 / 2 / 255, 22 / 2 / 255
            .rectangle "fill", @x, @y, 20, 20

    world\add block, x, y, 20, 20    

    block

{
    :make
}