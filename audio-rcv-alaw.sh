#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, clock-rate=(int)8000, encoding-name=(string)PCMA, payload=(int)8"
SOURCE="port=6969 caps=\"$CAPS\""

DECODER="gstrtpjitterbuffer latency=200 drop-on-latency=true ! rtppcmadepay ! alawdec"

gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


