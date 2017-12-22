# ESP8266-MQTT-RF
An ESP8266 MQTT switch for power sockets

## What is it?
This software is a gateway to interface between wifi and 433MHz remote controlled power sockets using an ESP8266 and cheap chinese 433MHz transmitters

## How to start?
Flash the precompiled binary from bin to your ESP8266. Then use ESPlorer to upload the lua files

## How to configure?
* The ESP8266 will start an Access Point if it can't connect to a known network. Connect to this AP and open 192.168.4.1 in your webbrowser. You will be able to configure your network
* You will need to do some configuration in config.lua.
  * Set pin to the pin of your transmitter
  * Set the MQTT server and base topic

## How to use?
If you don't change the base topic, you can switch your sockets like this:

* To switch common sockets (A Sockets) with house code 9 and unit code 16:
  Topic: `rc/A/9/16`
  Message: `on` `off`
* To switch any socket you know the protocol of:
  Topic: `rc/protocotl_id/pulse_length/repeat/length`
  Message: Your data

## I don't want to setup a MQTT server!
Bad! You might use test servers like test.mosquitto.org. BUT: Anybody would be able to switch your sockets

## Disclaimer
Please make shure not to plug in any devices that are not meant to run unattended. Imagine your neighbor has the same house/unit code and accidently switches your devices (like a heater). Please be careful
