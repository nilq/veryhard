make = (x, y) ->
    player = {
        :x
        :y
        dx: 0
        dy: 0,
        speed: 20
        friction: 5
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

        with game.camera
            .x = math.lerp .x, @x - love.graphics.getWidth! / 2 / game.camera.sx, dt * 5
            .y = math.lerp .y, @y - love.graphics.getHeight! / 2 / game.camera.sy, dt * 5

    player.draw = =>
        with love.graphics
            .setColor 1, 1, 0
            .rectangle "fill", @x, @y, 12, 12

            mouse_x = (game.camera.x + love.mouse.getX! / game.camera.sx)
            mouse_y = (game.camera.y + love.mouse.getY! / game.camera.sy)

            .setColor 1, 0, 0
            .line mouse_x, mouse_y, @x, @y

    world\add player, x, y, 12, 12    

    player

{
    :make
}