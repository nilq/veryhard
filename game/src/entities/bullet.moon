make = (x, y) ->
    bullet = {
        :x
        :y
        angle: 0
        speed: 400
        dx: 1
        dy: 1
        tag: "bullet"
    }

    bullet.update = (dt) =>
        @x, @y, collisions = world\move @, @x + dt * @speed * (math.cos @dx * @angle), @y + dt * @speed * (math.sin @dy * @angle), (bullet, c) ->
            if c.tag == "player"
                nil
            else
                "slide"

        for c in *collisions
            unless c.other.tag == "player"
                c.other\die @angle if c.other.die

                for i, b in ipairs game.bullets
                    if @ == b
                        table.remove game.bullets, i
                        world\remove @


    bullet.draw = =>
        with love.graphics
            .setColor 1, 1, 0
            .line @x, @y, (@x + 20 * math.cos @angle), @y + 20 * math.sin @angle


    world\add bullet, bullet.x, bullet.y, 2, 2

    bullet

{
    :make
}