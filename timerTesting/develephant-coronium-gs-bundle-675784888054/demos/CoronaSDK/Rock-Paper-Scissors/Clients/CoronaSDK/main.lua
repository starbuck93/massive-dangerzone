--======================================================================--
--== Main Rock - Paper - Scissors
--======================================================================--
display.setStatusBar( display.HiddenStatusBar )
--======================================================================--
--== Coronium GS
--======================================================================--
local gs = require( 'gs.CoroniumGSClient' ):new( true )
--======================================================================--
--== Composer
--======================================================================--
local composer = require( 'composer' )
composer.gotoScene( 'scene_signin' )
