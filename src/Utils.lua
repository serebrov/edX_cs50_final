function drawText(text, font, x, y, color, scale)
    -- Save the current color
    local old_r, old_g, old_b, old_a = love.graphics.getColor()
    love.graphics.push()
    love.graphics.setFont(font)
    love.graphics.setColor(color)
    if scale then
        -- Scale down to make font smaller (but still crisp)
        love.graphics.scale(scale)
        -- Adjust the coordinates to account for the scale
        x = x / scale
        y = y / scale
    end
    love.graphics.print(text, x, y)
    -- Restore the old color
    love.graphics.setColor(old_r, old_g, old_b, old_a)
    love.graphics.pop()
end
