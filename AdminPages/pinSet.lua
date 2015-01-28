--scene: menu
local xCenter = display.contentWidth
local yCenter = display.contentHeight
local scene = composer.newScene()
local localGroup = display.newGroup()


--Called if the scene hasn't been previously seen
function scene:create( event )

	-- local function pin1Listener( event )
	--     if ( event.phase == "began" ) then
	--     elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	--     	pin1 = event.target.text
	--        	native.setKeyboardFocus( nil )
	--     elseif ( event.phase == "editing" ) then
	--     end
	-- end
	
	-- local function pin2TextListener( event )
	--     if ( event.phase == "began" ) then
	--     elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	--     	pin2 = event.target.text
	--        	native.setKeyboardFocus( nil )
	--     elseif ( event.phase == "editing" ) then
	--     end
	-- end




	pin1 = display.newText( "Create 4 digit pin for ADMIN use:", xCenter/2, yCenter, [width, height,], nil, font2 )

	TTS = native.newTextField( xCenter + 270,450, xCenter, 100)
	TTS.inputType = "number"
	TTS.size = "10"
	TTS.placeholder = "(1234)"
	TTS:addEventListener( "userInput", TTSTextListener )

	-- pin2 = display.newText( "Create 4 digit pin for PUBLIC use:", xCenter+(xCenter/2), yCenter, [width, height,], nil, font2 )

	-- TTS = native.newTextField( xCenter + 270,550, xCenter, 100)
	-- TTS.inputType = "number"
	-- TTS.size = "10"
	-- TTS.placeholder = "(1234)"
	-- TTS:addEventListener( "userInput", TTSTextListener )


	local function toGame( event )
		if not ( gameTypeTemp == "") then
			gameTypeText = gameTypeTemp
	--here we're going to upload some information to the server and hopefully pull it down successfully on other client devices
			local data = { adminPin = pin1, publicPin = pin2 }
			coronium:updateObject( "testGameData", objId, data) --actually uploading to the server with the data data table
			composer.gotoScene("AdminPages.inGameAdmin", {effect = "fade", time = 3000,})
		else errorText.alpha = 1
		end
	end

	local SAG = widget.newButton
	{
		id = SAG,
	    label = "Start",
	    font = nil,
	    fontSize = font4,
	    emboss = true,
	    shape="roundedRect",
	    width = display.contentWidth/2,
	    height = 100,
	    x = xCenter,
	    y = yCenter+yCenter/2,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onEvent = toGame
	}



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

