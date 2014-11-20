local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local widget = require( "widget" )
local localGroup = display.newGroup()
composer = require("composer")
local scene = composer.newScene()


function scene:create( event )
	local back = widget.newButton{
        left = 0,
        top = 0,
        id = "back",
        label = "<-- back",
        fontSize = 30,
        onRelease = function() composer.gotoScene("adminOptions"); end,
    }
    location = composer.getSceneName( "previous" )

-------------------------------------------
-- Configure display
-------------------------------------------
	local yAxis =    display.newLine( 450, 100, 450, 700 )
    local xAxis_00 = display.newLine( 0, 100, 800, 100 )
    local xAxis_01 = display.newLine( 0, 200, 800, 200 )
    local xAxis_02 = display.newLine( 0, 300, 800, 300 )
    local xAxis_03 = display.newLine( 0, 400, 800, 400 )
    local xAxis_04 = display.newLine( 0, 500, 800, 500 )
    local xAxis_05 = display.newLine( 0, 600, 800, 600 )


    yAxis.strokeWidth    = 3
    xAxis_00.strokeWidth = 3
    xAxis_01.strokeWidth = 3
    xAxis_02.strokeWidth = 3
    xAxis_03.strokeWidth = 3
    xAxis_04.strokeWidth = 3
    xAxis_05.strokeWidth = 3
  

    local GameName   = display.newText( "Game Name:", xCenter-50, 150, nil, 36 )
    local numTeam	 = display.newText( "# of teams:", xCenter-90, 250, nil, 36 )
    local numCapt    = display.newText( "# of captains per team:", xCenter-125, 350, nil, 36 )
    local timeLimit  = display.newText( "Time Limit:", xCenter-30, 450, nil, 36 )
    local timeBegin  = display.newText( "Game begins in:", xCenter-75, 550, nil, 36 )


-------------------------------------------
-- Configure the picker wheel for Game Type
-------------------------------------------
	

	local function GTbutton ()
		local gameTypes = 
		{
		    -- gameTypes
		    { 
		        align = "left",
		        width = 140,
		        startIndex = 1,
		        labels = { "TDM","CTF","Zombies" }
		    }
		}

		-- Create the widget
		local pickerWheel = widget.newPickerWheel
		{
		    top = display.contentHeight - 222,
		    columns = gameTypes
		}


	end

	local gameSelect = widget.newButton{
        left = xCenter + 125,
        top = 125,
        label = "Select Game Type",
        fontSize = 20,
        onRelease = GTbutton; 
    }	-------------------------------------------
	-- Configure textBox for #of teams
	-------------------------------------------
	teamNum = native.newTextField( xCenter + 270,250, xCenter, 100)
		teamNum.inputType = "default"
		teamNum.size = "10"

	-------------------------------------------
	-- Configure textBox for #captains per team
	-------------------------------------------
	capNum = native.newTextField( xCenter + 270,350, xCenter, 100)
		capNum.inputType = "default"
		capNum.size = "10"

	-------------------------------------------
	-- Configure pickerwheel for time-to-start
	-------------------------------------------
	--labels = {  "No time Limit", "5:00", "10:00", "15:00", "20:00", "30:00", "45:00", "1:00:00", "1:15:00", "1:30:00", "1:45:00", "2:00:00"}
	local function GLbutton ()
			local gameLength = 
			{
			    -- gameTypes
			    { 
			        align = "left",
			        width = 140,
			        startIndex = 1,
			        labels = { "No time Limit", "5:00", "10:00", "15:00", "20:00", "30:00", "45:00", "1:00:00", "1:15:00", "1:30:00", "1:45:00", "2:00:00"}
			    }
			}

			-- Create the widget
			local pickerWheel = widget.newPickerWheel
			{
			    top = display.contentHeight - 222,
			    columns = gameLength
			}


		end

		local gameSelect = widget.newButton{
	        left = xCenter + 125,
	        top = 425,
	        label = "Length of Game",
	        fontSize = 20,
	        onRelease = GLbutton; 
	    }

	-------------------------------------------
	-- Configure pickerwheel for length of game
	-------------------------------------------
	--labels = { "On Creation","1:00","5:00","8:00","10:00","20:00","30:00","45:00" }
	local function TTSbutton ()
			local gameStart = 
			{
			    -- gameTypes
			    { 
			        align = "left",
			        width = 140,
			        startIndex = 1,
			        labels = { "On Creation","1:00","5:00","8:00","10:00","20:00","30:00","45:00"}
			    }
			}

			-- Create the widget
			local pickerWheel = widget.newPickerWheel
			{
			    top = display.contentHeight - 222,
			    columns = gameStart
			}


		end

		local gameSelect = widget.newButton{
	        left = xCenter + 125,
	        top = 525,
	        label = "Time to Start",
	        fontSize = 20,
	        onRelease = TTSbutton; 
	    }
	

	-- Get the table of current values for all columns
	-- This can be performed on a button tap, timer execution, or other event

	localGroup:insert(yAxis)
    localGroup:insert(xAxis_00)
    localGroup:insert(xAxis_01)
    localGroup:insert(xAxis_02)
    localGroup:insert(xAxis_03)
    localGroup:insert(xAxis_04)
    localGroup:insert(xAxis_05)
    localGroup:insert(GameName)
    localGroup:insert(numTeam)
    localGroup:insert(numCapt)
    localGroup:insert(timeLimit)
    localGroup:insert(timeBegin)

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