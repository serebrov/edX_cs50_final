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
    -- parse the map into a two dimentional x-y table
    self.map = {}
    for line in levelMap:gmatch("[^\r\n]+") do
        table.insert(self.map, {})
        -- remove leading and trailing whitespace
        line = line:match("^%s*(.-)%s*$")
        for char in line:gmatch(".") do
            table.insert(self.map[#self.map], char)
        end
    end
end

function Level:update()
end

function Level:render()
    textureMap = {
        ['R'] = gTextures['rock'],
        ['D'] = gTextures['diamond'],
        ['E'] = gTextures['exit'],
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
