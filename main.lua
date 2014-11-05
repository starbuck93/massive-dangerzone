--project: FinalNoNameYet
--Adam Starbuck 2014

local composer = require("composer")
display.setStatusBar( display.HiddenStatusBar )

--splash screen, then menu

local background = display.newImage( "pics/NERF_transparent.png", backgroundX, backgroundY)

	background.x = display.contentCenterX
	background.y = display.contentCenterY
local function fadeout() 
	local options =
{
    effect = "fade",
    time = 1000,
}
--	transition.to( background, {time = 500, alpha = 0})
	composer.gotoScene("menu", options)
end
	timer.performWithDelay( 3000, transition.to( background, {time = 2000, alpha = 0}) )
	timer.performWithDelay( 3000, fadeout)