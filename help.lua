
--====================================================================--
-- SCENE: HALP
--====================================================================--


local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()
local scene = composer.newScene()

function scene:create( event )

	--Ads Loading Here
	ads.init( "admob", "ca-app-pub-1135191116314099/8859539762" )
	ads.show( "banner", { x=0, y=display.contentHeight})

	local options = {
	text ="Hello there! Thanks for downloading our app! If you have any questions, or would like to report a bug, please contact the following:", 
	x = display.contentCenterX, 
	y = 300, 
	font = native.systemFont, 
	fontSize = font2,
	width = display.actualContentWidth-60,
	align = "center"}
	local intro=display.newText(options)
	local contact = display.newText( "acs11e@acu.edu", xCenter, yCenter + 100, nil, font2 )
	local contact2 = display.newText( "rap10c@acu.edu", xCenter, yCenter + 150, nil, font2 )

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
        onRelease = function() ads.hide(); composer.gotoScene(location); end,
    }
    location = composer.getSceneName( "previous" )
	
	localGroup:insert( intro )
	localGroup:insert( contact )
	localGroup:insert( contact2 )
	localGroup:insert( back )


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