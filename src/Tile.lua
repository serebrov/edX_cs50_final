--[[
Base class for all tiles.
]]--
Tile = Class{}

function Tile:init(id, level, x, y)
    self.id = id
    self.level = level

    def = ENTITY_DEFS[id]
    self.speed_bump = def.speed_bump or 1
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

function MapTile:init(id, level, x, y)
    Tile.init(self, id, level, x, y)
    def = ENTITY_DEFS[id]
    Entity.init(self, def, x, y)
end

function MapTile:render()
    Entity.render(self)
    -- -- Debug: Draw the tile coordinates and tile.dy
    -- text = self.x .. ',' .. self.y
    -- color = {0, 1, 0, 1}
    -- scale = 0.5
    -- drawText(text, FONTS['small'], self.x, self.y, color, scale)
end

--[[
Level exit tile.
]]--
ExitTile = Class{__includes = {EntityWithState, Tile}}

function ExitTile:init(id, level, x, y)
    Tile.init(self, id, level, x, y)
    def = ENTITY_DEFS[id]
    Entity.init(self, def, x, y)
end

function ExitTile:create_state_machine()
    machine = StateMachine {
        ['off'] = function() return ExitTileOffState(self, self.level) end,
        ['on'] = function() return ExitTileOnState(self, self.level) end,
    }
    machine:change('off')
    return machine
end

--[[
-- Exit tile "off" state.
-- ]]--
ExitTileOffState = Class{__includes = BaseState}

function ExitTileOffState:init(tile, level)
    self.tile = tile
    self.level = level
end

function ExitTileOffState:update(dt)
    -- If the player collected all the diamonds, change the state to on
    if self.level.player.diamonds == self.level.diamonds then
    -- Debug:
    -- if self.level.player.diamonds == 1 then
        self.tile:change_state('on')
    end
end

function ExitTileOffState:render()
    self.tile.animation = nil
    self.tile:draw()
end

--[[
-- Exit tile "on" state.
-- ]]--
ExitTileOnState = Class{__includes = BaseState}

function ExitTileOnState:init(tile, level)
    self.tile = tile
    self.level = level
end

function ExitTileOnState:update(dt)
    -- If the player is on the exit tile, change the state to on
    if self.tile.x == self.level.player.x and self.tile.y == self.level.player.y then
        self.level:next_level()
    end
end

function ExitTileOnState:render()
    self.tile.animation = self.tile.animations['on']
    self.tile:draw()
end

--[[
Empty tile class for empty spaces on the map.
]]--
NoTile = Class{__includes = MapTile}

function NoTile:init(def, level, x, y)
    self.id = 'no-tile'
    self.level = level
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
