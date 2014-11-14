
--====================================================================--
-- SCENE: register
--====================================================================--

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

    local back = widget.newButton{
        left = 0,
        top = 0,
        id = "back",
        label = "<-- back",
        fontSize = 30,
        onRelease = function() composer.gotoScene( "menu" ); end,
    }


local password = ""
local password2 = ""

	local function onLoginEvent( event )
		  if not event.error then
		  	coronium:addEvent( "LoginEvent", "login " .. username )
		    composer.gotoScene("signedIn", {effect = "fade", time = 3000,})
		  end
	end
	local function onRegisterEvent( event )
		  if not event.error then
		  	coronium:loginUser(username,password,onLoginEvent)
		    composer.gotoScene("signedIn", {effect = "fade", time = 3000,})
		  end
	end

	local function registerNewUser()
		coronium:registerUser({ 
		email = email,
		password = password,
		username = username
		}, onRegisterEvent)
		coronium:addEvent( "registerUEvent", "register" .. email )


		-- composer.gotoScene("signedIn", {effect = "fade", time = 3000,})
	end


	local options = {text ="Please enter the information required. Good luck out there!", x = display.contentCenterX, y = 100, font = native.systemFont, fontSize = 50,width = display.actualContentWidth,align = "center"}
	local instruct = display.newText(options)
	--local instruct2 = display.newText( "This will allow you to enter our system and play the games.", display.contentCenterX, 150, nil, 26)
	--local instruct3 = display.newText( "Thank you!", display.contentCenterX, 280, nil, 54)
	local text4 = display.newText("Email:",xCenter/2-200,yCenter/4+150,nil,36)
	local text1 = display.newText("Username:",xCenter/2-200,yCenter/4+250,nil,36)
	local text2 = display.newText("Password:",xCenter/2-200,yCenter/4+350,nil,36)
	emailBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+150, xCenter/2, 100)
	emailBox.inputType = "email"
	emailBox.size = "10"
	emailBox.text = "Email"
	usernameBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+250, xCenter/2, 100)
	usernameBox.inputType = "default"
	usernameBox.size = "10"
	usernameBox.text = "Username"
	passwordBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+350, xCenter/2, 100)
	passwordBox.inputType = "default"
	passwordBox.size = "10"
	passwordBox.text = "Password"
	passwordBox.isSecure = true
	local text3 = display.newText("Confirm Password:",xCenter/2-200,yCenter/4+450,nil,36)
	passwordBox2 = native.newTextField( xCenter/2+xCenter/4, yCenter/4+450, xCenter/2, 100)
	passwordBox2.inputType = "default"
	passwordBox2.size = "10"
	passwordBox2.text = "Confirm Password"
	passwordBox2.isSecure = true


local submit = widget.newButton
{
    label = "Submit",
    font = nil,
    fontSize = 48,
    emboss = true,
    shape="roundedRect",
    width = display.contentWidth/2,
    height = 100,
    cornerRadius = 50,
    fillColor = { default={ 0, 1, 0, 1 }, over={ 1, 1, 0, 1} },
    onEvent = registerNewUser
}

-- Center the button
submit.x = display.contentCenterX
submit.y = yCenter-175	

localGroup:insert(instruct)
-- localGroup:insert(instruct2)
-- localGroup:insert(instruct3)
-- localGroup:insert(emailBox)
localGroup:insert(text4)
localGroup:insert(text1)
localGroup:insert(text2)
localGroup:insert(text3)
localGroup:insert(submit)
-- localGroup:insert(usernameBox)
-- localGroup:insert(passwordBox)
-- localGroup:insert(passwordBox2)


local function emailListener( event )

    if ( event.phase == "began" ) then

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
    	email = event.target.text
       	native.setKeyboardFocus( nil )

    elseif ( event.phase == "editing" ) then

    end
end

local function userListener( event )

    if ( event.phase == "began" ) then

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
    	username = event.target.text
       	native.setKeyboardFocus( nil )
    elseif ( event.phase == "editing" ) then

    end
end

local function passwordListener( event )

    if ( event.phase == "began" ) then

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
    	password = event.target.text
       	native.setKeyboardFocus( nil )
    elseif ( event.phase == "editing" ) then

    end
end

local function password2Listener( event )

    if ( event.phase == "began" ) then

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
    	password2 = event.target.text
    	native.setKeyboardFocus( nil )
    elseif ( event.phase == "editing" ) then

    end
end

emailBox:addEventListener( "userInput", emailListener )
usernameBox:addEventListener( "userInput", userListener )
passwordBox:addEventListener( "userInput", passwordListener )
passwordBox2:addEventListener( "userInput", password2Listener )


end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
	emailBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+150, xCenter/2, 100)
	emailBox.inputType = "email"
	emailBox.size = "10"
	emailBox.text = "Email"
	usernameBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+250, xCenter/2, 100)
	usernameBox.inputType = "default"
	usernameBox.size = "10"
	usernameBox.text = "Username"
	passwordBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+350, xCenter/2, 100)
	passwordBox.inputType = "default"
	passwordBox.size = "10"
	passwordBox.text = "Password"
	passwordBox.isSecure = true
	local text3 = display.newText("Confirm Password:",xCenter/2-200,yCenter/4+450,nil,36)
	passwordBox2 = native.newTextField( xCenter/2+xCenter/4, yCenter/4+450, xCenter/2, 100)
	passwordBox2.inputType = "default"
	passwordBox2.size = "10"
	passwordBox2.text = "Confirm Password"
	passwordBox2.isSecure = true

end

function scene:hide(event)
localGroup.alpha = 0
emailBox:removeSelf( )
usernameBox:removeSelf( )
passwordBox:removeSelf( )
passwordBox2:removeSelf( )
end



-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )




	return scene
