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

        normals:
            rock: image "rock_normalmap.png"
            grass: image "grass_normalmap.png"
    }