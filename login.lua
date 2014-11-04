
--====================================================================--
-- SCENE: login
--====================================================================--

--[[

******************
 - INFORMATION
******************

  - login page

The user can log in here
  
 --]]
local xCenter = display.contentWidth
local yCenter = display.contentHeight
local widget = require ( "widget" )
local composer = require("composer")
local scene = composer.newScene()
local localGroup = display.newGroup()

local function moveScenes()
	composer.gotoScene("signedIn", {effect = "fade", time = 3000,})
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
    fontSize = 48,
    emboss = true,
    shape="roundedRect",
    width = 300,
    height = 100,
    cornerRadius = 50,
    fillColor = { default={ 0, 1, 0, 1 }, over={ 1, 1, 0, 1} },
    onEvent = moveScenes
}

-- Center the button
submit.x = display.contentCenterX
submit.y = display.contentCenterY+200	


	localGroup:insert(text1)
	localGroup:insert(text2)
	localGroup:insert(nerf)
	localGroup:insert(submit)
	localGroup:insert(usernameBox)
	localGroup:insert(passwordBox)
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

