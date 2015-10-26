debug = true
player = { x = 200, y = 710, speed = 150, img = nil }


-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
-- Timers
-- We declare these here so we don't have to edit them multiple places
canShoot = true
canShootTimerMax = 0.2 
canShootTimer = canShootTimerMax
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

enemyImg = nil -- Like other images we'll pull this in during our love.load function
bulletImg = nil

enemies = {} -- array of current enemies on screen  
bullets = {} -- array of current bullets being drawn and updated


--LOAD--
function love.load(arg)
    player.img = love.graphics.newImage('assets/aircrafts/Aircraft_01.png')
    bulletImg = love.graphics.newImage('assets/aircrafts/bullet_2_blue.png')
    enemyImg = love.graphics.newImage('assets/turtlehead.png')
end

--UPDATE--
function love.update(dt)
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
    -- Time out how far apart our shots can be.
  end
  canShootTimer = canShootTimer - (1 * dt)
  if canShootTimer < 0 then
    canShoot = true
  end

if love.keyboard.isDown('left','a') then
  if player.x > 0 then -- binds us to the map
    player.x = player.x - (player.speed*dt)
  end
elseif love.keyboard.isDown('right','d') then
  if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
    player.x = player.x + (player.speed*dt)
  end
  elseif love.keyboard.isDown('up', 'w') then
    player.y = player.y - (player.speed * dt)
  elseif love.keyboard.isDown('down', 's') then
    player.y = player.y + (player.speed * dt)
  end

  if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot then
  -- Create some bullets
  newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
  table.insert(bullets, newBullet)
  canShoot = false
  canShootTimer = canShootTimerMax
  end
  -- update the positions of bullets
  for i, bullet in ipairs(bullets) do
    bullet.y = bullet.y - (250 * dt)

      if bullet.y < 0 then -- remove bullets when they pass off the screen
      table.remove(bullets, i)
    end
  end
  -- Time out enemy creation
  createEnemyTimer = createEnemyTimer - (1 * dt)
  if createEnemyTimer < 0 then
    createEnemyTimer = createEnemyTimerMax

  -- Create an enemy
  randomNumber = math.random(10, love.graphics.getWidth() - 10)
  newEnemy = { x = randomNumber, y = -10, img = enemyImg }
  table.insert(enemies, newEnemy)
  end
  -- update the positions of enemies
for i, enemy in ipairs(enemies) do
  enemy.y = enemy.y + (200 * dt)

  if enemy.y > 850 then -- remove enemies when they pass off the screen
    table.remove(enemies, i)
  end
end

end

--DRAW--
function love.draw(dt)
  love.graphics.draw(player.img, player.x, player.y)
  love.graphics.print( player.x, 0, 0 )
  love.graphics.print( player.y, 0, 10)
--love.graphics.print( text, x, y, r, sx, sy, ox, oy, kx, ky )
  for i, bullet in ipairs(bullets) do
  love.graphics.draw(bullet.img, bullet.x, bullet.y)

  for i, enemy in ipairs(enemies) do
  love.graphics.draw(enemy.img, enemy.x, enemy.y)
end
end
end
