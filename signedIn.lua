
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
			end
	end)

	local function logoutEvent( event )
		--coronium:logoutUser()
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

	
	localGroup:insert(logout)
	localGroup:insert(welcomeText)
	localGroup:insert(welcomeText2)
	localGroup:insert(game1)
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

