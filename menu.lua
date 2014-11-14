--scene: menu
local xCenter = display.contentWidth
local yCenter = display.contentHeight
local widget = require ( "widget" )
local composer = require("composer")
local scene = composer.newScene()
local localGroup = display.newGroup()
local globals = require( "globals" )
local coronium = require( "mod_coronium" )


--Called if the scene hasn't been previously seen
function scene:create( event )

	local nerf = display.newImage( "pics/NERF_transparent.png",xCenter/2,200 )
	localGroup:insert(nerf)
	local message = display.newText("NERF CLUB",xCenter/2,yCenter/2-200,nil,60)
	message:setFillColor(232/255, 100/255, 37/255)
	localGroup:insert(message)


	local function loginFunction( event )
		composer.gotoScene( "login" )
	end

	local login = widget.newButton{
	id = "loginButton",
	width = display.contentWidth/2,
	height = 100,
	emboss = true,
	fontSize = 70,
	top = yCenter/2-100,
	label = "Login",
	shape="roundedRect",
	cornerRadius = 45,
	labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
	fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	onRelease = loginFunction
	}
	login.x = xCenter/2
	localGroup:insert(login)	

	local function registerFunction( event )
		composer.gotoScene( "register" )
	end

	local register = widget.newButton{
	id = "registerButton",
	width = display.contentWidth/2,
	height = 100,
	emboss = true,
	fontSize = 70,
	top = yCenter/2+100,
	label = "Register",
	shape="roundedRect",
	cornerRadius = 45,
	labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
	fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	onRelease = registerFunction
	}
	register.x = xCenter/2
	localGroup:insert(register)


	local function helpFunction()
		print("help")
		coronium:addEvent( "helpEvent", "Help! " .. username)
		--composer.gotoScene("help")
	end
	
	local help = display.newImage( "pics/questionmark2.png",xCenter-25,25 )


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

