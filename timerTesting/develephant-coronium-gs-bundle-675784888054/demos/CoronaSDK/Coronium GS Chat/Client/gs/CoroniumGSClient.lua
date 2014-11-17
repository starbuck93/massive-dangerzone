--======================================================================--
--== Coronium GS Client
--======================================================================--
require( 'gs.30logglobal' ) --== http://yonaba.github.io/30log/

local crypto = require( 'crypto' )
local socketlib = require( 'socket' )
local json = require( 'json' )
local utils = require( 'gs.utils' )

--== https://github.com/daveyang/EventDispatcher
local dispatcher = require( 'gs.EventDispatcher' )
--======================================================================--
--== GS Utils
--======================================================================--
local p = function( tbl )
	if tbl then
		if type( tbl ) == "table" then
			utils:printTable( tbl )
		else
			print( tbl )
		end
	end
end

local function line( str )
	if str:sub( ( #str - 1 ), #str ) == "\n" then
		return str
	end

	return str .. "\n"
end

local function uuid( index )
    --Object UUID generator
	local index = index or 0
	local salt = os.time() .. "coronium" .. ( math.random( os.time() ) + index )
	local genId = crypto.digest( crypto.md5, salt )
	local uuid = genId:sub( 1, 6 ) .. genId:sub( -4 )

	return uuid
end

---Coronium GS Client
-- @author Chris Byerley
-- @copyright 2014 develephant
-- @license 2-clause BSD
-- @module CoroniumGSClient
local CoroniumGSClient = class()

---Create a new game client instance.
-- @function new
-- @treturn Client The newly created client.
-- @usage local gs = require( 'gs.CoroniumGSClient' ):new()
function CoroniumGSClient:__init()

	--==Connections
	self.host = nil
	self.port = 7172

	--== Event dispatcher
	self.events = dispatcher()

	--== Timers
	self.process_timer = 0
	self.ping_timer = 0

	self.use_ping = false

	--== Client socket
	self.socket = nil
	self.socket_closed = true

	--== Connection Key
	self.connection_key = nil

	--== Game
	self.game_id = 0
	self.game_players_info = {} --==from server


	--== Player
	self.player_num = 0
	self.player_handle = nil
	self.player_data = nil

end

---Pretty print table data.
-- @tparam table tbl The table data to print.
-- @usage gs.p( some_table_data )
function CoroniumGSClient.p( tbl )
	p( tbl )
end

--======================================================================--
--== Code
--======================================================================--

---Send table data to the server.
-- @tparam table data_tbl A table of data to send.
-- @usage gs:send( { move_done = 1 } )
function CoroniumGSClient:send( data_tbl )
	self.socket:send( line( json.encode( data_tbl ) ) )
end

---Connect to a listening game server instance.
-- @param connection_table See @{connection_table}
function CoroniumGSClient:connect( connection_table )

	self.host = connection_table.host or nil
	self.port = connection_table.port or 7173

	self.player_handle = connection_table.handle or nil
	self.player_data = connection_table.data or nil

	--== Key to pair with Server
	self.connection_key = connection_table.key or 'abc'
	self.use_ping = connection_table.ping or false

	p( "connecting to " .. self.host )

	--== Initial clean up
	if self.socket then
	 self.socket:close()
	 self.socket = nil
	end

	--== Init socket
	self.socket = socketlib.tcp()

	--== Connect to server
	local success, msg = self.socket:connect( self.host, self.port )

	if success then

		self.socket_closed = false

		self.client_id = uuid( os.time() )

		self.socket:settimeout( 0 )
		self.socket:setoption( "tcp-nodelay", true )

		--== Socket connection event
		self.events:emit( { name = "SocketConnect", data = "connected" } )

		--== Pingu functionality
		if self.use_ping then
			self:_startPingu()
		end

		local function tick()

			local input, _ = socketlib.select( { self.socket }, nil, 0 )

			for _, client in ipairs( input ) do

				local data, err, partial = client:receive('*l')

				if not err then --== Incoming data

					local data = json.decode( data )
					--======================================================================--
					--== Handshake
					--======================================================================--
					if data._handshake then
						self:send( { _handshook = 1, key = self.connection_key, handle = self.player_handle, data = self.player_data  } )
					--======================================================================--
					--== Client Confirmed
					--======================================================================--
					elseif data._client_confirmed then
						self.events:emit( { name = "ClientConnect", data = "connected" } )
					--======================================================================--
					--== Pong
					--======================================================================--
					elseif data._pong then --== Pongu
						self.events:emit( { name = "ClientPing", data = data.ts } )
					--======================================================================--
					--== Game Create
					--======================================================================--
					elseif data._game_create then
						self.events:emit( { name = "GameCreate", data = data } )
					--======================================================================--
					--== Game Start
					--======================================================================--
					elseif data._game_start then
						self.player_num = data.player_num
						self.player_handle = data.player_handle
						self.game_id = data.game_id
						self.events:emit( { name = "GameStart", data = data } )
					--======================================================================--
					--== Game Join
					--======================================================================--
					elseif data._game_join then
						self.events:emit( { name = "GameJoin", data = data } )
					--======================================================================--
					--== Game Leave
					--======================================================================--
					elseif data._game_leave then
						self.events:emit( { name = "GameLeave", data = data } )
					--======================================================================--
					--== Game Data
					--======================================================================--
					elseif data._game_data then
						self.events:emit( { name = "GameData", data = data } )
					--======================================================================--
					--== Game Closed
					--======================================================================--
					elseif data._game_done then
						self.events:emit( { name = "GameDone" } )
					--======================================================================--
					--== Game Players Meta
					--======================================================================--
					elseif data._players_info then
						self.game_players_info = data.info --== Cache it
					--======================================================================--
					--== Client Data
					--======================================================================--
					else
						self.events:emit( { name = "ClientData", data = data } )
					end
				else
					--======================================================================--
					--== Closed
					--======================================================================--
					if err == "closed" then
						self:disconnect()
					--======================================================================--
					--== Error
					--======================================================================--
					else
						self.events:emit( { name = "ClientError", data = err } )
						self:disconnect()
					end
				end
			end
		end

		--tick timer
		self.process_timer = timer.performWithDelay( 50, function() tick(); end, -1 ) -- -1

	else
		self.events:emit( { name = "ClientError", data = msg } )
	end
end

---The connection table used for the `connect` method.
-- A __key__ can be set on the server to help limit unwanted connections.
-- You must pass a matching key in the __key__ parameter to
-- successfully pair the client to the server.
-- By enabling the __ping__ parameter, you keep the client alive and connected.
-- This basically disables any client timeout settings on the server-side.
-- The __handle__ parameter can be used as a username, player name, or any other 
-- identifier.  Additional starting data can be sent as a simple table in
-- the __data__ parameter.  You can retrieve this data with the
-- __client:getPlayerData()__ method. See [Client](http://coronium.gs/server/modules/Client.html).
-- @field host string The host address.
-- @field[opt=7173] port int The host port.
-- @field[opt=server assigned] handle string String based identifier for the client.
-- @field[opt=nil] data table A simple starting data table for the client.
-- @field[opt='abc'] key string The server pairing key.
-- @field[opt=false] ping bool The ping flag.
-- @table connection_table
-- @usage local conn_tbl = 
-- {
--  host = 'ping.coronium.gs',
--  port = '7173',
--  handle = 'Chris',
--  data = { color = "blue", fun = "Yes!" },
--  key = 'abc',
--  ping = true
-- }
--gs:connect( conn_tbl )

---Create a fresh connection to the server.  Useful after
-- a game has ended and you want to reconnect.
-- @tparam[opt=3000] int reconnect_delay Milliseconds delay before reconnecting. 
-- @usage gs:reconnect( 5000 )
function CoroniumGSClient:reconnect( reconnect_delay )

	local reconnect_delay = reconnect_delay or 3000
	
	self:disconnect()

	timer.performWithDelay( reconnect_delay , function( e )
		local connection_table = 
		{
			host = self.host,
			port = self.port,
			handle = self.player_handle,
			data = self.player_data,
			key = self.connection_key,
			ping = self.use_ping
		}
		self:connect( connection_table )
	end )

end
--======================================================================--
--== Player / Game
--======================================================================--

--- Get current stored game data from server.
-- Returned as table via the `GameData` event.
-- @usage gs.events:on( "GameData", function( event )
--   gs.p( event.data.game_data )
-- end )
-- gs:getData()
function CoroniumGSClient:getData()
	self:send( { _game_data = 1 } )
end

--- Get the client players connection handle.
-- @treturn string The players handle.
-- @usage local player_handle = gs:getPlayerHandle()
function CoroniumGSClient:getPlayerHandle()
	return self.player_handle
end

---Get the client player position.
-- @treturn int The player position.
-- @usage local player_num = gs:getPlayerNum()
function CoroniumGSClient:getPlayerNum()
	return self.player_num
end

---Get the client game id.
-- @treturn string The current game ID.
-- @usage local game_id = gs:getGameId()
function CoroniumGSClient:getGameId()
	return self.game_id
end

---Get the game players info data table.
-- This method can only be called after the `GameCreate`
-- or `GameJoin` client-side event.
-- @treturn table A table of game players meta data.
-- @usage function onGameJoin( event )
--  local info_table = gs:getPlayersInfo()
--  for key, value in pairs( info_table ) do
--    p( value )
--  end
-- end
function CoroniumGSClient:getPlayersInfo()
	return self.game_players_info
end

---Check if the game is running and socket connected.
-- @treturn bool The current state as boolean.
-- @usage local state = gs:isGameRunning()
function CoroniumGSClient:isGameRunning()
	if ( self.socket_closed == false ) and ( self.game_id > 0) then
		return true
	end

	return false
end

---Closes the client connection.
-- @usage gs:disconnect()
function CoroniumGSClient:disconnect()
	timer.cancel( self.process_timer )
	if self.ping_timer then
		timer.cancel( self.ping_timer )
	end
	self.socket:close()
	self.socket_closed = true
	self.events:emit( { name = "ClientClose", data = "Player Left" } )
end
--======================================================================--
--== Games
--======================================================================--

--- Create a new game for other players to connect to.
-- You can only use this method after the `ClientConnect` client-side
-- event. Only call of `createGame` OR `joinGame` once in each client, not both.
-- @tparam int players_max The maximal amount players 
-- needed to start this game.
-- @tparam table game_criteria Special criteria to find game by.
-- @usage function onClientConnect( event )
--  gs:createGame( 2 ) --== Create a 2 player game.
-- end
function CoroniumGSClient:createGame( players_max, game_criteria )
	local players_max = players_max or 1
	self:send( { _create_game = 1, players_max = players_max, game_criteria = game_criteria or nil } )
end

--- Join a game that was created with a `createGame` method.
-- You can only use this method after the `ClientConnect`
-- client-side event. __Only call of `createGame` OR `joinGame` 
-- once in each client, not both__.
-- @usage function onClientConnect( event )
--  gs:joinGame( 2 ) --== Join a 2 player game.
-- end
-- @tparam int players_max Join a game with `players_max` players.
-- @tparam table game_criteria Special criteria to find game by.
function CoroniumGSClient:joinGame( players_max, game_criteria )
	local players_max = players_max or 1
	self:send( { _join_game = 1, players_max = players_max, game_criteria = game_criteria or nil } )
end
--======================================================================--
--== Pingu
--======================================================================--

--- Starting pinging the server.
-- @local
function CoroniumGSClient:_startPingu()
	self.ping_timer = timer.performWithDelay( 5000, function()
		self:send( { _ping = 1, ts = os.time() } )
	end, -1 )
end

--- Stop pinging the server.
-- @local
function CoroniumGSClient:_stopPingu()
	timer.cancel( self.ping_timer )
end
--======================================================================--
--== Return class
--======================================================================--

return CoroniumGSClient

--- Game Events.
-- You can listen for the following __Game__ events.
-- @section Events


--[[--
A game has been created.  __This event will only
be received by the client/player calling it__.
@field GameCreate
@usage
gs.events:on( "GameCreate", function( event )
	print( event.data )
end )
]]

--[[--
The game has started. All players present.
@field GameStart
@usage
gs.events:on( "GameStart", function( event )
	print( event.data )
end )
]]

--[[--
A player has joined the game.
@field GameJoin
@usage
gs.events:on( "GameJoin", function( event )
	print( event.data )
end )
]]

--[[--
A player has left the game.
@field GameLeave
@usage
gs.events:on( "GameLeave", function( event )
	print( event.data )
end )
]]

--[[--
The game is finished.  See the server-side call [publishGameDone](http://coronium.gs/server/modules/Game.html#publishGameDone) as well.
@field GameDone
@usage
gs.events:on( "GameDone", function( event )
	print( event.data )
end )
]]

--[[--
Game data has been received.
@field GameData
@usage
gs.events:on( "GameData", function( event )
	p( event.data.game_data )
end )
]]

--- Client Events.
-- You can listen for the following __Client__ events.
-- @section Events

--[[--
Incoming Client data.
@field ClientData
@usage
gs.events:on( "ClientData", function( event )
	print( event.data.some_table_key )
end )
]]

--[[--
Client has thrown an error.
@field ClientError
@usage
gs.events:on( "ClientError", function( event )
	print( "error: " .. event.data )
end )
]]

--[[--
Client has closed.
@field ClientClose
@usage
gs.events:on( "ClientClose", function( event )
	print( "client closed" )
end )
]]

--[[--
Client has connected to server.
@field ClientConnect
@usage
gs.events:on( "ClientConnect", function( event )
	print( "client connected" )
end )
]]

--[[--
Client has received a ping.
@field ClientPing
@usage
gs.events:on( "ClientPing", function( event )
	print( "timestamp: " .. event.data )
end )
]]

