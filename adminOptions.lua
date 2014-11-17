--scene admin options
local xCenter = display.contentWidth
local yCenter = display.contentHeight
local scene = composer.newScene()
local localGroup = display.newGroup()


function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

	local welcome_l1 = display.newText( "Oh, hey Admin ;)", display.contentCenterX, 100, nil, 36)
	local welcome_l2 = display.newText( "Welcome to your main hub!", display.contentCenterX, 150, nil, 36)
	local welcome_l3 = display.newText( "What would you like to do?", display.contentCenterX, 200, nil, 36)



	local function moveScenes_01()
		composer.gotoScene("StartGame", {effect = "fade", time = 3000,})
	end
	local function moveScenes_02()
		composer.gotoScene("EditGame", {effect = "fade", time = 3000,})
	end
	local function moveScenes_03()
		--instead of moving to a scene here, maybe we'll want to load another scene with some data or something
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
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
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
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
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
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onEvent = moveScenes_03
	}

	--set button locations
	start.x = display.contentCenterX
	start.y = display.contentCenterY-150
	edit.x = display.contentCenterX
	edit.y = display.contentCenterY
	resume.x = display.contentCenterX
	resume.y = display.contentCenterY+150

	localGroup:insert(welcome_l1)
	localGroup:insert(welcome_l2)
	localGroup:insert(welcome_l3)
	localGroup:insert(resume)
	localGroup:insert(edit)
	localGroup:insert(start)

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
