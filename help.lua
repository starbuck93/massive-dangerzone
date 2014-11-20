
--====================================================================--
-- SCENE: HALP
--====================================================================--


local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()
composer = require("composer")
local scene = composer.newScene()

function scene:create( event )
	local intro=display.newText("Hello there! Thanks for downloading out app! If you have any questions, or would like to report a bug, please contact the following:",xCenter,yCenter,450,700,nil,48, "center")
	local contact = display.newText( "contact #1 email here.", xCenter, yCenter + 100, nil, 48 )
	local contact2 = display.newText( "contact #2 email here.", xCenter, yCenter + 150, nil, 48 )

	 local back = widget.newButton{
	 	width = 200,
	 	height = 75,
        left = 0,
        top = 0,
        id = "back",
        label = "<-- back",
        fontSize = 40,
        location = composer.getSceneName( "previous" ),
        onRelease = function() composer.gotoScene(location); end,
    }
    location = composer.getSceneName( "previous" )
	
	localGroup:insert( intro )
	localGroup:insert( contact )
	localGroup:insert( contact2 )


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