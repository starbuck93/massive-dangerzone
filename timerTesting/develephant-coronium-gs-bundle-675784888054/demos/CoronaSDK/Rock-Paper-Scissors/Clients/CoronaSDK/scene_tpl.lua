--======================================================================--
--== Lobby - Rock - Paper - Scissors
--======================================================================--
local composer = require( "composer" )
local scene = composer.newScene()

local g = require( 'modules.globals' )

--======================================================================--
--== Coronium GS
--======================================================================--

--======================================================================--
--== UI
--======================================================================--
local function buildUi( sceneGrp )


end
--======================================================================--
--== Composer
--======================================================================--
function scene:create( event )

    local sceneGroup = self.view

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

        buildUi( sceneGroup )

    elseif ( phase == "did" ) then


    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then

    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene