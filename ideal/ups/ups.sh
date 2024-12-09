#!/bin/bash
 
gpio mode 2 in
 
while true
do
 
result="$( gpio read 2 )"
if [ "$result" = "1" ]; then
# Custom Code
 
# in 60 min shut down
sudo shutdown -h 60 &amp;
 
# Custom Code End
fi
sleep 1
done