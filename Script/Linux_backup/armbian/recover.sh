#!/bin/bash

# 恢复系统
gzip -dc /mnt/backup/emmc_backup.img.gz | sudo dd of=/dev/mmcblk2 bs=4M status=progress conv=fsync

