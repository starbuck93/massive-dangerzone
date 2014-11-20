-- Collect incoming data
local in_data = coronium.input()

-- local answer = coronium.mongo:createObject( "times", { startTime = in_data.startTime } )
local answer = coronium.mongo:getObject( "times", in_data.objectid ) 

coronium.output( answer )
