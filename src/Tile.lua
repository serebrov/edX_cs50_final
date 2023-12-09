Tile = Class{__includes = Entity}

function Tile:init(id, x, y)
    def = ENTITY_DEFS[id]
    self.id = id
    self.speed_bump = def.speed_bump
    self.can_fall = def.can_fall

    -- Used for falling tiles
    self.dy = 0
    Entity.init(self, def, x, y)
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

NoTile = Class{__includes = Tile}

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
