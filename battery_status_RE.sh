#!/bin/sh
i2cset -f -y 1 0x6b 0x00 0x17
i2cset -f -y 1 0x6b 0x02 0x85
i2cset -f -y 1 0x6b 0x03 0x11
i2cset -f -y 1 0x6b 0x05 0x8f
while [ 1 ];
do
	val=$(i2cget -f -y 1 0x6b 0x08)
	echo "Battery----- Register Value $val"
	if [ "$val" = "0x65" ]
	then
        echo "Battery is not connected.External power is used for Board "
	elif [ "$val" = "0x7c" ]
	then
        echo "Battery Fully Charged"
	elif [ "$val" = "0x74" ]
	then
        echo " Battery is charging "
	elif [ "$val" = "0x00" ]
	then
        echo " Battery Not Charging"
	else
        echo "Unstable State "
	fi
	sleep 1
done
