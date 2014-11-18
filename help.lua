
--====================================================================--
-- SCENE: HALP
--====================================================================--


local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()
composer = require("composer")
local scene = composer.newScene()

function scene:create( event )
	local intro=display.newText("Hello there! Thanks for downloading out app! If you have any questions, or would like to report a bug, please contact the following:",xCenter,yCenter,450,700,nil,48)
	local contact = display.newText( "contact email here." )
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