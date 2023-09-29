#!/bin/bash

# Separator
separator="---------------------------------"

# Function to display section headers
display_header() {
	echo "$separator"
	echo "$1:
"
}

# Function to gather and display system information
gather_and_display_info() {
	# Display section headers
	display_header "Current Date and Time"
	date

	display_header "Hostname"
	hostname

	display_header "Distribution"
	cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2

	display_header "Kernel Version"
	uname -r

	display_header "CPU Information"
	lscpu | grep "Model name" | awk -F ': ' '{print $2}'

	display_header "uname -m"
	uname -m

	display_header "IP Address"
	hostname -i | awk '{print $1}'

	display_header "Memory Information"
	free -h | awk '/Mem:/ {print $2}'

	display_header "Disk Information"
	df -h / | awk 'NR==2 {print $2}'

	display_header "MAC Address"
	ip link show | awk '/ether/ {print $2}'

	display_header "Timezone"
	timedatectl show --property=Timezone --value

	display_header "Locale"
	locale

	display_header "Uptime"
	uptime

	display_header "lspci"
	lspci

	display_header "dmidecode -t system"
	sudo dmidecode -t system

	display_header "dmidecode -t processor"
	sudo dmidecode -t processor

	display_header "lshw -short"
	sudo lshw -short

	display_header "lsblk -a"
	lsblk -a

	display_header "lsusb"
	lsusb

	display_header "dmidecode"
	sudo dmidecode

	display_header "hostnamectl"
	hostnamectl

	display_header "proc/cpuinfo"
	cat /proc/cpuinfo

	display_header "ID"
	id

	display_header "ps -e"
	ps -e

	display_header "Sensors"
	sensors
}

# Call the function to gather and display system info
gather_and_display_info
