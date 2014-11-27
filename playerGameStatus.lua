
--====================================================================--
-- SCENE: gameStatus
--====================================================================--

local scene = composer.newScene()
local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()



--Called if the scene hasn't been previously seen
function scene:create( event )

    local options ={text="I'm Ready!", x=display.contentCenterX, y = display.contentCenterY+550, font=native.systemFont, fontSize=30, width= display.actualContentWidth, align="center"}
    local imReady = display.newText(options)
    imReady.alpha=0


    local back = widget.newButton{
        width = 200,
        height = 75,
        left = 0,
        top = 0,
        id = "back",
        label = "<-- back",
        fontSize = 50,
        onRelease = function() composer.gotoScene("signedIn"); end,
    }
    location = composer.getSceneName( "previous" )

    nerfImage.alpha = 0 --a global value
    local yAxis =     display.newLine( 450, 100, 450, 700 )
    local xAxis_00 = display.newLine( 0, 100, 800, 100 )
    local xAxis_01 = display.newLine( 0, 200, 800, 200 )
    local xAxis_02 = display.newLine( 0, 300, 800, 300 )
    local xAxis_03 = display.newLine( 0, 400, 800, 400 )
    local xAxis_04 = display.newLine( 0, 500, 800, 500 )
    local xAxis_05 = display.newLine( 0, 600, 800, 600 )
    local xAxis_06 = display.newLine( 0, 700, 800, 700 )

    yAxis.strokeWidth    = 3
    xAxis_00.strokeWidth = 3
    xAxis_01.strokeWidth = 3
    xAxis_02.strokeWidth = 3
    xAxis_03.strokeWidth = 3
    xAxis_04.strokeWidth = 3
    xAxis_05.strokeWidth = 3
    xAxis_06.strokeWidth = 3

    local GameName   = display.newText( "Game Details:", xCenter-50, 150, nil, 36 )
    local numPlayers = display.newText( "# of joined players:", xCenter-90, 250, nil, 36 )
    local numTeams   = display.newText( "# of teams in game:", xCenter-100, 350, nil, 36 )
    local numCapt    = display.newText( "# of captains per team:", xCenter-125, 450, nil, 36 )
    local timeLimit  = display.newText( "Time Limit:", xCenter-30, 550, nil, 36 )
    local timeBegin  = display.newText( "Game begins in:", xCenter-75, 650, nil, 36 )



    --ready up
    readyRect = display.newRect( xCenter, yCenter, display.actualContentWidth , display.actualContentHeight )
    readyRect:setFillColor( 153/255,0,0 )
    local ready = display.newText( "Ready Up!", xCenter, yCenter + 300, nil, 72 )
    readyRect:toBack()



    -- Handle press events for the checkbox
    local function onSwitchPress( event )
        local switch = event.target
        print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
        if switch.isOn == false then

        	readyRect:setFillColor( 0,100/255,0 )
            -- readyRect:toBack() --dont need this
            imReady.alpha = 1
            imReady:setFillColor( 1,1,1 )
            imReady.text="I'm Ready!"
        else
        	readyRect:setFillColor( 139/255,0,0 )
            imReady:setFillColor( black )
            imReady.alpha=0

        end
    end

    -- Create the widget
    local readyUP = widget.newSwitch
    {
        style = "onOff",
        id = "readyUP",
        initialSwitchState = false,
        onPress = onSwitchPress
    }

    readyUP:scale( 2, 2 )
    readyUP.x = xCenter
    readyUP.y = yCenter + 500

    localGroup:insert(yAxis)
    localGroup:insert(xAxis_00)
    localGroup:insert(xAxis_01)
    localGroup:insert(xAxis_02)
    localGroup:insert(xAxis_03)
    localGroup:insert(xAxis_04)
    localGroup:insert(xAxis_05)
    localGroup:insert(xAxis_06)
    localGroup:insert(GameName)
    localGroup:insert(numPlayers)
    localGroup:insert(numTeams)
    localGroup:insert(numCapt)
    localGroup:insert(timeLimit)
    localGroup:insert(timeBegin)
    localGroup:insert(ready)
    localGroup:insert(imReady)
    localGroup:insert(readyUP)    
    localGroup:insert(back)    

    localGroup:toFront() --nice
end

function scene:show(event)
    localGroup.alpha = 1
    readyRect.alpha = 1
    composer.removeHidden( true )

end

function scene:hide(event)
    localGroup.alpha = 0
    readyRect.alpha = 0
end


-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )

return scene
