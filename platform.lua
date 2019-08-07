platforms = {}

function spawnPlatform(x, y, width, height)
  local platform = {}
  platform.body = love.physics.newBody(pWorld, x, y, "static")
  platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height)
  platform.fixture = love.physics.newFixture(platform.body, platform.shape)
  platform.width = width
  platform.height = height
  table.insert(platforms, platform)
end
