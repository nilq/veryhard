make = (x, y, name) ->
    enemy = {
        :x
        :y
        w: 16
        h: 16
        dx: 0
        dy: 0
        friction: 5
        speed: 100
        weapon: {}

        death_angle: 0
        death_timer: 0
        death_time: 0.4

        shoot_interval: 1
        shoot_clock: 0

        dead: false
        current_sprite: sprites.enemies[name].normal
        :name
    }

    enemy.update = (dt) =>
        return if @dead

        @shoot_clock += dt

        if @shoot_clock >= @shoot_interval
            if (math.random 0, 100) / 100 < 30
                @weapon.right\shoot game.player.x, game.player.y
            
            @shoot_clock = 0

        unless @death_timer > 0
            angle = math.atan2 game.player.y - @y, game.player.x - @x

            @dx = @speed * math.cos angle
            @dy = @speed * math.sin angle

            @dx = math.lerp @dx, 0, dt * @friction
            @dy = math.lerp @dy, 0, dt * @friction

        @x, @y, collisions = world\move @, @x + @dx * dt, @y + @dy * dt

        @rect\setPosition @x + enemy.w / 2.5, @y + enemy.h / 2

        @weapon.right\update dt, game.player.x, game.player.y if @weapon.right

        if @death_timer > 0
            @death_timer -= dt

            if @death_timer > @death_time * 0.95
                @dx = 200 * math.cos @death_angle
                @dy = 200 * math.sin @death_angle

            if @death_timer <= 0
                for i, e in ipairs game.objects
                    if @ == e
                        
                        @current_sprite = sprites.enemies[name].dead

                        world\remove @

                        @dead = true

    enemy.draw = =>
        if @weapon.right.flip == 1
            @weapon.right\draw! if @weapon.right

        with love.graphics
            w = @current_sprite\getWidth!
            h = @current_sprite\getHeight!
            .setColor 1, 1, 1
            .draw @current_sprite, @x + w / 2, @y + h / 2, 0, @weapon.right.flip * @w / w, @h / h, w / 2, h / 2 

        if @weapon.right.flip == -1
            @weapon.right\draw! if @weapon.right

    enemy.weapon_pos_right = =>
        if @weapon.right.flip == 1
            @x + @w / 5, @y + @h / 1.35
        else
            @x + @w / 2, @y + @h / 1.25

    enemy.die = (angle) =>
        @death_timer = @death_time
        @death_angle = angle

        @current_sprite = sprites.enemies[name].shot

    world\add enemy, enemy.x, enemy.y, enemy.w, enemy.h
    enemy.rect = light_world\newRectangle x + enemy.w / 2.5, y + enemy.h / 2, 8, 12

    enemy.weapon.right = weapons.gun.make enemy, "regular", true

    enemy

{
    :make
}