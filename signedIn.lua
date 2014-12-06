
--====================================================================--
-- SCENE: signed in
--====================================================================--

	
local xCenter = display.contentWidth/2
local yCenter = display.contentHeight/2
local scene = composer.newScene()
local localGroup = display.newGroup()

local function moveScenes( event )
	composer.gotoScene("playerGameStatus", {effect = "fade", time = 1000})
end

--Called if the scene hasn't been previously seen
function scene:create( event )

	--retrieve the above variables and set them if they exist
	--here is where we can grab any current games that are going on
	coronium:getObject( "testGameData", objId, function(e)
		if not e.error then
				gameTypeText = tostring(e.result.gameType)
				teamNumText = tostring(e.result.teamNumText)
				capNumText = tostring(e.result.numberCapts)
				gameLengthText = tostring(e.result.gameLength)
				TTSText = tostring(e.result.timeToStart)
				--gameType = gameTypeText, numberTeams = teamNumText, numberCapts = capNumText, gameLength = gameLengthText, timeToStart =  TTSText
			end
	end)

	local function logoutEvent( event )
		coronium:logoutUser()
		composer.gotoScene("menu", {effect = "fade", time = 1000})
	end

	local logout = widget.newButton
	{
	    label = "Logout",
	    font = nil,
	    fontSize = font1,
	    emboss = true,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
	    onRelease = logoutEvent
	}
	logout.x = display.contentWidth-75
	logout.y = 50


	local welcomeText = display.newText("Welcome, " .. username,xCenter,yCenter-400,nil,font2)
	local welcomeText2 = display.newText("Please select a game to join:",xCenter,yCenter-350,nil,font2)
	local game1 = widget.newButton
	{
	    label = gameTypeText,
	    font = nil,
	    fontSize = font2,
	    emboss = true,
	    shape="roundedRect",
	    width = xCenter*2-50,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onRelease = moveScenes
	}
	game1.x = xCenter
	game1.y = yCenter

	if (gameTypeText == "default variable") then
		game1:setLabel("No current games")
		--game1:setEnabled(false)
	end

	local extraInfo = display.newText{
	text = "Normally, this button will not do anything when it says no game but for now it will move on to the game screen", 
	x = xCenter, 
	y = yCenter+yCenter/2, 
	font = native.systemFont, 
	fontSize = font1,
	width = display.actualContentWidth-50,
	align = "center"}
	
	localGroup:insert(logout)
	localGroup:insert(welcomeText)
	localGroup:insert(welcomeText2)
	localGroup:insert(game1)
	localGroup:insert(extraInfo)
end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
	nerfImage.alpha = .2

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

