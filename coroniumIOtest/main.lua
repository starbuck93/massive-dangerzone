--coronium testing http://docs.coronium.io/client-users/

local globals = require( "globals" )
local coronium = require( "mod_coronium" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
globals.coronium = coronium


coronium.showStatus = true
--coronium:run("hello")

coronium:appOpened()


local email = display.newText("email", 100, 500, nil, 24)


local function emailListener( event )

    if ( event.phase == "began" ) then
		native.setKeyboardFocus( emailBox )
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
    	email.text = event.target.text
    	native.setKeyboardFocus( nil )
    elseif ( event.phase == "editing" ) then
    end
end

	emailBox = native.newTextField( display.contentCenterX, display.contentCenterY, display.contentCenterX, 100)
	emailBox.inputType = "email"
	emailBox.size = "10"
	emailBox.text = "Email"

native.setKeyboardFocus( emailBox )

local function onAddEvent( event )
  if not event.error then
    print( event.result )
  end
end

local function registerUserFunction( )
--== login the user ==--
coronium:registerUser({ 
  email = "adam",
  password = "adam"
} )
coronium:addEvent( "registerUEvent", "registerUEventTag", onAddEvent )
end

local function loginUserFunction( )
coronium:loginUser("adam","adam") --fixed this line right here !! it needed to not be in a table, as registering users is in a table
 
coronium:addEvent( "LoginEvent", "LoginEventTag", onAddEvent )


end

local function logoutUserFunction()
	coronium:logoutUser()
	coronium:addEvent( "LogoutEvent", "LogoutEventTag", onAddEvent )

end

local function getMeFunction()
	coronium:getMe()
	coronium:addEvent( "getMeEvent", "getMeEventTag", onAddEvent )
end

local register = display.newText("Register", 100, 100, nil, 24)
local login = display.newText("Login", 100, 200, nil, 24)
local logout = display.newText("Logout", 100, 300, nil, 24)
local getMe = display.newText("Get Me", 100, 400, nil, 24)

register:addEventListener( "tap",registerUserFunction )
login:addEventListener( "tap",loginUserFunction )
logout:addEventListener( "tap",logoutUserFunction )
getMe:addEventListener( "tap",getMeFunction )
emailBox:addEventListener( "userInput", emailListener )

