--======================================================================--
--== Lobby - Rock - Paper - Scissors
--======================================================================--
local composer = require( "composer" )
local scene = composer.newScene()

composer.removeHidden()

local widget = require( 'widget' )

local g = require( 'modules.globals' )
local game_timer
local chat_output_fld, chat_input_fld, join_game, players_waiting
--======================================================================--
--== Coronium GS
--======================================================================--
function scene.onGameStart( event )
    if game_timer then
        timer.cancel( game_timer )
    end
    
    native.setActivityIndicator( false )
    composer.gotoScene( 'scene_game' )
end

function scene.onGameCreate( event )
    p( gs:getGameId() )
end

function scene.onClientData( event )
    local data = event.data

    if data.lobby_chat then
        chat_output_fld.text = chat_output_fld.text .. "\n" .. data.lobby_chat
    elseif data.client_cnt then
        players_waiting.text = "Total: " .. data.total .. " / Gaming: " .. data.in_game 
    end
end

function scene.onClientClose()
    local function onAlertClosed( event )
        if "clicked" == event.action then
            composer.gotoScene( 'scene_signin' )
        end
    end
    local alert = native.showAlert( "Connection Closed", "The connection to the server was closed, please reconnect.", { "OK" }, onAlertClosed )
end

function scene.removeButtons()
    display.remove( join_game )
    native.setActivityIndicator( false )
end

function scene.onJoinGame( target )
    native.setActivityIndicator( true )
    --======================================================================--
    --== GS - Send ready to play event
    --======================================================================--
    gs:send( { ready_to_play = 1 } )
    
    game_timer = timer.performWithDelay( 20000, function()
        --======================================================================--
        --== GS - Cancel game search
        --======================================================================--
        gs:cancelGame()
    end)
end

function scene.onGameCancel( event )
    p( event.data )

    native.setActivityIndicator( false )

    local alert
    alert = native.showAlert( "No Players Available", "Could not find any players for a game.  Try again in a moment.", { "OK" }, function() native.cancelAlert( alert ); end )  
end

--== Send some lobby chat
function scene.onLobbyChat( event )
    if event.phase == 'submitted' then
        native.setKeyboardFocus( nil )
        if event.target.text then
            local msg = event.target.text
            --======================================================================--
            --== GS - Get the players handle
            --======================================================================--
            local handle = gs:getPlayerHandle()
            --======================================================================--
            --== GS - Send lobby chat
            --======================================================================--
            gs:send( { lobby_chat = handle .. ": " .. msg } )
        end
        event.target.text = ""
    end
end
--======================================================================--
--== UI
--======================================================================--
function scene.buildUi( sceneGrp )

    local players_lbl = display.newText({
        text = "Players",
        x = g.cx,
        y = 64,
        width = g.cw,
        height = 20,
        font = native.systemFontBold,
        fontSize = 14,
        align = "center"
    })
    players_lbl:setTextColor( 180/255 )
    sceneGrp:insert( players_lbl )

    --==Players waiting for games
    players_waiting = display.newText({
        text = "Loading stats...",
        x = g.cx,
        y = 100,
        width = g.cw,
        height = 40,
        fontSize = 16,
        align = 'center'
    })
    sceneGrp:insert( players_waiting )

    --== Player handle
    local player_handle = display.newText({
        --======================================================================--
        --== GS - Get the players handle
        --======================================================================--
        text = gs:getPlayerHandle(),
        x = g.cx,
        y = 20,
        width = g.cw,
        height = 40,
        fontSize = 22,
        align = 'center'
    })
    sceneGrp:insert( player_handle )

    --== Game buttons
    join_game = widget.newButton({
        label = "Search for Game",
        x = g.cx,
        y = 160,
        width = 200,
        height = 60,
        fontSize = 24,
        onRelease = scene.onJoinGame
    })
    sceneGrp:insert( join_game )

    --== Lobby chat
    chat_input_fld = native.newTextField( g.cx, 240, g.cw - 20, 30 )
    chat_input_fld:setReturnKey( "send" )
    chat_input_fld:addEventListener( "userInput", scene.onLobbyChat )

    chat_output_fld = native.newTextBox( g.cx, 400, g.cw - 20, 260 )
    chat_output_fld.isEditable = false

    --======================================================================--
    --== GS - Request client count/stats
    --======================================================================--
    gs:send( { get_client_cnt = 1 } )

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
        --======================================================================--
        --== GS - Register for events
        --======================================================================--
        gs.events:on( "ClientData", scene.onClientData )
        gs.events:on( "ClientClose", scene.onClientClose )
        gs.events:on( "GameCreate", scene.onGameCreate )
        gs.events:on( "GameCancel", scene.onGameCancel )
        gs.events:on( "GameStart", scene.onGameStart )

        scene.buildUi( sceneGroup )
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

    scene.removeButtons()

    display.remove( chat_input_fld )
    display.remove( chat_output_fld )

    --======================================================================--
    --== GS - Unregister from events
    --======================================================================--
    gs.events:removeEventListener( "ClientData", scene.onClientData )
    gs.events:removeEventListener( "ClientClose", scene.onClientClose )
    gs.events:removeEventListener( "GameCreate", scene.onGameCreate )
    gs.events:removeEventListener( "GameCancel", scene.onGameCancel )
    gs.events:removeEventListener( "GameStart", scene.onGameStart )


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene