function make_camera(x, y, sx, sy, r)
    local camera = {
        x = x, y = y,
        sx = sx, sy = sy,
        r = r,
    }

    function camera:set()
        love.graphics.push()
        love.graphics.rotate(self.r)
        love.graphics.scale(self.sx, self.sy)
        love.graphics.translate(
            -self.x,
            -self.y
        )
    end

    function camera:unset()
        love.graphics.pop()
    end

    function camera:move(dx, dy)
        self.x = self.x + dx
        self.y = self.y + dy
    end

    return camera
end

return make_camera