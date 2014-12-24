local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()
local scene = composer.newScene()


function scene:create( event )

	nerfImage.alpha = .2

	local back = widget.newButton{
		 width = 200,
	 	height = 75,
    	left = 5,
    	top = 5,
    	id = "back",
   		label = "<-- back",
   		fontSize = font2,
   		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
   		onRelease = function() composer.gotoScene("signedIn"); end,
    }


	local gameVars = display.newText{
	text = gameTypeText .. " with " .. teamNumText .. " teams and game length " .. gameLengthText .. " minutes.", 
	x = xCenter, 
	y = yCenter/2, 
	font = native.systemFont, 
	fontSize = font2,
	width = display.actualContentWidth-60,
	align = "center"}

--edit the text if the teams are different sizes.	
	if (teamNumText == "1") then
		gameVars.text = gameTypeText .. " with " .. teamNumText .. " team and game length " .. gameLengthText .. " minutes." 
	end
	if (teamNumText == "0") then
		gameVars.text = gameTypeText .. " with no teams and game length " .. gameLengthText .. " minutes." 
	end


	local gameBegins = display.newText{	
	text ="Game begins in:", 
	x = xCenter, 
	y = yCenter, 
	font = native.systemFont, 
	fontSize = font1,
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
	fontSize = font2,
	width = display.actualContentWidth-60,
	align = "center"}

	local gameStartHour = string.match(TTSText,"%d%d") --hours
	local gameStartMin = string.match(TTSText,"%d%d",3) --minutes
	local gameStartSec = 0
	print(gameStartHour ..":" ..gameStartMin .. ":" .. gameStartSec.. " Game start time")


	local currentTime = os.time{year=os.date("%Y"), month=os.date("%m"), day=os.date("%d"), hour=os.date("%H"), min=os.date("%M"), sec=os.date("%S")}
	local gameStartTime = os.time{year=os.date("%Y"), month=os.date("%m"), day=os.date("%d"), hour=gameStartHour, min=gameStartMin, sec=gameStartSec}
	
	local time_01 = gameStartTime-currentTime
	print(time_01)
	local time_02 = tonumber(gameLengthText)
	time_02 = time_02*60

	
	if (time_01 < 0) then
		if (currentTime < tonumber(gameLengthText)*60+gameStartTime ) then --then the game should still be going on
			print("hello")
			time_01 = 0
			print(time_01)
			time_02 = 60*tonumber(gameLengthText) - (currentTime-gameStartTime) --remaining time left in the game in seconds
			
		else time_01 = (24*60*60)+time_01 --else the game will start tomorrow or something
		end
	end 

	local function decreaseTime()
	   time_01 = time_01-1
	   local seconds = time_01%60
	   local minutes = math.floor(time_01 / 60)
	   if seconds < 10 then
	   		seconds = "0" .. seconds
	   end
	   ti_01.text = minutes .. ":" .. seconds
	   -- print("Minutes " .. minutes .. " Seconds " .. seconds .. " " .. time_01)
	end

	timer.performWithDelay(1000,decreaseTime,time_01)


---------------------------------
--configure gameplay time
---------------------------------
	local GTtext = display.newText{
	text = "Time Remaining in Game:", 
	x = xCenter, 
	y = yCenter + 250, 
	font = native.systemFont, 
	fontSize = font2,
	width = display.actualContentWidth-60,
	align = "center"}

	local GTbackground = display.newRoundedRect( xCenter, yCenter+350, 275, 100, 25 )
	GTbackground:setFillColor( .6,.6,.6 )
	GTbackground:toBack()

	local ti_02 = display.newText{	
	text = "", 
	x = xCenter, 
	y = yCenter+350, 
	font = native.systemFont, 
	fontSize = font4,
	width = display.actualContentWidth-60,
	align = "center"}

	local function decreaseTime2()
	   time_02 = time_02-1
	   local seconds = time_02%60
	   local minutes = math.floor(time_02 / 60)
	   if seconds < 10 then
	   		seconds = "0" .. seconds
	   end
	   ti_02.text = minutes .. ":" .. seconds
	end

	local function delayFunction(  )
		timer.performWithDelay(1000,decreaseTime2,time_02)
	end
	timer.performWithDelay(time_01*1000,delayFunction)
	localGroup:insert(gameVars)
	localGroup:insert(gameBegins)
	localGroup:insert(TTSbackground)
	localGroup:insert(GTbackground)
	localGroup:insert(ti_01)
	localGroup:insert(ti_02)
	--localGroup:insert()
	--localGroup:insert()
	localGroup:insert(back)
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