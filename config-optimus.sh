#!/bin/bash
if ! [ -d /opt/Systemd-Nvidia-Entry/ ]; then ## checks if the directory exist
	mkdir /opt/Systemd-Nvidia-Entry/ -p ## if it doesn't exist, here it's created
fi

modprobe bbswitch ## starting bbswitch

if ! [[ `lsmod | grep nvidia` != "" ]]; then ## Nvidia
	if ! [[ -e /etc/X11/xorg.conf.d/00-ldm.conf ]]; then
		cp /opt/Systemd-Nvidia-Entry/00-ldm.conf /etc/X11/xorg.conf.d/00-ldm.conf -f
	fi
else ## Intel
    echo 'auto' > '/sys/bus/pci/devices/0000:01:00.0/power/control'; # Manually disable nvidia card.
	if [[ -e /etc/X11/xorg.conf.d/00-ldm.conf ]]; then
		mv /etc/X11/xorg.conf.d/00-ldm.conf /opt/Systemd-Nvidia-Entry/00-ldm.conf -f
	fi
fi