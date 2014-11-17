--======================================================================--
--== Coronium GS Client
--======================================================================--
local gs = require( 'gs.CoroniumGSClient' ):new()
local p = gs.p --== Pretty Printer
--======================================================================--
--== Game Code
--======================================================================--

local minutes = ""
local seconds = ""

local ti = display.newText("Time remaining:", 300, 100, nil, 40)
ti.text = "Time remaining: " .. minutes .. ":" .. seconds


--======================================================================--
--== Game Events
--======================================================================--
function onGameCreate( event )
	p( event.data )
end

function onGameCancel( event )
	p( event.data )
end

function onGameJoin( event )
	p( event.data )
end

function onGameStart( event )
	p( "game started" )
end

function onGameData( event )
	p( event.data )
end

function onGameLeave( event )
	p( event.data )
end

function onGameDone()
	p( 'Game Done' )
end

--======================================================================--
--== Client Events
--======================================================================--
local function onClientData( event )
	p( event.data )
end

local function onClientConnect( event )
	p( "client connected" )

	gs:createGame( 1 )
end

local function onClientClose( event )
	p( "client closed" )
end

local function onClientPing( event )
	p( "timestamp: " .. event.data )
end

function onClientError( event )
	p( "error: " .. event.data )
end
--======================================================================--
--== Game Handlers
--======================================================================--
gs.events:on( "GameCreate", onGameCreate )
gs.events:on( "GameCancel", onGameCancel )
gs.events:on( "GameJoin", onGameJoin )
gs.events:on( "GameStart", onGameStart )
gs.events:on( "GameData", onGameData )
gs.events:on( "GameLeave", onGameLeave )
gs.events:on( "GameDone", onGameDone )
--======================================================================--
--== Client Handlers
--======================================================================--
gs.events:on( "ClientData", onClientData )
gs.events:on( "ClientConnect", onClientConnect )
gs.events:on( "ClientClose", onClientClose )
gs.events:on( "ClientPing", onClientPing )
gs.events:on( "ClientError", onClientError )
--======================================================================--
--== Server Connection
--======================================================================--
local connection =
{
	host = '104.236.30.203',
	port = 7173,
	handle = "nerfApp",
	key = 'adam',
	ping = true
}
gs:connect( connection )