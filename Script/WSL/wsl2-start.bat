# 初始化脚本，注意这是 Ubuntu 和你的发行版本对应
wsl -d Ubuntu -u root /etc/init.wsl
# 添加一个网卡
netsh interface ip add address "vEthernet (WSL)" 192.168.50.93 255.255.255.0