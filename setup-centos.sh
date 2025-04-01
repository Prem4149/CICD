#!/bin/bash

echo "========== System Health Check =========="

# Check OS version
echo -e "\n🖥️ OS Version:"
cat /etc/os-release

# Check system uptime
echo -e "\n⏳ Uptime:"
uptime

# Check disk usage
echo -e "\n💾 Disk Usage:"
df -h

# Check memory usage
echo -e "\n🧠 Memory Usage:"
free -m

# Check CPU load
echo -e "\n⚡ CPU Load:"
top -bn1 | grep "load average"

# Check running services
echo -e "\n📌 Active Services:"
systemctl list-units --type=service --state=running | head -20

# Check network status
echo -e "\n🌐 Network Information:"
ip a | grep inet

echo -e "\n✅ System Check Completed!"
