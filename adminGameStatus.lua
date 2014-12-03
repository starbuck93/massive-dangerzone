
--====================================================================--
-- SCENE: adminGameStatus
--====================================================================--

local scene = composer.newScene()
local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local localGroup = display.newGroup()



--Called if the scene hasn't been previously seen
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

    nerfImage.alpha = 0 --a global value
    local yAxis =     display.newLine( xCenter, 100, xCenter, 700 )
    local xAxis_00 = display.newLine( 0, 100, display.contentWidth, 100 )
    local xAxis_01 = display.newLine( 0, 200, display.contentWidth, 200 )
    local xAxis_02 = display.newLine( 0, 300, display.contentWidth, 300 )
    local xAxis_03 = display.newLine( 0, 400, display.contentWidth, 400 )
    local xAxis_04 = display.newLine( 0, 500, display.contentWidth, 500 )
    local xAxis_05 = display.newLine( 0, 600, display.contentWidth, 600 )
    local xAxis_06 = display.newLine( 0, 700, display.contentWidth, 700 )

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
    local timeLimit  = display.newText( "Time Limit:",10, 550, nil, font1 )
    timeLimit.anchorX = 0
    local timeBegin  = display.newText( "Game begins in:", 10, 650, nil, font1 )
    timeBegin.anchorX = 0

    --variables inserted here
    local GameName2   = display.newText( gameTypeText, display.contentWidth-10, 150, nil, font1 )
    GameName2.anchorX = 1
    local numPlayers2 = display.newText( "0", display.contentWidth-10, 250, nil, font1 )
    numPlayers2.anchorX = 1
    local numTeams2   = display.newText( teamNumText, display.contentWidth-10, 350, nil, font1 )
    numTeams2.anchorX = 1
    local numCapt2    = display.newText( capNumText, display.contentWidth-10, 450, nil, font1 )
    numCapt2.anchorX = 1
    local timeLimit2  = display.newText( gameLengthText, display.contentWidth-10, 550, nil, font1 )
    timeLimit2.anchorX = 1
    local timeBegin2  = display.newText( TTSText, display.contentWidth-10, 650, nil, font1 )
    timeBegin2.anchorX = 1


    -- Handler that gets notified when the alert closes
    local function onComplete( event )
       if event.action == "clicked" then
            local i = event.index
            if i == 1 then
                -- Do nothing; dialog will simply dismiss
            elseif i == 2 then
                -- Open URL if "Learn More" (second button) was clicked
                native.showAlert( "Killed", "You have successfully killed the game.", {"Got it."})
                composer.gotoScene("adminOptions")
            end
        end
    end

    -- Show alert with two buttons
    local function killGameAlert( ... )
        native.showAlert( "Kill Game?", "Are you sure you would like to kill the game?.", { "Cancel", "Yes" }, onComplete )
    end


    local killGame = widget.newButton
    {
        label = "KILL GAME",
        labelColor = {default ={1,1,1,1}, over={1,0,0,1} },
        font = nil,
        fontSize = 48,
        emboss = true,
        shape="roundedRect",
        width = display.contentWidth/2,
        height = 100,
        cornerRadius = 50,
        labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
        fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
        onRelease = killGameAlert
    }

    killGame.x = xCenter
    killGame.y = yCenter + 300


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
    localGroup:insert(GameName2)
    localGroup:insert(numPlayers2)
    localGroup:insert(numTeams2)
    localGroup:insert(numCapt2)
    localGroup:insert(timeLimit2)
    localGroup:insert(timeBegin2) 
    localGroup:insert(back)
    localGroup:insert(killGame)    

    --localGroup:toFront() --nice
end

function scene:show(event)
    localGroup.alpha = 1
    composer.removeHidden( true )

end

function scene:hide(event)
    localGroup.alpha = 0
    --composer.removeScene("adminGameStatus")
end


-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )

return scene
