function drawText(text, x, y, parameters)
    font = FONTS[parameters['font'] or 'small']
    scale = parameters['scale'] or Nil
    color = parameters['color'] or COLOR_WHITE
    width = parameters['width'] or Nil
    align = parameters['align'] or 'left'

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

    if width then
        love.graphics.printf(text, x, y, width, align)
    else
        love.graphics.print(text, x, y)
    end

    -- Restore the old color
    love.graphics.setColor(old_r, old_g, old_b, old_a)
    love.graphics.pop()
end

function changeMusic(audio)
    if STATE['music'] then
        STATE['music']:stop()
    end
    if not audio then
        return
    end
    STATE['music'] = audio
    STATE['music']:setLooping(true)
    STATE['music']:play()
end
