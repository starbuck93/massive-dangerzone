--scene admin options
local xCenter = display.contentWidth
local yCenter = display.contentHeight
local scene = composer.newScene()
local localGroup = display.newGroup()


function scene:create( event )
	local back = widget.newButton{
		 width = 200,
	 	height = 75,
    	left = 0,
    	top = 0,
    	id = "back",
   		label = "<-- back",
   		fontSize = font2,
   		onRelease = function() composer.gotoScene("menu"); end,
    }

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
	
	local options = {
	text ="Oh, hey Admin ;) Welcome to your main hub! Choose an action. What would you like to do?",
	x = display.contentCenterX, 
	y = 300, 
	font = native.systemFont, 
	fontSize = font2,
	width = display.actualContentWidth-60,
	align = "center"}

	local welcome = display.newText(options )


	local function moveScenes_01()
		composer.gotoScene("startGame", {effect = "fade", time = 3000,})
	end
	local function moveScenes_02()
		composer.gotoScene("EditGame", {effect = "fade", time = 3000,})
	end
	local function moveScenes_03()
		--instead of moving to a scene here, maybe we'll want to load another scene with some data or something
		composer.gotoScene("inGameAdmin", {effect = "fade", time = 3000,})
	end



	local start = widget.newButton
	{
	    label = "Start",
	    font = nil,
	    fontSize = font4,
	    emboss = true,
	    shape="roundedRect",
	    width = xCenter/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onRelease = moveScenes_01
	}
	local edit = widget.newButton
	{
	    label = "Edit",
	    font = nil,
	    fontSize = font4,
	    emboss = true,
	    shape="roundedRect",
	    width = xCenter/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onRelease = moveScenes_02
	}
	local resume = widget.newButton
	{
	    label = "Resume",
	    font = nil,
	    fontSize = font4,
	    emboss = true,
	    shape="roundedRect",
	    width = xCenter/2,
	    height = 100,
	    cornerRadius = 50,
		labelColor = { default={ 1, 1, 1}, over={ 232/255, 100/255, 37/255, 1 } },
		fillColor = { default={ 232/255, 100/255, 37/255}, over={ 1, 1, 1, 1 } },
	    onRelease = moveScenes_03
	}

	--set button locations
	start.x = display.contentCenterX
	start.y = display.contentCenterY
	edit.x = display.contentCenterX
	edit.y = display.contentCenterY+150 
	resume.x = display.contentCenterX
	resume.y = display.contentCenterY+300

	localGroup:insert(welcome)
	localGroup:insert(resume)
	localGroup:insert(edit)
	localGroup:insert(start)
	localGroup:insert(back)

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
