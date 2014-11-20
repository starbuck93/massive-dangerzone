local xCenter = display.contentWidth
local yCenter = display.contentHeight
local localGroup = display.newGroup()
local scene = composer.newScene()


function scene:create( event )
	local teamSelection = display.newText{
	text ="You are on the blue/red team.", 
	x = display.contentCenterX, 
	y = yCenter/4, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}

	local gameBegins = display.newText{	
	text ="Game begins in:", 
	x = display.contentCenterX, 
	y = yCenter/2, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}


---------------------------------
--configure countdown time
---------------------------------
	local ti_01 = display.newText{	
	text ="", 
	x = display.contentCenterX, 
	y = yCenter/2+100, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}

	local time_01 = 78
	local function decreaseTime()
	   time_01 = time_01-1
	   local seconds = time_01%60
	   local minutes = math.floor(time_01 / 60)
	   if seconds < 10 then
	   		seconds = "0" .. seconds
	   end
	   ti_01.text =minutes .. ":" .. seconds
	end

	timer.performWithDelay(1000,decreaseTime,time_01)

---------------------------------
--configure gameplay time
---------------------------------
	local ti_02 = display.newText{	
	text ="", 
	x = display.contentCenterX, 
	y = yCenter, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}

	local time_02 = 78
	local function decreaseTime()
	   time_02 = time_02-1
	   local seconds = time_02%60
	   local minutes = math.floor(time_02 / 60)
	   if seconds < 10 then
	   		seconds = "0" .. seconds
	   end
	   ti_02.text =minutes .. ":" .. seconds
	end

	timer.performWithDelay(1000,decreaseTime,time_02)

	localGroup:insert(teamSelection)
	localGroup:insert(gameBegins)

end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
end

function scene:hide(event)
	localGroup.alpha = 0
end

-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )


return scene