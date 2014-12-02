
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
        fontSize = 50,
        onRelease = function() composer.gotoScene("adminOptions"); end,
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


    local function leavePage ()
        composer.gotoScene("adminOptions")
    end


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
        width = 400,
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
