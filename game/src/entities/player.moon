make = (x, y) ->
    player = {
        :x
        :y
        w: 16
        h: 16
        direction: 1,
        dx: 0
        dy: 0,
        speed: 20
        friction: 5
        weapon: {}
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

        @direction = -math.sign @dx unless 0 == math.sign @dx

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

            -- light_world\setTranslation -@x * 5 + love.graphics.getWidth! / 2, -@y * 5 + love.graphics.getHeight! / 2, 5

        with light_world
            .l = math.lerp .l, -@x * game.zoom + love.graphics.getWidth! / 2, dt * game.zoom
            .t = math.lerp .t, -@y * game.zoom + love.graphics.getHeight! / 2, dt * game.zoom
            .s = game.zoom

        mouse_x = game.camera.x + love.mouse.getX! / game.camera.sx
        mouse_y = game.camera.y + love.mouse.getY! / game.camera.sy

        @weapon.left\update dt, mouse_x, mouse_y  if @weapon.left
        @weapon.right\update dt, mouse_x, mouse_y if @weapon.right

        light_player\setPosition @x + @w / 2, @y + @h / 2

    player.draw = =>
        if @weapon.right.flip == 1
            @weapon.right\draw! if @weapon.right
        else
            @weapon.left\draw! if @weapon.left

        with love.graphics
            .setColor 1, 1, 1
            w = sprites.player\getWidth!
            h = sprites.player\getHeight!

            .draw sprites.player, @x + @w / 2, @y + @h / 2, 0, @weapon.right.flip * @w / w, @h / h, w / 2, h / 2

        if @weapon.right.flip == -1
            @weapon.right\draw! if @weapon.right
        else
            @weapon.left\draw! if @weapon.left

    player.weapon_pos_right = =>
        if @weapon.right.flip == 1
            @x + @w / 5, @y + @h / 1.35
        else
            @x + @w / 2, @y + @h / 1.25

    player.weapon_pos_left = =>
        if @weapon.left.flip == -1
            @x + @w / 1.6, @y + @h / 1.45
        else
            @x + @w / 2, @y + @h / 1.25

    player.mousepressed = (x, y, button) =>
        if button == 1
            mouse_x = game.camera.x + love.mouse.getX! / game.camera.sx
            mouse_y = game.camera.y + love.mouse.getY! / game.camera.sy

            @weapon.left\shoot mouse_x, mouse_y  if @weapon.left
            @weapon.right\shoot mouse_x, mouse_y if @weapon.right
        elseif button == 2
            game.spawn "enemy", @x, @y


    world\add player, x, y, player.w, player.h
    player.weapon.right = weapons.gun.make player, "regular", true
    player.weapon.left  = weapons.gun.make player, "regular", false

    player

{
    :make
}