--scene Login
local xCenter = display.contentWidth
local yCenter = display.contentHeight
local scene = composer.newScene()
local localGroup = display.newGroup()

local function moveScenes()
	ads.hide()
	coronium:addEvent( "LoginEvent", "login normal" )
	composer.gotoScene("signedIn")
end

local function moveScenesAdmin()
	ads.hide()
	coronium:addEvent( "LoginEvent", "login admin" )
	composer.gotoScene("adminOptions")
end


--Called if the scene hasn't been previously seen
function scene:create( event )

	--Ads Loading Here
	ads.init( "admob", "ca-app-pub-1135191116314099/8859539762" )
	ads.show( "banner", { x=0, y=yCenter})

	local password = ""

    local back = widget.newButton{
        width = 200,
	 	height = 75,
        left = 5,
        top = 5,
        id = "back",
        label = "<-- back",
        fontSize = font2,
        labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
        onRelease = function() ads.hide(); composer.gotoScene("menu"); end,
    }

	local function setUsername( event )
		if not event.error then
			username = event.result.username
		end
	end

	local function onLoginEvent( event )
		if not event.error then
			coronium:addEvent( "LoginEvent", "login " .. email )
			--username = event.result.username
			composer.gotoScene("signedIn", {effect = "fade", time = 3000,})
		end
	end
	local function login( event )
		coronium:loginUser(email,password,onLoginEvent)
	end

	local function onLoginEventAdmin( event )
		if not event.error then
			coronium:addEvent( "LoginEvent", "login " .. email )
			composer.gotoScene("adminOptions", {effect = "fade", time = 3000,})
		end
	end
	local function loginEventAdmin( event )
		if email == "Admin" and password == "ADMIN" then
			coronium:loginUser(email,password,onLoginEventAdmin)
		end
	end

	local nerf = display.newImage( "pics/NERF_transparent.png",xCenter/2,200 )
	local text1 = display.newText("Email:",20,yCenter/4+250,nil,font2)
	text1.anchorX = 0
	local text2 = display.newText("Password:",20,yCenter/4+350,nil,font2)
	text2.anchorX = 0
	emailBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+250, xCenter/2, 100)
	emailBox.inputType = "default"
	emailBox.size = "10"
	emailBox.text = "Email"
	passwordBox = native.newTextField( xCenter/2+xCenter/4, yCenter/4+350, xCenter/2, 100)
	passwordBox.inputType = "default"
	passwordBox.size = "10"
	passwordBox.text = "Password"
	passwordBox.isSecure = true


	local submit = widget.newButton
	{
	    label = "Submit",
	    font = nil,
	    fontSize = font4,
	    emboss = true,
	    shape="roundedRect",
	    width = display.contentWidth/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onRelease = login
	    -- onRelease = moveScenes
	}

	local admin = widget.newButton
	{
	    label = "Admin?",
	    font = nil,
	    fontSize = font4,
	    emboss = true,
	    shape="roundedRect",
	    width = display.contentWidth/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    -- onRelease= loginEventAdmin
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
	localGroup:insert(back)
	localGroup:insert(emailBox)
	localGroup:insert(passwordBox)

	local function emailListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	email = event.target.text
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

	emailBox:addEventListener( "userInput", emailListener )
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
	composer.removeScene("login")
end

-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )


return scene

