

local xCenter = display.contentWidth
local yCenter = display.contentHeight
local widget = require ( "widget" )
local composer = require("composer")
local scene = composer.newScene()
local localGroup = display.newGroup()


function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

	local welcome = display.newText( "Oh, hey Admin ;)", display.contentCenterX, 100, nil, 36)
	local welcome = display.newText( "Welcome to your main hub!", display.contentCenterX, 150, nil, 36)
	local welcome = display.newText( "What ywould you like to do?", display.contentCenterX, 200, nil, 36)



	local function moveScenes_01()
		composer.gotoScene("StartGame", {effect = "fade", time = 3000,})
	end
	local function moveScenes_02()
		composer.gotoScene("EditGame", {effect = "fade", time = 3000,})
	end
	local function moveScenes_03()
		composer.gotoScene("ResumeGame", {effect = "fade", time = 3000,})
	end



		local start = widget.newButton
		{
		    label = "Start a Game",
		    font = nil,
		    fontSize = 38,
		    emboss = true,
		    shape="roundedRect",
		    width = 325,
		    height = 100,
		    cornerRadius = 50,
		    fillColor = { default={ 0, 1, 0, 1 }, over={ 1, 1, 0, 1} },
		    onEvent = moveScenes_01
		}
		local edit = widget.newButton
		{
		    label = "Edit a Game",
		    font = nil,
		    fontSize = 38,
		    emboss = true,
		    shape="roundedRect",
		    width = 325,
		    height = 100,
		    cornerRadius = 50,
		    fillColor = { default={ 0, 1, 0, 1 }, over={ 1, 1, 0, 1} },
		    onEvent = moveScenes_02
		}
		local resume = widget.newButton
		{
		    label = "Resume a Game",
		    font = nil,
		    fontSize = 38,
		    emboss = true,
		    shape="roundedRect",
		    width = 325,
		    height = 100,
		    cornerRadius = 50,
		    fillColor = { default={ 0, 1, 0, 1 }, over={ 1, 1, 0, 1} },
		    onEvent = moveScenes_03
		}

	--set button locations
	start.x = display.contentCenterX
	start.y = display.contentCenterY-150
	edit.x = display.contentCenterX
	edit.y = display.contentCenterY
	resume.x = display.contentCenterX
	resume.y = display.contentCenterY+150
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