map_generator = {}

map = {}

square = 20
width  = love.graphics.getWidth! / square
height = love.graphics.getHeight! / square - 1

love.graphics.setBackgroundColor 189 / 255, 135 / 255, 49 / 255

-- settings
turn_prop = 0.3

worm_prop = 0.1

player_set = false
playerx = 0
playery = 0

lonely_max = 3

start_steps = 1000
steps = start_steps

dir =
    left: 0
    up: 1
    right: 2
    down: 3

clamp = (a, b, x) ->
    if x < a
        a
    elseif x > b
        b
    else
        x

mapgen = (x, y) ->
    player = math.random 0, steps
    wormx  = x or math.floor width / 2
    wormy  = y or math.floor height / 2
    wormr  = math.random 0, 3

    rotate = ->
        wormr = math.random 0, 3

    forward = ->
        switch wormr
            when dir.left
                wormx -= 1
            when dir.up
                wormy -= 1
            when dir.down
                wormy += 1
            when dir.right
                wormx += 1

        wormx = clamp 0, #map, wormx
        wormy = clamp 0, #map[0], wormy

    for i = 0, steps
        forward!

        if (math.random 0, 1000) / 1000 < turn_prop
            rotate!

        if (math.random 0, 1000) / 1000 < worm_prop
            steps /= 2
            mapgen wormx, wormy

        if wormx < #map - 1 and wormy < #map[0] - 1 and wormx > 1 and wormy > 1
            map[wormx][wormy] = 1

            rotate!

            if i > player and not player_set
                continue if map[wormx][wormy] != 1

                playerx, playery = wormx, wormy
                player_set = true

count_neighbors = (x, y, a) ->
    accum = 0

    for dx = -1, 1
        for dy = -1, 1

            if map[x + dx] and map[x + dx][y + dy]
                if map[x + dx][y + dy] == a
                    accum += 1

    accum

postfix = ->
    for x = 0, width
        for y = 0, height
            continue if (count_neighbors x, y, 0) > lonely_max or map[x][y] == 1
            map[x][y] = 1
    
    for x = 0, width
        for y = 0, height
            if map[x][y] == 0 and (count_neighbors x, y, 1) > 0
                map[x][y] = 2
                continue

map_generator.load = ->
    steps = start_steps

    math.randomseed os.time!

    map = {}
    player_set = false

    for x = 0, width
        row = {}
        for y = 0, height
            row[y] = 0
        map[x] = row

    mapgen!
    postfix!

map_generator.draw = ->
    for x = 0, width
        for y = 0, width
            with love.graphics
                if playerx == x and playery == y
                    .setColor 1, 1, 0
                    .rectangle "fill", x * square, y * square, square, square
    
                    continue

                switch map[x][y]
                    when 0
                        .setColor 107 / 255, 74 / 255, 22 / 255
                        .rectangle "fill", x * square, y * square, square, square
                    when 3
                        .setColor 1, 0, 0
                        .rectangle "fill", x * square, y * square, square, square
                    when 2
                        a = 2
                        .setColor 107 / a / 255, 74 / a / 255, 22 / a / 255
                        .rectangle "fill", x * square, y * square, square, square

                    when 1
                        continue

        
map_generator.keypressed = (key) ->
    if key == "space"
        love.load!

map_generator