
--====================================================================--
-- SCENE: HALP
--====================================================================--


local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()
composer = require("composer")
local scene = composer.newScene()

function scene:create( event )

	local options = {
	text ="Hello there! Thanks for downloading our app! If you have any questions, or would like to report a bug, please contact the following:", 
	x = display.contentCenterX, 
	y = 300, 
	font = native.systemFont, 
	fontSize = 50,
	width = display.actualContentWidth-60,
	align = "center"}
	local intro=display.newText(options)
	local contact = display.newText( "acs11e@acu.edu", xCenter, yCenter + 100, nil, 48 )
	local contact2 = display.newText( "rap10c@acu.edu", xCenter, yCenter + 150, nil, 48 )

	 local back = widget.newButton{
	 	width = 200,
	 	height = 75,
        left = 0,
        top = 0,
        id = "back",
        label = "<-- back",
        fontSize = 50,
        location = composer.getSceneName( "previous" ),
        onRelease = function() composer.gotoScene(location); end,
    }
    location = composer.getSceneName( "previous" )
	
	localGroup:insert( intro )
	localGroup:insert( contact )
	localGroup:insert( contact2 )
	localGroup:insert( back )


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