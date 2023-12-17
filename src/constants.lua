VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TILE_SIZE = 16

PLAYER_WALK_SPEED = 80
TILE_FALL_SPEED = 60

MAP_WIDTH = VIRTUAL_WIDTH / TILE_SIZE - 2
MAP_HEIGHT = math.floor(VIRTUAL_HEIGHT / TILE_SIZE) - 2

MAP_RENDER_OFFSET_X = (VIRTUAL_WIDTH - (MAP_WIDTH * TILE_SIZE)) / 2
MAP_RENDER_OFFSET_Y = (VIRTUAL_HEIGHT - (MAP_HEIGHT * TILE_SIZE)) / 2
