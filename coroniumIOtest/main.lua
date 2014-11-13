--coronium testing

local globals = require( "globals" )
local coronium = require( "mod_coronium" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
globals.coronium = coronium


coronium.showStatus = true
--coronium:run("hello")

local function registerUserFunction( )
--== login the user ==--
coronium:registerUser({ 
  email = "a",
  password = "a"
} )
end

local function loginUserFunction( )
coronium:loginUser({ 
  email = "a",
  password = "b"
} )
end

local register = display.newText("Register", 100, 100, nil, 24)
local login = display.newText("Login", 100, 200, nil, 24)

register:addEventListener( "tap",registerUserFunction )
login:addEventListener( "tap",loginUserFunction )