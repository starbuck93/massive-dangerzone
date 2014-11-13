
--====================================================================--
-- SCENE: Menu
--====================================================================--

--[[

******************
 - INFORMATION
******************

  - Menu.

We're going to first display a splash screen, then come to this screen where the user can possibly login  

 --]]

local xCenter = display.contentWidth
local yCenter = display.contentHeight
local widget = require ( "widget" )
local composer = require("composer")
local scene = composer.newScene()
local localGroup = display.newGroup()


--Called if the scene hasn't been previously seen
function scene:create( event )
	local nerf = display.newImage( "pics/NERF_transparent.png",xCenter/2,200 )
	localGroup:insert(nerf)
	local message = display.newText("We Like to Have Fun Here",xCenter/2,yCenter/2,nil,60)
	message:setFillColor(1,1,1)
	localGroup:insert(message)

	local function helpFunction()
		print("help")
		--composer.gotoScene("help")
	end
	
	local help = display.newImage( "pics/questionmark2.png",xCenter-25,25 )
	local tabButtons = {
	    {
	        label = "Main Menu",
	        size = 36,
	        id = "tab1",
	        selected = true,
	        labelYOffset = -25,
	        onPress = function() composer.gotoScene( "menu" ); end,
	    },
	    {
	        label = "Login",
	        size = 36,
	        id = "tab2",
	        labelYOffset = -25,
	        onPress = function() composer.gotoScene( "login" ); end,
	    },
	    {
	        label = "Register",
	        size = 36,
	        id = "tab3",
	        labelYOffset = -25,
	        onPress = function() composer.gotoScene( "register" ); end,
	    },
	}


	-- Create the widget
	local tabBar = widget.newTabBar
	{
	    top = yCenter-100,
	    width = xCenter,
	    height = 100,
	    buttons = tabButtons
	}	

	help:addEventListener( "tap", helpFunction )

end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
end

function scene:hide(event)
localGroup.alpha = 0

end

-- function scene:destroy( event )

--     local sceneGroup = self.view

--     -- Called prior to the removal of scene's view ("sceneGroup").
--     -- Insert code here to clean up the scene.
--     -- Example: remove display objects, save state, etc.
-- end


-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )
	
--
--scene:addEventListener( "destroy", scene )
return scene

