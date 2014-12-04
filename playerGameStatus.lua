
--====================================================================--
-- SCENE: gameStatus
--====================================================================--

local scene = composer.newScene()
local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()



--Called if the scene hasn't been previously seen
function scene:create( event )

    local options ={text="I'm Ready!", x=display.contentCenterX, y = display.contentCenterY+550, font=native.systemFont, fontSize=font1, width= display.actualContentWidth, align="center"}
    local imReady = display.newText(options)

    imReady.alpha=0


    local back = widget.newButton{
        width = 200,
        height = 75,
        left = 0,
        top = 0,
        id = "back",
        label = "<-- back",
        fontSize = font2,
        onRelease = function() composer.gotoScene("signedIn"); end,
    }
    location = composer.getSceneName( "previous" )

    nerfImage.alpha = 0 --a global value
    local yAxis =     display.newLine( xCenter, 100, xCenter, 700 )
    local xAxis_00 = display.newLine( 0, 100, display.actualContentWidth, 100 )
    local xAxis_01 = display.newLine( 0, 200, display.actualContentWidth, 200 )
    local xAxis_02 = display.newLine( 0, 300, display.actualContentWidth, 300 )
    local xAxis_03 = display.newLine( 0, 400, display.actualContentWidth, 400 )
    local xAxis_04 = display.newLine( 0, 500, display.actualContentWidth, 500 )
    local xAxis_05 = display.newLine( 0, 600, display.actualContentWidth, 600 )
    local xAxis_06 = display.newLine( 0, 700, display.actualContentWidth, 700 )

    yAxis.strokeWidth    = 3
    xAxis_00.strokeWidth = 3
    xAxis_01.strokeWidth = 3
    xAxis_02.strokeWidth = 3
    xAxis_03.strokeWidth = 3
    xAxis_04.strokeWidth = 3
    xAxis_05.strokeWidth = 3
    xAxis_06.strokeWidth = 3

    local GameName   = display.newText( "Game Details:", 10, 150, nil, font1 )
    GameName.anchorX = 0
    local numPlayers = display.newText( "# of joined players:", 10, 250, nil, font1 )
    numPlayers.anchorX = 0
    local numTeams   = display.newText( "# of teams in game:", 10, 350, nil, font1 )
    numTeams.anchorX = 0
    local numCapt    = display.newText( "# of captains per team:", 10, 450, nil, font1 )
    numCapt.anchorX = 0
    local timeLimit  = display.newText( "Time Limit:", 10, 550, nil, font1 )
    timeLimit.anchorX = 0
    local timeBegin  = display.newText( "Game begins in:", 10, 650, nil, font1 )
    timeBegin.anchorX = 0


    --ready up
    readyRect = display.newRect( xCenter, yCenter, display.actualContentWidth , display.actualContentHeight )
    readyRect:setFillColor( 153/255,0,0 )
    local ready = display.newText( "Ready Up!", xCenter, yCenter + 300, nil, font3 )
    readyRect:toBack()

    local function enterGame( event )
    	composer.gotoScene("inGame")
    end


    -- Handle press events for the checkbox
    local function onSwitchPress( event )
        local switch = event.target
        print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
        if switch.isOn == false then

        	readyRect:setFillColor( 0,100/255,0 )
            -- readyRect:toBack() --dont need this
            imReady.alpha = 1
            imReady:setFillColor( 1,1,1 )
            timer.performWithDelay( 2000, enterGame )
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
