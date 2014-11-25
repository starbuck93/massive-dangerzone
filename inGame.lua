local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()
local scene = composer.newScene()


function scene:create( event )
	local goToOptions = widget.newButton{
    width = 200,
	height = 75,
    left = 0,
    top = 0,
    id = "options",
    label = "Admin Options",
    fontSize = 40,
    onRelease = function() composer.gotoScene("adminOptions"); end,
    }


	local preTeam = display.newText{
	text ="You are on the.", 
	x = xCenter, 
	y = yCenter/3, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}

	local teamSelection = display.newText{
	text ="red/blue", 
	x = xCenter, 
	y = yCenter/2, 
	font = native.systemFont, 
	fontSize = 74,
	width = display.actualContentWidth-60,
	align = "center"}

	local team = display.newText{
	text ="team.", 
	x = xCenter, 
	y = yCenter/1.5, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}

	local gameBegins = display.newText{	
	text ="Game begins in:", 
	x = xCenter, 
	y = yCenter, 
	font = native.systemFont, 
	fontSize = 40,
	width = display.actualContentWidth-60,
	align = "center"}


---------------------------------
--configure countdown time
---------------------------------

	local TTSbackground = display.newRoundedRect( xCenter, yCenter+100, 200, 75, 25 )
	TTSbackground:setFillColor( .6,.6,.6 )
	TTSbackground:toBack()


	local ti_01 = display.newText{	
	text ="", 
	x = xCenter, 
	y = yCenter+100, 
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
	local GTtext = display.newText{
	text ="Time Remaining in Game:", 
	x = xCenter, 
	y = yCenter + 250, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}

	local GTbackground = display.newRoundedRect( xCenter, yCenter+350, 275, 100, 25 )
	GTbackground:setFillColor( .6,.6,.6 )
	GTbackground:toBack()

	local ti_02 = display.newText{	
	text ="", 
	x = xCenter, 
	y = yCenter+350, 
	font = native.systemFont, 
	fontSize = 80,
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

	localGroup:insert(preTeam)
	localGroup:insert(teamSelection)
	localGroup:insert(team)
	localGroup:insert(gameBegins)
	localGroup:insert(TTSbackground)
	localGroup:insert(GTbackground)
	localGroup:insert(ti_01)
	localGroup:insert(ti_02)
	--localGroup:insert()
	--localGroup:insert()
	localGroup:insert(goToOptions)
	localGroup:insert(GTtext)


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