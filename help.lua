
--====================================================================--
-- SCENE: HALP
--====================================================================--


local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()
local scene = composer.newScene()

function scene:create( event )

	-- --Ads Loading Here
	-- ads.init( "admob", "ca-app-pub-1135191116314099/8859539762" )
	-- ads.show( "banner", { x=0, y=display.contentHeight})

	local scrollView = widget.newScrollView
	{
		id = "helpScroll",
	    top = 100,
	    left = 15,
	    width = display.contentWidth-30,
	    height = display.contentHeight-100,
	    scrollWidth = 600,
	    scrollHeight = 800,
		horizontalScrollDisabled = true,
		backgroundColor = {40/255, 66/255, 99/255}
	}


	local options = {
	text ="Hello there! Thanks for downloading our app! Here's a quick tutorial on how to use the app. Tap Login->Admin->Resume and you'll see the timer that we've created. Tap Login->Admin->Start and type in the information in the correct format (military time with 4 digits) and then you'll get to watch the coutdown until your specified time. If you have any questions, or would like to report a bug, please tap on the following email addresses.", 
	x = display.contentCenterX, 
	y = 100, 
	font = native.systemFont, 
	fontSize = font2,
	width = display.actualContentWidth-40,
	align = "center"}
	local intro=display.newText(options)
	intro.anchorY = 0
	local contact = display.newText( "acs11e@acu.edu", 0, yCenter*2-100, nil, font2 )
	contact.anchorX = 0
	contact.anchorY = 1
	local contact2 = display.newText( "rap10c@acu.edu", xCenter*2, yCenter*2, nil, font2 )
	contact2.anchorX = 1
	contact2.anchorY = 1

	scrollView:insert( intro )
	scrollView:insert( contact )
	scrollView:insert( contact2 )

	function onObjectTap1( event )
		system.openURL("mailto:acs11e@acu.edu?subject=NerfApp")
	end
	function onObjectTap2( event )
		system.openURL("mailto:rap10c@acu.edu?subject=NerfApp")
	end


	local back = widget.newButton{
	 	width = 200,
	 	height = 75,
        left = 5,
        top = 5,
        id = "back",
        label = "<-- back",
        fontSize = font2,
        labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
        location = composer.getSceneName( "previous" ),
        onRelease = function() composer.gotoScene(location); end, --ads.hide();
    }
    location = composer.getSceneName( "previous" )
	
	localGroup:insert( intro )
	localGroup:insert( contact )
	localGroup:insert( contact2 )
	localGroup:insert( back )
	localGroup:insert( scrollView )

	contact:addEventListener( "tap", onObjectTap1 )
	contact2:addEventListener( "tap", onObjectTap2 )


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