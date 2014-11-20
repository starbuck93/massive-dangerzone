
--====================================================================--
-- SCENE: signed in
--====================================================================--

	
local xCenter = display.contentWidth/2
local yCenter = display.contentHeight/2
local scene = composer.newScene()
local localGroup = display.newGroup()

local function moveScenes( event )
	--if event.phase == "ended" then
		--print("Ended")
	composer.gotoScene("gameStatus", {effect = "fade", time = 1000})
	--end
end

--Called if the scene hasn't been previously seen
function scene:create( event )
	local welcomeText = display.newText("Welcome, " .. username,xCenter,yCenter-400,nil,50)
	local welcomeText2 = display.newText("Please select a game to join.",xCenter,yCenter-350,nil,50)
	local game1 = widget.newButton
	{
	    label = "Team Deathmatch",
	    labelColor = {default ={1,1,1,1}, over={1,0,0,1} },
	    font = nil,
	    fontSize = 48,
	    emboss = true,
	    shape="roundedRect",
	    width = xCenter*2-50,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onEvent = moveScenes
	}
	game1.x = xCenter
	game1.y = yCenter

	
	-- local tabButtons = {
	--     {
	--         label = "Main Menu",
	--         size = 36,
	--         id = "tab1",
	--         selected = true,
	--         labelYOffset = -25,
	--         onPress = function() composer.gotoScene( "menu" ); end,
	--     },
	--     {
	--         label = "Login",
	--         size = 36,
	--         id = "tab2",
	--         labelYOffset = -25,
	--         onPress = function() composer.gotoScene( "login" ); end,
	--     },
	--     {
	--         label = "Register",
	--         size = 36,
	--         id = "tab3",
	--         labelYOffset = -25,
	--         onPress = function() composer.gotoScene( "register" ); end,
	--     },
	-- }


	-- Create the widget
	-- local tabBar = widget.newTabBar
	-- {
	--     top = yCenter-100,
	--     width = xCenter,
	--     height = 100,
	--     buttons = tabButtons
	-- }	

	localGroup:insert(welcomeText)
	localGroup:insert(welcomeText2)
	localGroup:insert(game1)
end


function scene:show(event)
	localGroup.alpha = 1
	composer.removeHidden( true )
end

function scene:hide(event)
localGroup.alpha = 0

end

-- "createScene" is called whenever the scene is FIRST called
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )
	return scene

