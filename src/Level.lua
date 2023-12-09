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
    tileMap = {
        ['-'] = 'ground',
        ['R'] = 'rock',
        ['D'] = 'diamond',
        ['E'] = 'exit',
        ['W'] = 'wall',
    }

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

    -- top wall
    table.insert(self.map, {})
    for i = 1, mapWidth + 2 do
        tile = Tile('wall', (i-1)*TILE_SIZE, 0)
        table.insert(self.map[#self.map], tile)
    end

    for ln = 1, #lines do
        local row = 1
        line = lines[ln]
        table.insert(self.map, {})
        tile = Tile('wall', (row-1)*TILE_SIZE, ln*TILE_SIZE)
        table.insert(self.map[#self.map], tile) -- left wall
        for char in line:gmatch(".") do
            row = row + 1
            if char ~= ' ' then
                tile = Tile(tileMap[char], (row-1)*TILE_SIZE, ln*TILE_SIZE)
                table.insert(self.map[#self.map], tile)
            else
                tile = NoTile({}, (row-1)*TILE_SIZE, ln*TILE_SIZE)
                table.insert(self.map[#self.map], nil)
            end
        end
        row = row + 1
        tile = Tile('wall', (row-1)*TILE_SIZE, ln*TILE_SIZE)
        table.insert(self.map[#self.map], tile) -- right wall
    end

    -- bottom wall
    table.insert(self.map, {})
    for i = 1, mapWidth + 2 do
        tile = Tile('wall', (i-1)*TILE_SIZE, (#lines+1)*TILE_SIZE)
        table.insert(self.map[#self.map], tile)
    end

    -- -- Debugging: print the map
    -- for y = 1, #self.map do
    --     for x = 1, #self.map[y] do
    --         io.write(self.map[y][x])
    --     end
    --     io.write('\n')
    -- end
end

function Level:update(dt)
    -- Scan the map for falling rocks
    -- Rocks fall if there is an empty space below them
    for y = 1, #self.map do
        -- for x = 1, #self.map[y] do
            -- if self.map[y][x] == MAP_TILE_ROCK then
            --     if self.map[y+1][x] == MAP_TILE_EMPTY then
            --         self.map[y][x] = MAP_TILE_EMPTY
            --         self.map[y+1][x] = MAP_TILE_ROCK
            --     end
            -- end
        -- end
    end
end

function Level:render()
    -- textureMap = {
    --     [MAP_TILE_GROUND] = TEXTURES['ground'],
    --     [MAP_TILE_ROCK] = TEXTURES['rock'],
    --     [MAP_TILE_DIAMOND] = TEXTURES['diamond'],
    --     [MAP_TILE_EXIT] = TEXTURES['exit'],
    --     [MAP_TILE_WALL] = TEXTURES['wall'],
    --     -- [' '] = TEXTURES['empty'], -- empty space, no texture
    -- }
    -- Draw the map
    for y = 1, #self.map do
        for x = 1, #self.map[y] do
            self.map[y][x]:render()
        end
    end
    -- for i = 1, #self.map do
    --     self.map[y]:render()
    -- end
end

function Level:tile_at(x, y)
    -- Convert from pixel coordinates to tile coordinates
    x = math.floor(x / TILE_SIZE) + 1
    y = math.floor(y / TILE_SIZE) + 1

    -- return self.map[y][x], (x-1)*TILE_SIZE, (y-1)*TILE_SIZE
    return self.map[y][x]
end

function Level:set_tile_at(x, y, tile)
    -- Convert from pixel coordinates to tile coordinates
    x = math.floor(x / TILE_SIZE) + 1
    y = math.floor(y / TILE_SIZE) + 1

    if tile == nil then
        tile = NoTile({}, (x-1)*TILE_SIZE, (y-1)*TILE_SIZE)
    end
    self.map[y][x] = tile
end
