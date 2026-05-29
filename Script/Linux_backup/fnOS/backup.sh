#!/bin/bash

# 备份系统
dd if=/dev/mmcblk1 bs=4M status=progress | gzip > /vol2/1000/Storage/Backup/fnOS-img/emmc_backup.img.gz

# 添加计划任务
# crontab -e
# 0 4 * * 5 /vol2/1000/Storage/Backup/fnOS-img/backup.sh >> /vol2/1000/Storage/Backup/fnOS-img/backup.log 2>&1