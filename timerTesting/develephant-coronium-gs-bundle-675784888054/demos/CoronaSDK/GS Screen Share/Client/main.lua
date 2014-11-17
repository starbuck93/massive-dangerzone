--======================================================================--
--== Coronium GS Client
--======================================================================--
local gs = require( 'gs.CoroniumGSClient' ):new()
local p = gs.p --== Pretty Printer

local client_is_controller = false
--======================================================================--
--== Game Code
--======================================================================--

local buffy = {}
local buffy_max = 5
local function addToBuffer( x, y )

	table.insert( buffy, { x = x, y = y } )

	if #buffy >= buffy_max then
		--==flush it
		local pop = buffy[ #buffy ]
		gs:send( { pos = 1, x = pop.x, y = pop.y } )
		buffy = {}
	end

end

-- create object
local myObject = display.newCircle( 0, 0, 40, 40 )
myObject:setFillColor( 67/255 )
myObject.x = display.contentCenterX
myObject.y = display.contentCenterY
 
-- touch listener function
function myObject:touch( event )
    if event.phase == "began" then
	
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	
    elseif event.phase == "moved" then
	
        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY
        
        self.x, self.y = x, y    -- move object based on calculations above

        addToBuffer( self.x, self.y )

    end
    
    return true
end

--======================================================================--
--== Game Events
--======================================================================--
function onGameCreate( event )
	p( event.data )
end

function onGameJoin( event )
	p( event.data )
end

function onGameCancel( event )

end

function onGameStart( event )
	p( "game started" )
	p( event.data )
end

function onGameData( event )
	p( "gd" )
	p( event.data )

	--shared
	if gs:getPlayerNum() == event.data.control_player_num then
		client_is_controller = true
		myObject:addEventListener( "touch", myObject )
	end
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
	if not client_is_controller then
		if event.data.pos then
			myObject.x, myObject.y = event.data.x, event.data.y
		end
	end
end

local function onClientConnect( event )
	p( "client connected" )

	--== For demo player 1
	gs:createGame( 2 )
	--== For demo player 2
	--gs:joinGame( 2 )

	p( gs:isConnected() )
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
gs.events:on( "GameJoin", onGameJoin )
gs.events:on( "GameCancel", onGameCancel )
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
	host = 'ping.coronium.gs',
	port = 7173,
	key = 'abc',
	ping = true
}
gs:connect( connection )