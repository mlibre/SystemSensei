#!/bin/bash

# Separator
separator="---------------------------------"

# Function to display section headers
display_header() {
	echo "$separator"
	echo "### $1 ###
"
}

# Function to gather and display CPU Information
gather_and_display_cpu_info() {
	display_header "CPU Information"
	architecture=$(lscpu | grep "Architecture" | awk -F ': ' '{print $2}')
	model_name=$(lscpu | grep "Model name" | awk -F ': ' '{print $2}')
	cores_per_socket=$(lscpu | grep "Core(s) per socket" | awk -F ': ' '{print $2}')
	cpu_max_mhz=$(lscpu | grep "CPU max MHz" | awk -F ': ' '{print $2}')

	echo "Architecture: $architecture"
	echo "Model name: $model_name"
	echo "Core(s) per socket: $cores_per_socket"
	echo "CPU max MHz: $cpu_max_mhz"
}

# Function to gather and display Distribution Information
gather_and_display_distribution_info() {
	display_header "Distribution Information"
	DISTRIB_ID=$(grep DISTRIB_ID /etc/*-release | cut -d'=' -f2)
	DISTRIB_RELEASE=$(grep DISTRIB_RELEASE /etc/*-release | cut -d'=' -f2)
	PRETTY_NAME=$(grep PRETTY_NAME /etc/*-release | cut -d'"' -f2)

	echo "ID: $DISTRIB_ID"
	echo "Release: $DISTRIB_RELEASE"
	echo "Name: $PRETTY_NAME"
}

show_ip_addresses() {
	display_header "System's IP Address"
	ip -o addr show | awk '{print $2, $4}' | sed 's/\/[0-9]*//' | column -t -s ' '
}

# Function to gather and display Memory Information
gather_and_display_memory_info() {
	display_header "Memory Information"
	total_memory=$(free -h | awk '/Mem:/ {print $2}')
	used_memory=$(free -h | awk '/Mem:/ {print $3}')

	echo "Total: $total_memory"
	echo "Used: $used_memory"
}

# Function to gather and display system information
gather_and_display_info() {
	# Display section headers
	display_header "Current Date and Time"
	date "+%Y-%m-%d %T %Z"

	display_header "Timezone"
	timedatectl show --property=Timezone --value

	display_header "Hostname"
	hostname

	gather_and_display_distribution_info

	display_header "Kernel Version"
	uname -r

	display_header "Kernel Architecture"
	uname -m

	show_ip_addresses

	display_header "MAC Address"
	ip link show | awk '/ether/ {print $2}'

	gather_and_display_cpu_info

	gather_and_display_memory_info

	display_header "Disk Information"
	df -h

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
