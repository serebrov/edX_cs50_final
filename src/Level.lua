Level = Class{}

function Level:init(levelDefinition, gameState)
    self.gameState = gameState
    self.diamonds = 0
    -- A two dimentional array of tiles
    self.map = {}

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
    -- All lines in the map must be the same length, take the length of the first line
    mapWidth = lines[1]:len()

    -- top wall
    table.insert(self.map, {})
    for i = 1, mapWidth + 2 do
        tile = MapTile('wall', self, (i-1)*TILE_SIZE, 0)
        table.insert(self.map[#self.map], tile)
    end

    for ln = 1, #lines do
        local row = 1
        line = lines[ln]

        table.insert(self.map, {})
        tile = MapTile('wall', self, (row-1)*TILE_SIZE, ln*TILE_SIZE)
        table.insert(self.map[#self.map], tile) -- left wall

        for char in line:gmatch(".") do
            row = row + 1
            local tile = nil
            if char == 'P' then
                self.player = Player(self, (row-1) * TILE_SIZE, ln * TILE_SIZE)
                -- Alternatively, we could use a NoTile here, then the player
                -- is a separate entity that is rendered on top of the map.
                -- Both approaches work, but I think it's better to have the
                -- player be a tile and a part of the map, so we can uniformly
                -- render the player and the tiles and later on we can add
                -- enemies that are also tiles.
                -- tile = NoTile({}, self, (row-1) * TILE_SIZE, ln * TILE_SIZE)
                tile = self.player
            elseif char == 'E' then
                tile = ExitTile(tileMap[char], self, (row-1) * TILE_SIZE, ln * TILE_SIZE)
            elseif char ~= ' ' then
                tile = MapTile(tileMap[char], self, (row-1) * TILE_SIZE, ln * TILE_SIZE)
            else
                tile = NoTile({}, self, (row-1) * TILE_SIZE, ln * TILE_SIZE)
            end
            if tile:isDiamond() then
                self.diamonds = self.diamonds + 1
            end
            table.insert(self.map[#self.map], tile)
        end

        row = row + 1
        tile = MapTile('wall', self, (row-1)*TILE_SIZE, ln*TILE_SIZE)
        table.insert(self.map[#self.map], tile) -- right wall
    end

    -- bottom wall
    table.insert(self.map, {})
    for i = 1, mapWidth + 2 do
        tile = MapTile('wall', self, (i-1)*TILE_SIZE, (#lines+1)*TILE_SIZE)
        table.insert(self.map[#self.map], tile)
    end

    -- -- Debugging: print the map
    -- for y = 1, #self.map do
    --     for x = 1, #self.map[y] do
    --         io.write(self.map[y][x].id)
    --     end
    --     io.write('\n')
    -- end
end

function Level:update(dt)
    -- self.player:update(dt)

    -- Scan the map for falling rocks
    -- Rocks fall if there is an empty space below them
    -- We accumulate rock.dy and then move the rock when it is >= TILE_SIZE
    for y = 1, #self.map-2 do
        for x = 1, #self.map[y]-1 do
            tile = self.map[y][x]
            tile:update(dt)
            if tile.can_fall then
                tile_next = self.map[y+1][x]
                if tile_next.isEmpty() then
                    tile.dy = tile.dy + dt * TILE_FALL_SPEED
                    if tile_next.x == self.player.x and tile_next.y == self.player.y then
                        -- If the player is directly under the falling tile,
                        -- stop the fall.
                        if not tile.falling then
                            tile.dy = 0
                        end
                    end
                    if tile.dy >= TILE_SIZE then
                        -- Mark the tile as falling and move it down
                        tile.falling = true
                        -- If the tile falls on the player, game over
                        if tile.x == self.player.x and tile.y == self.player.y then
                            self.gameState:gameOver()
                        end

                        tile.dy = 0
                        self.map[y+1][x] = tile
                        tile.y = tile.y + TILE_SIZE
                        self.map[y][x] = tile_next
                        tile_next.y = tile_next.y - TILE_SIZE
                    end
                else
                    tile.dy = 0
                end
            end
        end
    end
end

function Level:render()
    -- Draw the map
    for y = 1, #self.map do
        for x = 1, #self.map[y] do
            self.map[y][x]:render()
        end
    end
    -- self.player:render()
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
        tile = NoTile({}, self, (x-1)*TILE_SIZE, (y-1)*TILE_SIZE)
    end
    self.map[y][x] = tile
end

function Level:next_level()
    self.gameState:nextLevel()
end
