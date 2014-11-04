
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
	local message = display.newText("We Like to Have Fun Here",xCenter/2,yCenter/2,nil,54)
	message:setFillColor(0,0,1)
	localGroup:insert(message)

	local function helpFunction()
		print("help")
		--composer.gotoScene("help")
	end
	
	local help = display.newImage( "pics/questionmark2.png",xCenter-25,25 )
	local tabButtons = {
	    {
	        label = "Main Menu",
	        size = 32,
	        id = "tab1",
	        selected = true,
	        onPress = function() composer.gotoScene( "menu" ); end,
	    },
	    {
	        label = "Login",
	        size = 32,
	        id = "tab2",
	        onPress = function() composer.gotoScene( "login" ); end,
	    },
	    {
	        label = "Register",
	        size = 32,
	        id = "tab3",
	        onPress = function() composer.gotoScene( "login" ); end,
	    },
	}


	-- Create the widget
	local tabBar = widget.newTabBar
	{
	    top = yCenter-52,
	    width = xCenter,
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

-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )
	return scene

