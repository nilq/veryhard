make = (x, y) ->
    bullet = {
        :x
        :y
        angle: 0
        speed: 1000
        dx: 1
        dy: 1
    }

    bullet.update = (dt) =>
        @x, @y = @x + dt * @speed * (math.cos @dx * @angle), @y + dt * @speed * math.sin @dy * @angle


    bullet.draw = =>
        with love.graphics
            .setColor 1, 1, 0
            .line @x, @y, (@x + 20 * math.cos @angle), @y + 20 * math.sin @angle


    bullet

{
    :make
}