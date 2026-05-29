#!/bin/bash

# 恢复系统
gzip -dc /vol2/1000/Storage/Backup/fnOS-img/emmc_backup.img.gz | sudo dd of=/dev/mmcblk1 bs=4M status=progress conv=fsync
