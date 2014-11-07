


local widget = require( "widget" )
local composer = require("composer")
local scene = composer.newScene()
local localGroup = display.newGroup()

local xCenter = display.contentCenterX
local yCenter = display.contentCenterY

--Called if the scene hasn't been previously seen
function scene:create( event )

    local yAxis = display.newLine( 450, 100, 450, 700 )
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






    local ready = display.newText( "Ready Up!", xCenter, yCenter + 300, nil, 72 )


    --ready up
    -- local background = display.newRect( xCenter, yCenter, 720, 1280 )
    -- background:toBack()
    -- background:setFillColor( 1,0,0 )
    -- background.alpha = .5

    -- Handle press events for the checkbox
    local function onSwitchPress( event )
        local switch = event.target
        print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
        if switch.isOn == false then
        	ready:setFillColor( 0,1,0 )
        else
        	ready:setFillColor( 1,0,0 )
        end
    end

    -- Create the widget
    local readyUP = widget.newSwitch
    {
        left = 250,
        top = 200,
        style = "onOff",
        id = "readyUP",
        initialSwitchState = false,
        onPress = onSwitchPress
    }

    readyUP.x = xCenter
    readyUP.y = yCenter + 400

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
    --localGroup:insert(background)
    localGroup:insert(ready)
    localGroup:insert(readyUP)
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

