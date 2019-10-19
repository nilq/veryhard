make = (x, y) ->
    player = {
        :x
        :y
        dx: 0
        dy: 0,
        speed: 30
        friction: 4
    }

    player.input = (dt) =>
        dx, dy = 0, 0

        if love.keyboard.isDown "w"
            dy = -1
        elseif love.keyboard.isDown "s"
            dy = 1
    
        if love.keyboard.isDown "a"
            dx = -1
        elseif love.keyboard.isDown "d"
            dx = 1

        if dy != 0 and dy != 0
            len = math.sqrt dx^2 + dy^2

            @dx += (dx / len) * @speed * dt
            @dy += (dy / len) * @speed * dt
        else
            @dx += dx * @speed * dt
            @dy += dy * @speed * dt

    player.update = (dt) =>
        @input dt

        @x, @y, collisions = world\move @, @x + @dx, @y + @dy

        for c in *collisions
            if c.normal.x != 0
                @dx = 0
            if c.normal.y != 0
                @dy = 0

        @dx = math.lerp @dx, 0, dt * @friction
        @dy = math.lerp @dy, 0, dt * @friction

    player.draw = =>
        with love.graphics
            .setColor 1, 1, 0
            .rectangle "fill", @x, @y, 16, 16

    world\add player, x, y, 16, 16    

    player

{
    :make
}