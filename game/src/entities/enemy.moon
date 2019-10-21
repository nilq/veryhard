make = (x, y) ->
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
    }

    enemy.update = (dt) =>
        angle = math.atan2 game.player.y - @y, game.player.x - @x

        @dx = @speed * math.cos angle
        @dy = @speed * math.sin angle

        @dx = math.lerp @dx, 0, dt * @friction
        @dy = math.lerp @dy, 0, dt * @friction

        @x, @y, collisions = world\move @, @x + @dx * dt, @y + @dy * dt

        @rect\setPosition @x + enemy.w / 2.5, @y + enemy.h / 2

        @weapon.right\update dt, game.player.x, game.player.y if @weapon.right

    enemy.draw = =>
        if @weapon.right.flip == 1
            @weapon.right\draw! if @weapon.right

        with love.graphics
            w = sprites.enemies.tony\getWidth!
            h = sprites.enemies.tony\getHeight!
            .setColor 1, 1, 1
            .draw sprites.enemies.tony, @x + w / 2, @y + h / 2, 0, @weapon.right.flip * @w / w, @h / h, w / 2, h / 2 

        if @weapon.right.flip == -1
            @weapon.right\draw! if @weapon.right

    enemy.weapon_pos_right = =>
        if @weapon.right.flip == 1
            @x + @w / 5, @y + @h / 1.35
        else
            @x + @w / 2, @y + @h / 1.25
    
    enemy.mousepressed = (x, y, button) =>
        --@weapon.right\mousepressed x, y, button  if @weapon.right

    world\add enemy, enemy.x, enemy.y, enemy.w, enemy.h
    enemy.rect = light_world\newRectangle x + enemy.w / 2.5, y + enemy.h / 2, 8, 12

    enemy.weapon.right = weapons.gun.make enemy, "regular", true

    enemy

{
    :make
}