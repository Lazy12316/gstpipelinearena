#!/bin/sh

SOURCE="filesrc location=\"samples/wb_male.wav\" ! decodebin ! audioconvert "
ENCODER="vorbisenc"
PAYLOADER="rtpvorbispay"
DESTINATION="port=6969 host=127.0.0.1"

#gst-launch -tv \
#	$SOURCE ! $ENCODER ! \
#	$PAYLOADER ! udpsink $DESTINATION

# NE MARCHE PAS
# NECESSITE LE PASSAGE DU CAPS COTE CLIENT
gst-launch -tv \
	gstrtpbin name=rtpbin latency=100 buffer-mode=0 \
		$SOURCE \
		! queue ! $ENCODER ! $PAYLOADER \
		! rtpbin.send_rtp_sink_1 \
			rtpbin.send_rtp_src_1 ! udpsink $DESTINATION

