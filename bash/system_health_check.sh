#!/bin/bash
# System Health Check Script - Bash
# Author: Toni Bustos

timestamp=$(date '+%Y-%m-%d %H:%M:%S')
log_dir="/var/log/system_health"
log_file="$log_dir/system_health_log.txt"

mkdir -p "$log_dir"

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
mem_usage=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')
disk_usage=$(df -h / | awk 'NR==2 {print $5}')
uptime_info=$(uptime -p)
ping_status=$(ping -c 1 google.com &> /dev/null && echo "Connected" || echo "Disconnected")

echo "System Health Report - $timestamp" > "$log_file"
echo "------------------------------------------" >> "$log_file"
echo "CPU Usage: $cpu_usage" >> "$log_file"
echo "Memory Usage: $mem_usage%" >> "$log_file"
echo "Disk Usage (/): $disk_usage" >> "$log_file"
echo "System Uptime: $uptime_info" >> "$log_file"
echo "Network Status: $ping_status" >> "$log_file"

cat "$log_file"
