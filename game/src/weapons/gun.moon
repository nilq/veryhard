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

            .draw @sprite, @x, @y, @rotation, 0.8, 0.8 * @flip, @w / 2, @h / 2

    gun.update = (dt, x, y) =>
        @rotation = math.atan2 (@y + @h / 2) - y, (@x + @w / 2) - x

        if @shoot_timer > 0
            @rotation += @flip * (1 - @shoot_timer * dt) / 2

        a = -math.sign x - @x

        if a != 0 if 10 < math.abs x - @x 
            @flip = a

        if @right
            @x, @y = @parent\weapon_pos_right!
        else
            @x, @y = @parent\weapon_pos_left!

        @x -= @radius * math.cos @rotation
        
        sin = math.sin @rotation
        a   = 1
        if sin > 0
            a = 1.5

        @y -= @radius * a * sin

        @shoot_timer -= dt if @shoot_timer > 0

    gun.shoot = (x, y) =>
        if @shoot_timer <= 0
            @shoot_timer = 0.4
            game.spawn_bullet @x - (@w * math.cos @rotation), @y - (@w * math.sin @rotation), math.atan2 y - (@y + @h / 2), x - (@x + @w / 2)

    gun


{
    :make
}