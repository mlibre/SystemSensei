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

	processor_info=$(sudo dmidecode -t processor | grep -E "Manufacturer|Thread Count" | awk -F ': ' '{print $1 ": " $2}' | sed 's/^[ \t]*//')

	echo "$processor_info"
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

# Function to display top 10 processes by CPU usage
display_top_cpu_processes() {
	display_header "Top 10 Processes by CPU Usage"
	ps aux --sort=-%cpu | head -11
}

# Function to display top 10 processes by memory usage
display_top_memory_processes() {
	display_header "Top 10 Processes by Memory Usage"
	ps aux --sort=-%mem | head -11
}

# Function to display boot error logs
display_boot_error_logs() {
	display_header "Boot Error Logs"

	# Display boot error logs from the systemd journal
	journalctl -b -p err
}

gather_and_display_dns_info() {
	display_header "DNS Information"

	# Display DNS server information
	resolvectl
}

# Function to gather and display system information
gather_and_display_info() {
	# Display section headers
	display_header "Current Date and Time"
	date "+%Y-%m-%d %T %Z"

	display_header "Timezone"
	timedatectl show --property=Timezone --value

	display_header "Locale"
	locale

	display_header "Uptime"
	uptime

	display_header "Hostname"
	hostname

	display_header "hostnamectl"
	hostnamectl

	display_header "User Information"
	id

	gather_and_display_distribution_info

	display_header "Kernel Version"
	uname -r

	display_header "Kernel Architecture"
	uname -m

	show_ip_addresses

	gather_and_display_dns_info

	display_header "MAC Address"
	ip link show | awk '/ether/ {print $2}'

	gather_and_display_cpu_info

	gather_and_display_memory_info

	display_header "Disk Information"
	df -h

	display_header "lsblk -a"
	lsblk -a

	display_header "lsusb"
	lsusb

	display_header "System PCI devices"
	lspci

	display_header "lshw -short"
	sudo lshw -short

	display_top_cpu_processes
	display_top_memory_processes

	display_header "Sensors"
	sensors

	display_boot_error_logs
}

# Call the function to gather and display system info
gather_and_display_info
