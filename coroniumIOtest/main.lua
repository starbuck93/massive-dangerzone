--coronium testing http://docs.coronium.io/client-users/

local globals = require( "globals" )
local coronium = require( "mod_coronium" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
globals.coronium = coronium



coronium.showStatus = true
--coronium:run("hello")

coronium:appOpened()

local objId = "d9cc1bf9e3"
local beginTime = "8:00PM"

local function onRunReturn( event )
    if not event.error then
      print("YAY")
    end
end

  print(os.date())

local function getTime( )
  coronium:run( "retrieveTime", { objectid = objId }, onRunReturn)
end


local function setTime( )
  coronium:run( "setTime", { startTime = beginTime })
  --then somehow set the objId here

end


local buttonSetTime = display.newText("Set Time",100,100,nil,30)
local buttonGetTime = display.newText("Get Time",100,200,nil,30)

buttonSetTime:addEventListener( "tap",setTime )
buttonGetTime:addEventListener( "tap",getTime )



-- local email = display.newText("email", 100, 500, nil, 24)


-- local function emailListener( event )

--     if ( event.phase == "began" ) then
-- 		native.setKeyboardFocus( emailBox )
--     elseif ( event.phase == "ended" or event.phase == "submitted" ) then
--     	email.text = event.target.text
--     	native.setKeyboardFocus( nil )
--     elseif ( event.phase == "editing" ) then
--     end
-- end

-- 	emailBox = native.newTextField( display.contentCenterX, display.contentCenterY, display.contentCenterX, 100)
-- 	emailBox.inputType = "email"
-- 	emailBox.size = "10"
-- 	emailBox.text = "Email"

-- native.setKeyboardFocus( emailBox )

-- local function onAddEvent( event )
--   if not event.error then
--     print( event.result )
--   end
-- end

-- local function registerUserFunction( )
-- --== login the user ==--
-- coronium:registerUser({ 
--   email = "adam",
--   password = "adam",
--   username = "adam"
-- } )
-- coronium:addEvent( "registerUEvent", "registerUEventTag", onAddEvent )
-- end

-- local function loginUserFunction( )
-- coronium:loginUser("adam","adam") --fixed this line right here !! it needed to not be in a table, as registering users is in a table
 
-- coronium:addEvent( "LoginEvent", "LoginEventTag", onAddEvent )


-- end

-- local function logoutUserFunction()
-- 	coronium:logoutUser()
-- 	coronium:addEvent( "LogoutEvent", "LogoutEventTag", onAddEvent )

-- end

-- local function getMeReturn(event)
--     print(event.objectId )
-- end

-- local function getMeFunction()
-- 	coronium:getMe(getMeReturn)
-- 	coronium:addEvent( "getMeEvent", "getMeEventTag", onAddEvent )
-- end

-- local function getUserFunction()
--   coronium:getUser("")
-- end

-- local register = display.newText("Register", 100, 100, nil, 24)
-- local login = display.newText("Login", 100, 200, nil, 24)
-- local logout = display.newText("Logout", 100, 300, nil, 24)
-- local getMe = display.newText("Get Me", 100, 400, nil, 24)
-- local getUser = display.newText("Get User", 300, 100, nil, 24)

-- register:addEventListener( "tap",registerUserFunction )
-- login:addEventListener( "tap",loginUserFunction )
-- logout:addEventListener( "tap",logoutUserFunction )
-- getMe:addEventListener( "tap",getMeFunction )
-- getUser:addEventListener( "tap",getUserFunction )
-- emailBox:addEventListener( "userInput", emailListener )

