--[[
Base class for all tiles.
]]--
Tile = Class{}

function Tile:init(id, x, y)
    self.id = id

    def = ENTITY_DEFS[id]
    self.speed_bump = def.speed_bump
    self.can_fall = def.can_fall
    self.falling = false

    -- Used for falling tiles
    self.dy = 0
end

function Tile:isGround()
    return self.id == 'ground'
end

function Tile:isDiamond()
    return self.id == 'diamond'
end

function Tile:isEmpty()
    return false
end

--[[
Map tile class for objects on the map: ground, rock, diamond, exit.

This class is also a renderable entity.
]]--
MapTile = Class{__includes = {Entity,Tile}}

function MapTile:init(id, x, y)
    Tile.init(self, id, x, y)
    def = ENTITY_DEFS[id]
    Entity.init(self, def, x, y)
end

--[[
Empty tile class for empty spaces on the map.
]]--
NoTile = Class{__includes = MapTile}

function NoTile:init(def, x, y)
    self.id = 'no-tile'
    self.x = x
    self.y = y
    self.speed_bump = 1
end

function NoTile:render()
    -- Do nothing
end

function NoTile:isEmpty()
    return true
end
