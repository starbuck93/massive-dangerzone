local xCenter = display.contentWidth
local yCenter = display.contentHeight
local widget = require ( "widget" )
local composer = require("composer")
local scene = composer.newScene()
local localGroup = display.newGroup()
local globals = require( "globals" )
local coronium = require( "mod_coronium" )

local function moveScenes()
	composer.gotoScene("signedIn")
end

local function moveScenesAdmin()
	composer.gotoScene("adminOptions")
end


--Called if the scene hasn't been previously seen
function scene:create( event )
	local nerf = display.newImage( "pics/NERF_transparent.png",xCenter/2,200 )
	local text1 = display.newText("Username:",xCenter/2-200,yCenter/4+250,nil,48)
	local text2 = display.newText("Password:",xCenter/2-200,yCenter/4+350,nil,48)
	usernameBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+250, xCenter/2, 100)
	usernameBox.inputType = "default"
	usernameBox.size = "10"
	usernameBox.text = "Username"
	passwordBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+350, xCenter/2, 100)
	passwordBox.inputType = "default"
	passwordBox.size = "10"
	passwordBox.text = "Password"
	passwordBox.isSecure = true


	local submit = widget.newButton
	{
	    label = "Submit",
	    font = nil,
	    fontSize = 70,
	    emboss = true,
	    shape="roundedRect",
	    width = display.contentWidth/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onRelease = moveScenes
	}

	local admin = widget.newButton
	{
	    label = "Admin?",
	    font = nil,
	    fontSize = 70,
	    emboss = true,
	    shape="roundedRect",
	    width = display.contentWidth/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onRelease = moveScenesAdmin
	}

	-- Center the buttons
	submit.x = display.contentCenterX
	submit.y = display.contentCenterY+200
	admin.x = display.contentCenterX
	admin.y = display.contentCenterY+350	


	localGroup:insert(text1)
	localGroup:insert(text2)
	localGroup:insert(nerf)
	localGroup:insert(submit)
	localGroup:insert(admin)
end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
	usernameBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+250, xCenter/2, 100)
	usernameBox.inputType = "default"
	usernameBox.size = "10"
	usernameBox.text = "Username"
	passwordBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+350, xCenter/2, 100)
	passwordBox.inputType = "default"
	passwordBox.size = "10"
	passwordBox.text = "Password"
	passwordBox.isSecure = true
end

function scene:hide(event)
	localGroup.alpha = 0
	usernameBox:removeSelf( )
	passwordBox:removeSelf( )
end

-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )


return scene

