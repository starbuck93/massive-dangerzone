
--====================================================================--
-- SCENE: signed in
--====================================================================--

--[[

******************
 - INFORMATION
******************

  - signed in


  
 --]]
	
local xCenter = display.contentWidth
local yCenter = display.contentHeight
local widget = require ( "widget" )
local composer = require("composer")
local scene = composer.newScene()
local localGroup = display.newGroup()

local function moveScenes()
	composer.gotoScene("name", {effect = "fade", time = 1000,})
end

--Called if the scene hasn't been previously seen
function scene:create( event )
	local welcomeText = display.newText("Welcome, username...",xCenter/2,yCenter/2-400,nil,50)
	local welcomeText2 = display.newText("Please select a game to join.",xCenter/2,yCenter/2-350,nil,50)
	local game1 = widget.newButton
	{
	    label = "Game 1 --- some data here",
	    labelColor = {default ={1,1,1,1}, over={1,0,0,1} },
	    font = nil,
	    fontSize = 48,
	    emboss = true,
	    shape="roundedRect",
	    width = xCenter-50,
	    height = 100,
	    cornerRadius = 50,
	    fillColor = { default={ 1, 0, 0, 1 }, over={ 1, 1, 1, 1} },
	    --onEvent = moveScenes
	}
	game1.x = xCenter/2
	game1.y = yCenter/2


	localGroup:insert(welcomeText)
	localGroup:insert(welcomeText2)
	localGroup:insert(game1)
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

