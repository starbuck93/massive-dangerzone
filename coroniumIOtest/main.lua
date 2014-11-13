--coronium testing

local globals = require( "globals" )
local coronium = require( "mod_coronium" )
local mime = require("mime")

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
globals.coronium = coronium


coronium.showStatus = true
--coronium:run("hello")

--== Register user callback ==--
local function onloginUser( e )
  print( e.result )
end
--== Register the user ==--
coronium:loginUser({ 
  email = "me.starbuck@gmail.com", --REQUIRED
  password = "2468", --REQUIRED
}, onloginUser )

local function onLink( e )
  print( e.result )
end

coronium:linkUserDevice(
	{deviceToken = 1234123412341234,
	addToPushBots = false	},
	onLink )