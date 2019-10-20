make = (parent, name, right) ->
    gun = {
        x: parent.x
        y: parent.y
        sprite: sprites.guns[name]
        rotation: 0
        flip: 1
        radius: 4
        :right -- is this a right-hand weapon
        :parent
        shoot_timer: 0
    }

    with gun
        .w = .sprite\getWidth!
        .h = .sprite\getHeight!

    gun.draw = =>
        with love.graphics
            .setColor 1, 1, 1

            if @shoot_timer > 0
                mouse_x = game.camera.x + love.mouse.getX! / game.camera.sx
                mouse_y = game.camera.y + love.mouse.getY! / game.camera.sy


                .line @x, @y, mouse_x, mouse_y

            .draw @sprite, @x, @y, @rotation, 0.8, 0.8 * @flip, @w / 2, @h / 2

    gun.update = (dt) =>
        mouse_x = game.camera.x + love.mouse.getX! / game.camera.sx
        mouse_y = game.camera.y + love.mouse.getY! / game.camera.sy

        @rotation = math.atan2 (@y + @h / 2) - mouse_y, (@x + @w / 2) - mouse_x

        a = -math.sign mouse_x - @x

        if a != 0 if 10 < math.abs mouse_x - @x 
            @flip = a

        if @right
            @x, @y = @parent\weapon_pos_right!
        else
            @x, @y = @parent\weapon_pos_left!

        @x -= @radius * math.cos @rotation
        @y -= @radius * math.sin @rotation

        @shoot_timer -= dt if @shoot_timer > 0

    gun.mousepressed = (x, y, button) =>
        if button == 1
            @shoot_timer = 0.15


    gun


{
    :make
}