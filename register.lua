
--====================================================================--
-- SCENE: register
--====================================================================--

local xCenter = display.contentWidth
local yCenter = display.contentHeight
local scene = composer.newScene()
local localGroup = display.newGroup()




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

local function moveScenes()
   	native.setKeyboardFocus( nil )
	composer.gotoScene("signedIn")
end

--Called if the scene hasn't been previously seen
function scene:create( event )

    local back = widget.newButton{
        width = 200,
	 	height = 75,
        left = 5,
        top = 5,
        id = "back",
        label = "<-- back",
        fontSize = font2,
        labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
        onRelease = function() composer.gotoScene("menu"); end,
    }
    location = composer.getSceneName( "previous" )

	local password = ""

	local function onLoginEvent( event )
		if not event.error then
			coronium:addEvent( "LoginEvent", "login " .. username )
			composer.gotoScene("signedIn", {effect = "fade", time = 3000,})
		end
	end
	local function onRegisterEvent( event )
		if not event.error then
			coronium:loginUser(email,password,onLoginEvent)
			-- composer.gotoScene("signedIn", {effect = "fade", time = 3000,})
		end
	end

	local function registerNewUser()
    	native.setKeyboardFocus( nil )
		coronium:registerUser({ 
		email = email,
		password = password,
		username = username
		}, onRegisterEvent)
		coronium:addEvent( "registerUEvent", "register " .. email )
	end


	local options = {text ="Please enter the information required. Good luck out there!", x = display.contentCenterX, y = 200, font = native.systemFont, fontSize = font3, width = display.actualContentWidth-50,align = "center"}
	local instruct = display.newText(options)
	local text4 = display.newText("Email:",20,yCenter/4+150,nil,font2)
	text4.anchorX = 0
	local text1 = display.newText("Username:",20,yCenter/4+250,nil,font2)
	text1.anchorX = 0
	local text2 = display.newText("Password:",20,yCenter/4+350,nil,font2)
	text2.anchorX = 0

	local submit = widget.newButton
	{
	    label = "Submit",
	    font = nil,
	    fontSize = font2,
	    emboss = true,
	    shape = "roundedRect",
	    width = display.contentWidth/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
		onRelease = registerNewUser
	    -- onEvent = moveScenes
	}

	-- Center the button
	submit.x = display.contentCenterX
	submit.y = yCenter/2+(3*(yCenter/2))/5	

	localGroup:insert(instruct)
	-- localGroup:insert(instruct2)
	-- localGroup:insert(instruct3)
	-- localGroup:insert(emailBox)
	localGroup:insert(text4)
	localGroup:insert(text1)
	localGroup:insert(text2)
	localGroup:insert(submit)
	localGroup:insert(back)
	localGroup:insert(usernameBox)
	localGroup:insert(emailBox)
	localGroup:insert(passwordBox)


	local function emailListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	email = event.target.text
	    elseif ( event.phase == "editing" ) then
	    end
	end

	local function userListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	username = event.target.text
	    elseif ( event.phase == "editing" ) then
	    end
	end

	local function passwordListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	password = event.target.text
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
end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
	nerfImage.alpha = .2
end

function scene:hide(event)
	localGroup.alpha = 0
	localGroup:removeSelf( )
	composer.removeScene("register")
end


-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )




return scene