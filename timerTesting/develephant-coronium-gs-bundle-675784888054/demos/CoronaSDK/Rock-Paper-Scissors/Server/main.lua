--======================================================================--
--== Coronium GS
--======================================================================--
local gs = require( 'CoroniumGS' ):new( 7173, 'abc', true )

local timer = require( 'timer' )
local table = require( 'table' )
--======================================================================--
--== Game Code
--======================================================================--
local ATTACK =
{
	ROCK = 1,
	PAPER = 2,
	SCISSOR = 3
}
--======================================================================--
--== Player server stats
--======================================================================--
local function sendClientCount( to_client )

	local send = false

	--======================================================================--
	--== GS - Get clients
	--======================================================================--
	local clients = gs:getClients()

	local in_game = 0
	local out_game = 0
	local total = 0

	local to_clients = {}
	
	for _, client in pairs( clients ) do
		--======================================================================--
		--== GS - Count clients in/out of game
		--======================================================================--
		if client:isInGame() then
			in_game = in_game + 1
		else
			out_game = out_game + 1
			table.insert( to_clients, client )
		end
		send = true
	end

	if send then
		--======================================================================--
		--== GS - Send game data to client/clients
		--======================================================================--
		local msg_tbl = { client_cnt = 1, in_game = in_game, total = ( in_game + out_game ) }
		if not to_client then
			for i=1, #to_clients do
				to_clients[i]:send( msg_tbl )
			end
		else
			to_client:send( msg_tbl )
		end
	end
end

--======================================================================--
--== Game creation
--======================================================================--
local function checkCreateGame( client )
	--======================================================================--
	--== GS - Get the 'open' game count
	--======================================================================--
	local game_count = gs:getGameCount( { game_state = 'open' } )

	if game_count == 0 then
		--======================================================================--
		--== GS - Create a new game
		--======================================================================--
		gs:createGame( client, 2 )
	else
		--======================================================================--
		--== GS - Add to game queue
		--======================================================================--
		gs:addToGameQueue( client, 2 )
	end

	sendClientCount()
end

--======================================================================--
--== Update game
--======================================================================--
local function checkGameStatus( game )
	
	--======================================================================--
	--== GS - Get current game data
	--======================================================================--
	local p1a = game.data.p1_choice
	local p2a = game.data.p2_choice

	local result = -1 --== need both choices still

	if p1a > 0 and p2a > 0 then
		if p1a == ATTACK.ROCK then
			if p2a == ATTACK.PAPER then
				result = 2
			elseif p2a == ATTACK.SCISSOR then
				result = 1
			else --== tied ROCK
				result = 0
			end
		elseif p1a == ATTACK.PAPER then
			if p2a == ATTACK.ROCK then
				result = 1
			elseif p2a == ATTACK.SCISSOR then
				result = 2
			else --== tied PAPER
				result = 0
			end
		elseif p1a == ATTACK.SCISSOR then
			if p2a == ATTACK.PAPER then
				result = 1
			elseif p2a == ATTACK.ROCK then
				result = 2
			else --== tied SCISSOR
				result = 0
			end
		end
	end

	if result ~= -1 then

		local winner = 0 --tied
		if result > 0 then
			--======================================================================--
			--== GS - Setting game data
			--======================================================================--
			game.data["p" .. result .. "_wins"] = game.data["p" .. result .. "_wins"] + 1
			winner = result
		end

		game.data.round = game.data.round + 1

		game.data.p1_choice = 0
		game.data.p2_choice = 0

		--======================================================================--
		--== GS - Broadcast to all players in this game instance
		--======================================================================--
		game:broadcast( { winner = winner, p1 = p1a, p2 = p2a } )

		timer.setTimeout( 3000, function()
			if game.data.round < 3 then
				--======================================================================--
				--== GS - Broadcast to all players in this game instance
				--======================================================================--
				game:broadcast( { choose_attack = 1 } )
			else
				--======================================================================--
				--== GS - Check the players game data
				--======================================================================--
				local msg = ""
				if game.data.p1_wins > game.data.p2_wins then
					msg = "Player 1 Wins The Game!"
				elseif game.data.p1_wins < game.data.p2_wins then
					msg = "Player 2 Wins The Game!"
				else
					msg = "The Game Was A Draw!"
				end
				--======================================================================--
				--== GS - Send a 'game done' event
				--======================================================================--
				game:publishGameDone( msg )
				--======================================================================--
				--== GS - Mark the game instance for gc
				--======================================================================--
				game:close()
			end
		end)
	end

end

--======================================================================--
--== Game Events
--======================================================================--
local function onGameCreate( game )
	-- rock > scissors > paper >
	--======================================================================--
	--== GS - Set the inital game instance data
	--======================================================================--
	game:setData({
		p1_choice = 0,
		p2_choice = 0,
		p1_wins = 0,
		p2_wins = 0,
		round = 0
	})
end

local function onGameJoin( game, player )
	sendClientCount()
end

local function onGameStart( game, players )
	p( "--== New Game Started " .. game:getId() .. " ==--" )
	--======================================================================--
	--== GS - Broadcast to all players in this game instance
	--======================================================================--
	game:broadcast( { choose_attack = 1 } )
end

local function onGameLeave( game, player )
	--======================================================================--
	--== GS - Broadcast to all players in this game instance
	--======================================================================--
	game:broadcast( { player_left = 1, player_name = player:getPlayerHandle() } )
	--======================================================================--
	--== GS - Mark game instance for gc
	--======================================================================--
	game:close()
end

local function onGameClose( game_id )
	p( "--== Game Closed " .. game_id .. " ==--" )
	sendClientCount()
end
--======================================================================--
--== Client Events
--======================================================================--
local function onClientData( client, data )

	--======================================================================--
	--== Ready to play
	--======================================================================--
	if data.ready_to_play then
		checkCreateGame( client )
	--======================================================================--
	--== Client count stats
	--======================================================================--
	elseif data.get_client_cnt then
		sendClientCount( client )
	--======================================================================--
	--== Lobby chat
	--======================================================================--
	elseif data.lobby_chat then
		--======================================================================--
		--== GS - Broadcast to all players (lobby)
		--======================================================================--
		gs:broadcast( data )
	--======================================================================--
	--== Game chat
	--======================================================================--
	elseif data.game_chat then
		--======================================================================--
		--== GS - Get the players game instance
		--======================================================================--
		local game = gs:getPlayerGame( client )
		if game then
 			--======================================================================--
 			--== GS - Broadcast to all players in this game instance
 			--======================================================================--
			game:broadcast( data )
		end
	--======================================================================--
	--== Attack choice
	--======================================================================--
	elseif data.use_attack then
		--======================================================================--
		--== GS - Get the players game instance
		--======================================================================--
		local game = gs:getPlayerGame( client )
		if game then
			--======================================================================--
			--== GS - Update the players game data
			--======================================================================--
			game.data["p" .. client:getPlayerNum() .. "_choice"] = data.use_attack

			checkGameStatus( game )
		end
	end
end

local function onClientConnect( client )

	sendClientCount()

	for _, c in pairs( gs:getClients() ) do
		--======================================================================--
		--== GS - Check if the client is still in the game
		--======================================================================--
		if not c:isInGame() then
			--======================================================================--
			--== GS - Send a direct message to this client
			--======================================================================--
			c:send( { lobby_chat = client:getPlayerHandle() .. " has entered!" } )
		end
	end

end

local function onClientClose( client )
	sendClientCount()
end

local function onClientTimeout( client )
	sendClientCount()
end

local function onClientError( client, error )
	sendClientCount()
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
