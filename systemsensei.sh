#!/bin/bash

# Separator
separator="
---------------------------------"

# Function to gather system information
gather_system_info() {

	# Get the current date and time
	current_date=$(date)

	# Get the hostname
	hostname=$(hostname)

	# Get the Linux distribution and version
	distro=$(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)

	# Get the kernel version
	kernel=$(uname -r)

	# Get CPU information
	cpu_info=$(lscpu | grep "Model name" | awk -F ': ' '{print $2}')

	# Get total RAM
	total_ram=$(free -h | awk '/Mem:/ {print $2}')

	# Get total disk space
	total_disk=$(df -h / | awk 'NR==2 {print $2}')

	# Get IP address
	ip_address=$(hostname -i | awk '{print $1}')

	# Get lspci information
	lspci_info=$(lspci)

	# Get dmidecode information
	dmidecode_info=$(sudo dmidecode -t memory)

	uname_m=$(uname -m)
	lshw_short=$(sudo lshw -short)
	lsblk_a=$(lsblk -a)
	lsusb_info=$(lsusb)
	dmidecode_system=$(sudo dmidecode -t system)
	dmidecode_processor=$(sudo dmidecode -t processor)

	# Build the SYS_INFO variable with separators
	SYS_INFO="
System Information:
$separator
- Current Date and Time:

$current_date
$separator
- Hostname:

$hostname
$separator
- Distribution

$distro
$separator
- Kernel Version:

$kernel
$separator
- CPU Information:

$cpu_info
$separator
- Memory Information:

$total_ram
$separator
- Disk Information:

$total_disk
$separator
- IP Address:

$ip_address
$separator
- lspci:

$lspci_info
$separator
- dmidecode:

$dmidecode_info
$separator
- uname -m:

$uname_m
$separator
- lshw -short:

$lshw_short
$separator
- lsblk -a:

$lsblk_a
$separator
- lsusb:

$lsusb_info
$separator
- dmidecode -t system:

$dmidecode_system
$separator
- dmidecode -t processor:

$dmidecode_processor
$separator
"

	echo "$SYS_INFO"
}

# Call the function to gather system info
gather_system_info
