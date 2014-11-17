local ti = display.newText("Time remaining:", 300, 100, nil, 50)


local time = 78
local function decreaseTime()
   time = time-1
   local seconds = time%60
   local minutes = math.floor(time / 60)
   if seconds < 10 then
   	seconds = "0" .. seconds
   end
   ti.text = "Time remaining: " .. minutes .. ":" .. seconds
end


timer.performWithDelay(1000,decreaseTime,time)