debug = true
player = { x = 200, y = 710, speed = 150, img = nil }
function love.load(arg)
    player.img = love.graphics.newImage('assets/aircrafts/Aircraft_01.png')
    --we now have an asset ready to be used inside Love
end

function love.update(dt)
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  if love.keyboard.isDown('left','a') then
    player.x = player.x - (player.speed*dt)
  elseif love.keyboard.isDown('right','d') then
    player.x = player.x + (player.speed*dt)
  elseif love.keyboard.isDown('up', 'w') then
    player.y = player.y - (player.speed * dt)
  elseif love.keyboard.isDown('down', 's') then
    player.y = player.y + (player.speed * dt)
  end
end

function love.draw(dt)
  love.graphics.draw(player.img, player.x, player.y)
  love.graphics.print( player.x, 0, 0 )
  love.graphics.print( player.y, 0, 10)

end
