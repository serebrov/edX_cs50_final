Level = Class{}

function Level:init(levelDefinition)
    -- Map looks like this
    -- ['map'] = [[
    --   - -R RR--R-D--D
    --   - D- -RDRR---R-
    --   - R--R-DR--R-R-
    --   --RD--R-R-RR-RE
    --   --R-D-R----R---
    --   --R-D-R  R -  R
    --   --R-DD---R-- -R
    -- ]],
    -- Where R is a rock, D is a diamond, E is the exit, and - is empty space
    levelMap = levelDefinition.map

    lines = {}
    for line in levelMap:gmatch("[^\r\n]+") do
        -- remove leading and trailing whitespace
        line = line:match("^%s*(.-)%s*$")
        if line:len() > 0 then
            table.insert(lines, line)
        end
    end

    -- Parse the map into a two dimentional x-y table
    self.map = {}
    -- All lines in the map must be the same length, take the length of the first line
    mapWidth = lines[1]:len()
    wall = {}
    for i = 1, mapWidth + 2 do
        table.insert(wall, 'W')
    end

    table.insert(self.map, wall) -- top wall
    for i = 1, #lines do
        line = lines[i]
        table.insert(self.map, {})
        table.insert(self.map[#self.map], 'W') -- left wall
        for char in line:gmatch(".") do
            table.insert(self.map[#self.map], char)
        end
        table.insert(self.map[#self.map], 'W') -- right wall
    end
    table.insert(self.map, wall) -- bottom wall

    -- -- Debugging: print the map
    -- for y = 1, #self.map do
    --     for x = 1, #self.map[y] do
    --         io.write(self.map[y][x])
    --     end
    --     io.write('\n')
    -- end
end

function Level:update()
end

function Level:render()
    textureMap = {
        [MAP_TILE_ROCK] = TEXTURES['rock'],
        [MAP_TILE_DIAMOND] = TEXTURES['diamond'],
        [MAP_TILE_EXIT] = TEXTURES['exit'],
        [MAP_TILE_WALL] = TEXTURES['wall'],
        [MAP_TILE_GROUND] = TEXTURES['ground'],
        -- [' '] = TEXTURES['empty'], -- empty space, no texture
    }
    -- Draw the map
    for y = 1, #self.map do
        for x = 1, #self.map[y] do
            local char = self.map[y][x]
            if textureMap[char] then
                love.graphics.draw(textureMap[char], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
        end
    end
end

function Level:tile_at(x, y)
    -- Convert from pixel coordinates to tile coordinates
    x = math.floor(x / TILE_SIZE) + 1
    y = math.floor(y / TILE_SIZE) + 1

    return self.map[y][x]
end
