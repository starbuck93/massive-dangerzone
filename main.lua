--project: FinalNoNameYet
--Adam Starbuck 2014

globals = require( "globals" ) -- make this global
coronium = require( "mod_coronium" ) -- make this global
composer = require("composer") -- make this global
widget = require ( "widget" )

display.setDefault( "background", 40/255, 66/255, 99/255, 1 )
display.setStatusBar( display.HiddenStatusBar )
-- widget.setTheme( "widget_theme_android_holo_dark" )

--== Init Coronium
coronium:init({ appId = globals.appId, apiKey = globals.apiKey })

--== Store in globals module
globals.coronium = coronium

--== Start composer
display.setStatusBar( display.HiddenStatusBar )

coronium:appOpened() --analytics

--global variables for logging in and things
--these variables are to store data based on user input and the input functions at the bottom of the scene:create function
email = "default"
username = "default"

font1 = 34
font2 = 48
font3 = 60
font4 = 70
font5 = 80

--a few global variables to store the input text in
gameTypeText = "default variable"
teamNumText = "2"
capNumText = "1"
gameLengthText = "60"
TTSText = "10"

--very important... object ID
objId = ""

--retrieve the above variables and set them if they exist
--coronium:getObject( "testGameData", "ObjectID", function(e)
--		print(e.result.objectId)
--	end)


--dynamic fonts. you're welcome.
if display.contentWidth < 720 and display.contentHeight < 1080 then
	font1 = font1-(font1*0.1)
	font2 = font2-(font2*0.1) 
	font3 = font3-(font3*0.1)
	font4 = font4-(font4*0.1)
	font5 = font5-(font5*0.1)
end   


function helpFunction()
	composer:gotoScene("help")
	--coronium:addEvent( "helpEvent", "Help! " .. username)
end

help = widget.newButton --another global value that we can edit the alpha of
{
	id = "helpMe",
    label = "?",
    fontSize = 60,
    onRelease = helpFunction,
    shape="circle",
    height = 1,
	labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
	fillColor = { default={ 232/255, 100/255, 37/255, 1}, over={ 1, 1, 1, .5 } },
	radius = 40,
	emboss = true
}
help.x = display.contentWidth-50
help.y = display.contentHeight-50
help.alpha = 0


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