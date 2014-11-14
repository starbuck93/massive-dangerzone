--project: FinalNoNameYet
--Adam Starbuck 2014

local globals = require( "globals" )
local coronium = require( "mod_coronium" )

display.setDefault( "background", 40/255, 66/255, 99/255, 1 )


--== Init Coronium
coronium:init({ appId = globals.appId, apiKey = globals.apiKey })

--== Store in globals module
globals.coronium = coronium

--== Start composer
local composer = require("composer")
display.setStatusBar( display.HiddenStatusBar )

coronium:appOpened() --analytics

--global variables for logging in and things
--these variables are to store data based on user input and the input functions at the bottom of the scene:create function
email = "default"
username = "default"


--splash screen, then menu

nerfImage = display.newImage( "pics/NERF_transparent.png") -- I changed the alpha to go to only .2 instead of 0 so it stays there all the time. you can edit the alpha using "nerfImage.alpha" at any point because it is a global value now

	nerfImage.x = display.contentCenterX
	nerfImage.y = 200

local function fadeout() 
	local options =
{
    effect = "fade",
    time = 1000,
}
	composer.gotoScene("menu", options)
end
	timer.performWithDelay( 3000, transition.to( nerfImage, {time = 1000, alpha = .2}) )
	timer.performWithDelay( 1000, fadeout)