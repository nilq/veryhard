path = "res/"

with love.graphics
    .setDefaultFilter "nearest", "nearest"

    image = (a, linear) ->
        img = .newImage path .. "/" .. a
        if linear
            img\setFilter "linear", "linear"
        img

    return {
        player: image "player/man.png"
        guns:
            regular: image "guns/regular.png"
        grass: image "tiles/grass.png", true
        rock: image "tiles/rock.png", true

        enemies:
            tony:
                normal: image "enemies/tony.png"
                shot:   image "enemies/tony_shot.png"
                dead:   image "enemies/tony_dead.png"

        normals:
            rock: image "rock_normalmap.png"
            grass: image "grass_normalmap.png"
            player: image "man_normalmap.png"
            enemies:
                tony: image "tony_normalmap.png"
    }