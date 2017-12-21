dofile("rc.lua")
dofile("config.lua")

m = mqtt.Client("clientid", 120)

m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") node.restart() end)

-- on publish message receive event
m:on("message", function(client, topic_raw, data) 
  if data ~= nil then
    print(data)
    client:publish("rc_res", data, 0, 0)

    i = 0
    index_start = 0
    topic = {}
    for data_segment in string.gmatch(topic_raw, "[^/]+") do
       if (data_segment == "rc") then
         index_start = i
       end
       topic[i] = data_segment
       i = i + 1
    end

    print(topic[index_start + 1])
    if (topic[index_start + 1] == "A") then --A Type power socket
        print(topic[index_start + 2])
        print(topic[index_start + 3])
        if (data == "on") then
            switchOnA(topic[index_start + 2], topic[index_start + 3])
        elseif (data == "off") then
            print("off")
            switchOffA(topic[index_start + 2], topic[index_start + 3])
        end
    elseif (topic[index_start + 1] == "custom") then --Custom RC Switch data
        --Format: /protocotl_id/pulse_length/repeat/length
        data_decoded = sjson.decode(data)
        rfswitch.send(data_decoded["protocol_id"], data_decoded["pulse_length"], data_decoded["repeat"], PIN, data_decoded["value"], data_decoded["length"])
    end

  end
end)

-- for TLS: m:connect("192.168.11.118", secure-port, 1)
m:connect(SERVER, 1883, 0, function(client)
  print("MQTT connected")
  client:publish("rc_res", "rc_connected", 0, 0)
  client:lwt("rc_res", "rc_disconnected")
  client:subscribe(BASE_TOPIC .. "rc/#", 0, function(client) print("subscribe success") end)
end,
function(client, reason)
  print("failed reason: " .. reason)
  node.restart()
end)

mqtt_check = tmr.create()
mqtt_check:register(600000, tmr.ALARM_AUTO, function()
    if (not client:publish("rc_res", "rc_connected", 0, 0)) then
        print("MQTT error -> Restart")
        node.restart()
    end
end)

--m:close();
