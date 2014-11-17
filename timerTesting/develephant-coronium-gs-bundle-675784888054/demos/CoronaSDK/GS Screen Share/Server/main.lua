--======================================================================--
--== Coronium GS
--======================================================================--
local gs = require( 'CoroniumGS' ):new( 7173, 'abc' )
--======================================================================--
--== Game Code
--======================================================================--

--== Game Code Goes Here

--======================================================================--
--== Game Events
--======================================================================--
local function onGameCreate( game )
	p( "--== Game Created ==--" )
	p( game:getId() )

	game:setData( { control_player_num = 1 } )
end

local function onGameJoin( game, player )
	p( "--== Game Joined ==--" )
	p( game:getId(), player:getId() )
end

local function onGameStart( game, players )
	p( "--== New Game Started " .. game:getId() .. " ==--" )
	p( "Games", gs:getGameCount() )

	game:publishGameData()
end

local function onGameLeave( game, player )
	p( "--== Game Leave ==--" )
	p( game:getId(), player:getId() )
end

local function onGameClose( game_id )
	p( "--== Game Closed ==--" )
	p( game_id )
end
--======================================================================--
--== Client Events
--======================================================================--
local function onClientData( client, data )
	if data.pos then
		local game = gs:getPlayerGame( client )
		local player = game:getPlayerByNumber( 2 )
		if player then
			player:send( data )
		end
	end
end

local function onClientConnect( client )
	p( '--== Client Connected ==--' )
	p( client:getHost() )
end

local function onClientClose( client )
	p( '--== Client Closed ==--' )
end

local function onClientTimeout( client )
	p( '--== Client Timeout ==--' )
	p( client:getHost()  )
end

local function onClientError( client, error )
	p( '--== Client Error ==--' )
	p( error )
end
--======================================================================--
--== GameManager Handlers
--======================================================================--
gs:on( "GameStart", onGameStart )
gs:on( "GameCreate", onGameCreate )
gs:on( "GameJoin", onGameJoin )
gs:on( "GameLeave", onGameLeave )
gs:on( "GameClose", onGameClose )
--======================================================================--
--== Client Handlers
--======================================================================--
gs:on( "ClientConnect", onClientConnect )
gs:on( "ClientData", onClientData )
gs:on( "ClientError", onClientError )
gs:on( "ClientClose", onClientClose )
gs:on( "ClientTimeout", onClientTimeout )
