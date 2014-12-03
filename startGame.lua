local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local widget = require( "widget" )
local localGroup = display.newGroup()
composer = require("composer")
local scene = composer.newScene()


function scene:create( event )
	local back = widget.newButton{
	 	width = 200,
	 	height = 75,        
        left = 0,
        top = 0,
        id = "back",
        label = "<-- back",
        fontSize = font2,
        onRelease = function() composer.gotoScene("adminOptions"); end,
    }
    location = composer.getSceneName( "previous" )




-------------------------------------------
-- Configure display
-------------------------------------------
	local yAxis =    display.newLine( xCenter, 100, xCenter, 600 )
    local xAxis_00 = display.newLine( 0, 100, display.contentWidth, 100 )
    local xAxis_01 = display.newLine( 0, 200, display.contentWidth, 200 )
    local xAxis_02 = display.newLine( 0, 300, display.contentWidth, 300 )
    local xAxis_03 = display.newLine( 0, 400, display.contentWidth, 400 )
    local xAxis_04 = display.newLine( 0, 500, display.contentWidth, 500 )
    local xAxis_05 = display.newLine( 0, 600, display.contentWidth, 600 )


    yAxis.strokeWidth    = 3
    xAxis_00.strokeWidth = 3
    xAxis_01.strokeWidth = 3
    xAxis_02.strokeWidth = 3
    xAxis_03.strokeWidth = 3
    xAxis_04.strokeWidth = 3
    xAxis_05.strokeWidth = 3
  

    local GameName   = display.newText( "Game Name:", 10, 150, nil, font1 )
    GameName.anchorX = 0
    local numTeam	 = display.newText( "# of teams:", 10, 250, nil, font1 )
    numTeam.anchorX = 0
    local numCapt    = display.newText( "# of captains per team:", 10, 350, nil, font1 )
    numCapt.anchorX = 0
    local timeLimit  = display.newText( "Time Limit:", 10, 450, nil, font1 )
    timeLimit.anchorX = 0
    local timeBegin  = display.newText( "Game begins in:", 10, 550, nil, font1 )
    timeBegin.anchorX = 0

--Functions for capturing the text from the text boxes--

	local function gameTypeTextListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	gameTypeText = event.target.text
	       	-- native.setKeyboardFocus( nil )
	    elseif ( event.phase == "editing" ) then
	    end
	end
	local function teamNumTextListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	teamNumText = event.target.text
	       	-- native.setKeyboardFocus( nil )
	    elseif ( event.phase == "editing" ) then
	    end
	end
	local function capNumTextListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	capNumText = event.target.text
	       	-- native.setKeyboardFocus( nil )
	    elseif ( event.phase == "editing" ) then
	    end
	end
	local function gameLengthTextListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	gameLengthText = event.target.text
	       	-- native.setKeyboardFocus( nil )
	    elseif ( event.phase == "editing" ) then
	    end
	end
	local function TTSTextListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	    	TTSText = event.target.text
	       	-- native.setKeyboardFocus( nil )
	    elseif ( event.phase == "editing" ) then
	    end
	end



-------------------------------------------
-- Configure the text box for Game Type
-------------------------------------------
	
	gameType = native.newTextField( xCenter + 270,150, xCenter, 100)
		gameType.inputType = "default"
		gameType.size = "10"
		gameType.placeholder = "(Text Name)"
	gameType:addEventListener( "userInput", gameTypeTextListener )

-------------------------------------------
-- Configure textBox for #of teams
-------------------------------------------
	teamNum = native.newTextField( xCenter + 270,250, xCenter, 100)
		teamNum.inputType = "number"
		teamNum.size = "10"
		teamNum.placeholder = "(1, 2, 3, 4)"
	teamNum:addEventListener( "userInput", teamNumTextListener )

-------------------------------------------
-- Configure textBox for #captains per team
-------------------------------------------
	capNum = native.newTextField( xCenter + 270,350, xCenter, 100)
		capNum.inputType = "number"
		capNum.size = "10"
		capNum.placeholder = "(integer number)"
	capNum:addEventListener( "userInput", capNumTextListener )

-------------------------------------------
-- Configure textBox for time-to-start
-------------------------------------------
	--labels = {  "No time Limit", "5:00", "10:00", "15:00", "20:00", "30:00", "45:00", "1:00:00", "1:15:00", "1:30:00", "1:45:00", "2:00:00"}

	gameLength = native.newTextField( xCenter + 270,450, xCenter, 100)
		gameLength.inputType = "number"
		gameLength.size = "10"
		gameLength.placeholder = "(military time, HHMM)"
	gameLength:addEventListener( "userInput", gameLengthTextListener )

-------------------------------------------
-- Configure textBox for length of game
-------------------------------------------
	--labels = { "On Creation","1:00","5:00","8:00","10:00","20:00","30:00","45:00" }
	TTS = native.newTextField( xCenter + 270,550, xCenter, 100)
		TTS.inputType = "number"
		TTS.size = "10"
		TTS.placeholder = "(integer, minutes)"
	TTS:addEventListener( "userInput", TTSTextListener )

-------------------------------------------
-- Configure save&go button
-------------------------------------------

	local function toGame( event )
--here we're going to upload some information to the server and hopefully pull it down successfully on other client devices
			local data = { gameType = gameTypeText, numberTeams = teamNumText, numberCapts = capNumText, gameLength = gameLengthText, timeToStart =  TTSText }
			coronium:createObject( "testGameData", data, function(e) --actually uploading to the server with the data data table
					if not e.error then
						objId = e.result.objectId 
					end
				end)
			composer.gotoScene("inGame", {effect = "fade", time = 3000,})
	end

	local SAG = widget.newButton
	{
		id = SAG,
	    label = "Save & Go!",
	    font = nil,
	    fontSize = font2,
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

	localGroup:insert(yAxis)
    localGroup:insert(xAxis_00)
    localGroup:insert(xAxis_01)
    localGroup:insert(xAxis_02)
    localGroup:insert(xAxis_03)
    localGroup:insert(xAxis_04)
    localGroup:insert(xAxis_05)
--display instructions
    localGroup:insert(GameName)
	localGroup:insert(numTeam)
	localGroup:insert(numCapt)
	localGroup:insert(timeLimit)
	localGroup:insert(timeBegin)
--text boxes
    localGroup:insert(gameType)
    localGroup:insert(teamNum)
    localGroup:insert(capNum)
    localGroup:insert(gameLength)
    localGroup:insert(TTS)
    localGroup:insert(SAG)
    localGroup:insert(back)
end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
end


function scene:hide(event)
	localGroup.alpha = 0
	localGroup:removeSelf( )
	composer.removeScene("startGame")
end


-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )


return scene