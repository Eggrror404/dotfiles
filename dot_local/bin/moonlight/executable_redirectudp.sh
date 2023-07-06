#!/bin/bash

#complementary script for the moonlightssh script. Run it on the ssh server.

#sudo apt install socat

#IP of the Gaming rig
sip=192.168.1.115

socat tcp4-listen:48998,reuseaddr,fork udp:$sip:47998 &
socat tcp4-listen:48999,reuseaddr,fork udp:$sip:47999 &
socat tcp4-listen:49000,reuseaddr,fork udp:$sip:48000 &
socat tcp4-listen:49002,reuseaddr,fork udp:$sip:48002 &
socat tcp4-listen:49010,reuseaddr,fork udp:$sip:48010
