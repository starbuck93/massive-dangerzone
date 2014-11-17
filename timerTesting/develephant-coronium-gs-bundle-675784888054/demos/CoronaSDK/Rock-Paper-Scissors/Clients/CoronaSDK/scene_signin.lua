--======================================================================--
--== Signin - Rock - Paper - Scissors
--======================================================================--
local composer = require( "composer" )
local scene = composer.newScene()

composer.removeHidden()

local g = require( 'modules.globals' )

local name_fld
--======================================================================--
--== Coronium GS
--======================================================================--
function scene.onClientConnect( event )
    native.setActivityIndicator( false )
    composer.gotoScene( 'scene_lobby' )
end

function scene.connectClient( user_handle )

    local connection =
    {
        host = 'ping.coronium.gs',
        handle = user_handle,
        key = 'abc',
        ping = true
    }
    --======================================================================--
    --== GS - Connect to the server
    --======================================================================--
    gs:connect( connection )

    name_fld:removeSelf()

    native.setActivityIndicator( true )

end
--======================================================================--
--== UI
--======================================================================--
--== Get players name
function scene.onNameInput( event )
    if event.phase == 'submitted' then

        native.setKeyboardFocus( nil )

        if event.target.text then
            scene.connectClient( event.target.text )
        end
    end
end
--======================================================================--
--== Composer
--======================================================================--
function scene:create( event )

    local sceneGroup = self.view

    local name_lbl = display.newText({
        text = "Create a game handle",
        x = g.cx,
        y = g.cy - 50,
        width = g.cw,
        height = 30,
        fontSize = 20,
        align = 'center'
    })
    sceneGroup:insert( name_lbl )

    --== Name
    name_fld = native.newTextField( g.cx, g.cy, g.cw - 20, 28 )
    name_fld.font = native.newFont( native.systemFontBold, 18 )
    name_fld:addEventListener( "userInput", scene.onNameInput )

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
        --======================================================================--
        --== GS - Register for events
        --======================================================================--
        gs.events:on( "ClientConnect", scene.onClientConnect )
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
    --======================================================================--
    --== GS - Unregister for events
    --======================================================================--
    gs.events:removeEventListener( "ClientConnect", scene.onClientConnect )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene