--======================================================================--
--== Lobby - Rock - Paper - Scissors
--======================================================================--
local composer = require( "composer" )
local scene = composer.newScene()

composer.removeHidden()

local g = require( 'modules.globals' )

function scene.renderChat( msg )
    chat_output_fld.text = msg .."\n" .. chat_output_fld.text
end

local attack_lock = true
local arrow_grp = display.newGroup()
--======================================================================--
--== Coronium GS
--======================================================================--
function scene.onClientData( event )
    p( event.data )
    
    local data = event.data
    --======================================================================--
    --== Game Chat
    --======================================================================--
    if data.game_chat then
        scene.renderChat( data.game_chat )
    --======================================================================--
    --== Choose attack
    --======================================================================--
    elseif data.choose_attack then
        attack_lock = false
        scene.renderChat( "Choose your attack" )
        scene.clearArrows()
    --======================================================================--
    --== Round results
    --======================================================================--
    elseif data.winner then
        local msg = ""
        if data.winner == 0 then
            msg = "The round was a tie!"
        elseif data.winner == gs:getPlayerNum() then
            msg = "You WON the round!"
        else
            msg = "You lost this round!"
        end

        scene.renderChat( msg )
        scene.renderArrows( { p1 = data.p1, p2 = data.p2 } )
    --======================================================================--
    --== Player has left
    --======================================================================--
    elseif data.player_left then
        scene.onClientLeft( data )
    end
end

function scene.onClientLeft( data )
    local function onAlertClosed( event )
        if "clicked" == event.action then
            composer.gotoScene( 'scene_lobby' )
        end
    end
    local alert = native.showAlert( "Player Left", data.player_name .. " has left the game.", { "OK" }, onAlertClosed )    
end

function scene.onClientClose()
    local function onAlertClosed( event )
        if "clicked" == event.action then
            composer.gotoScene( 'scene_signin' )
        end
    end
    local alert = native.showAlert( "Connection Closed", "The connection to the server was closed, please reconnect.", { "OK" }, onAlertClosed )
end

function scene.onGameData( event )
    p( event.data )
end

function scene.onGameDone( event )
    scene.clearArrows()

    scene.renderChat( "3 Rounds - Game Done!")
    scene.renderChat( event.data.msg )

    timer.performWithDelay( 4000, function()
        composer.gotoScene( 'scene_lobby' )
    end)
end

--== Send some game chat
function scene.onGameChat( event )
    if event.phase == 'submitted' then
        native.setKeyboardFocus( nil )
        if event.target.text then
            local msg = event.target.text
            --======================================================================--
            --== GS - Get the players handle
            --======================================================================--
            local handle = gs:getPlayerHandle()
            --======================================================================--
            --== GS - Send game chat
            --======================================================================--
            gs:send( { game_chat = handle .. ": " .. msg } )
        end
        event.target.text = ""
    end
end
--======================================================================--
--== UI
--======================================================================--
function scene.renderArrows( render_tbl )

    scene.clearArrows()

    if render_tbl.p1 then
        local a1 = display.newImage( 'gpx/arrow_p1.png' )
        a1.x = ( 100 * ( render_tbl.p1 - 1 ) ) + 60
        a1.y = 160
        arrow_grp:insert( a1 )
    end

    if render_tbl.p2 then
        local a2 = display.newImage( 'gpx/arrow_p2.png' )
        a2.x = ( 100 * ( render_tbl.p2 - 1 ) ) + 60
        a2.y = 80
        arrow_grp:insert( a2 )
    end

    scene.view:insert( arrow_grp )
end

function scene.clearArrows()
    for i=arrow_grp.numChildren, 0, -1 do
        display.remove( arrow_grp[i] )
    end
end

function scene.buildUi( sceneGrp )

    --======================================================================--
    --== GS - Get the players handle
    --======================================================================--
    local p_text = "(P" .. gs:getPlayerNum() .. ") " .. gs:getPlayerHandle()

    player_handle = display.newText({
        text = p_text,
        x = g.cx,
        y = 20,
        width = g.cw,
        height = 40,
        fontSize = 16,
        align = 'center'
    })
    sceneGrp:insert( player_handle )

    --== Lobby chat
    chat_input_fld = native.newTextField( g.cx, 240, g.cw - 20, 30 )
    chat_input_fld:setReturnKey( "send" )
    chat_input_fld:addEventListener( "userInput", scene.onGameChat )

    chat_output_fld = native.newTextBox( g.cx, 400, g.cw - 20, 260 )
    chat_output_fld.isEditable = false

    --==Rock Paper or Scissors
    local function onChooseAttack( event )
        if not attack_lock then
            attack_lock = true
            local a_type
            local a = event.target.attack
            if a == 1 then
                a_type = "Rock"
            elseif a == 2 then
                a_type = "Paper"
            else
                a_type = "Scissors"
            end

            scene.renderChat( "You selected " .. a_type )

            scene.renderArrows( { ["p"..gs:getPlayerNum()] = a } )

            --======================================================================--
            --== GS - Send the players 'attack' choice
            --======================================================================--
            gs:send( { use_attack = event.target.attack } )
        end
    end

    local grp = display.newGroup()

    local rock = display.newRect( 0, 0, 60, 60 )
    rock.anchorX = -1
    rock:setFillColor( 1 )
    rock.attack = 1

    rock:addEventListener( "tap", onChooseAttack )

    grp:insert( rock )

    local paper = display.newRect( 105, 0, 60, 60 )
    paper.anchorX = -1
    paper:setFillColor( 180/255 )
    paper.attack = 2

    paper:addEventListener( "tap", onChooseAttack )

    grp:insert( paper )

    local scissors = display.newRect( 210, 0, 60, 60 )
    scissors.anchorX = -1
    scissors:setFillColor( 120/255 )
    scissors.attack = 3

    scissors:addEventListener( "tap", onChooseAttack )

    grp:insert( scissors )

    sceneGrp:insert( grp )

    grp.y = 120
    grp.x = g.cx - ( grp.width * .5 )

    local bg = display.newImage( 'gpx/rps.png' )
    
    bg.x = g.cx
    bg.y = 120

    sceneGrp:insert( bg )

end
--======================================================================--
--== Composer
--======================================================================--
function scene:create( event )
    local sceneGroup = self.view
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
        scene.buildUi( sceneGroup )

        --======================================================================--
        --== GS - Register for events
        --======================================================================--
        gs.events:on( "ClientData", scene.onClientData )
        gs.events:on( "ClientClose", scene.onClientClose )
        gs.events:on( "GameData", scene.onGameData )
        gs.events:on( "GameDone", scene.onGameDone )
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end

function scene:destroy( event )

    local sceneGroup = self.view

    display.remove( chat_input_fld )
    display.remove( chat_output_fld )

    --======================================================================--
    --== GS - Unregister for events
    --======================================================================--
    gs.events:removeEventListener( "ClientData", scene.onClientData )
    gs.events:removeEventListener( "ClientClose", scene.onClientClose )
    gs.events:removeEventListener( "GameData", scene.onGameData )
    gs.events:removeEventListener( "GameDone", scene.onGameDone )

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene