enduser_setup.start(
  function()
    tmr.alarm(1,1000, 1, function() if wifi.sta.getip()==nil then print(" Wait for IP address!") else print("New IP address is "..wifi.sta.getip()) tmr.stop(1) end end)
    dofile("mqtt.lua")
  end,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end,
  print -- Lua print function can serve as the debug callback
);

wifi_check = tmr.create()
wifi_check:register(600000, tmr.ALARM_AUTO, function()
    if (wifi.sta.status() ~= wifi.STA_GOTIP) then
        node.restart()
    end
end)

wifi_check:start()