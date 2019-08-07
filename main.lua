function love.load()
  love.window.setMode(900, 700, flags)
  pWorld = love.physics.newWorld(0, 500, false)
  pWorld:setCallbacks(beginContact, endContact, preSolve, postSolve)
  require "sprites"
  require "player"
  require "platform"
  anim8 = require "anim8"
  sti = require "sti"
  cameraFile = require "camera"
  require "coin"

  gameMap = sti("maps/pworld.lua")
  cam = cameraFile()
  for i, obj in ipairs(gameMap.layers["platforms"].objects) do
    spawnPlatform(obj.x, obj.y, obj.width, obj.height)
  end

  for i, obj in ipairs(gameMap.layers["coins"].objects) do
    spawnCoin(obj.x, obj.y)
  end
end

function love.update(dt)
  pWorld:update(dt)
  playerUpdate(dt)
  updateCoins(dt)
  gameMap:update(dt)
  cam:lookAt(player.body:getX(), love.graphics.getHeight()/2)
end

function love.draw()
  cam:attach()

  gameMap:drawLayer(gameMap.layers["layer1"])
  love.graphics.draw(player.sprite, player.body:getX(),
  player.body:getY(), nil, player.direction, 1, sprites.player_stand:getWidth()/2,
  sprites.player_stand:getHeight()/2, kx, ky)

  drawCoins()
  cam:detach()
end

function love.keypressed(key, scancode, isrepeat)
  if key == "up" and player.grounded == true then
    player.body:applyLinearImpulse(0, -2800)
  end
end

function beginContact(a, b, coll)
  player.grounded = true
end

function endContact(a, b, coll)
  player.grounded = false
end

function distance(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
