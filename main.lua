debug = true
playerImg = nil -- this is just for storage
function love.load(arg)
    playerImg = love.graphics.newImage('assets/aircrafts/Aircraft_01.png')
    --we now have an asset ready to be used inside Love
end

function love.update(dt)

end

function love.draw(dt)
  love.graphics.draw(playerImg, 100, 100)
end
