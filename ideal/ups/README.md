## A DIY UPS to prevent the HAT rebooting the computer

In some applications, it is important that the Pi continues to be powered in the event of a power outage. If something is written on the SD card at the moment of power interruption, it is possible that the image will become corrupt and thus unusable.
A UPS (Uninterruptible Power Supply) ensures that if a power interruption occurs, a battery/another power source will intervene without affecting the unit.

Such an UPS can be easily created with a few components and in a case of emergency a script will respond to it and shut down the Pi properly.

![ups](/ideal/ups/diy-ups.png)

Two USB ports of the hub are required. At the first, the power bank is connected, which will serve the Pi as a power source. The second USB port is used as the on/off switch for the relay. I simply clamped the cables that control the relay under the brackets. On the right side, you can see where 5V and GND are connected to a USB port.

The middle OUT pin of the relay comes to GPIO27 (pin 13) of the Pi. The right OUT pin is connected to pin 2 (5V) of the Pi via a 10kΩ resistor and pin 6 (GND) to the right.

 
### Software

Suppose there comes to a power failure. For one thing, the Pi would still run for a few hours (depending on the power bank model). But then it would be over. In order for the Pi to be informed that it is currently running on “emergency power”, the relay switches at and on GPIO23 are now 0V. Before that, there was a high level because the USB hub power supply also had the relay open.

In my example, I want to show how to respond to the change and shut down the Pi properly. Of course, other actions can be performed (send email, save data, drive down after a while, etc.).

For this example, you need to have wiringPi installed (a similar implementation with Python should certainly be possible). The wiringPi pin 2 corresponds to GPIO27 (see wiringPi pin assignment).

```bash
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
```

Instead of my code, any other shell command can be entered.

So that the script now also starts with each reboot, we enter it as crontab:

`sudo crontab -e`

The following line will be added at the end of the file:

`@reboot bash /usr/local/etc/USV.sh &`

 The Powerbank model I use shuts off its charge as soon as it’s full. If interested, I can also present a circuit, which allows you to recharge the power bank every X hours (which is basically just an additional relay). For that, you can also read this article if necessary.