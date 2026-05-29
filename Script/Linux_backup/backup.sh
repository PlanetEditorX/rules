#!/bin/bash

# 定义备份文件名和路径（建议放在非系统分区）
BACKUP_DIR="/vol2/1000/Storage/Backup/fnOS-all"
BACKUP_DATE=$(date +%Y%m%d)
BACKUP_BASE="$BACKUP_DIR/$BACKUP_DATE"

# 确保备份目录存在
mkdir -p "$BACKUP_BASE"

# 静态排除的系统目录（必须排除的特殊目录）
STATIC_EXCLUDE=(
    "proc"
    "sys"
    "dev"
    "run"
    "tmp"
    "mnt"
    "media"
    "lost+found"
    "fs"
    "vol00"
    "vol02"
    "vol2"
    "vol3"
    "$BACKUP_DIR"  # 排除备份目录本身
)

# 需要排除的特定文件（支持通配符）
EXCLUDE_FILES=(
    "wget-log*"
    "*.log"
    "*.sock"
    "*/pipe"
)

# 排除参数
EXCLUDE_PARAMS=()
for FILE in "${EXCLUDE_FILES[@]}"; do
    EXCLUDE_PARAMS+=(--exclude="$FILE")
done

# 获取根目录下的文件夹（一级目录）
ROOT_FOLDERS=($(ls -l / | grep ^d | awk '{print $9}'))
echo ${ROOT_FOLDERS[@]}

# 遍历每个根目录文件夹
for DIR in "${ROOT_FOLDERS[@]}"; do
    # 跳过静态排除的目录
    EXCLUDE=0
    for EXCLUDED_DIR in "${STATIC_EXCLUDE[@]}"; do
        if [[ "$DIR" == "$EXCLUDED_DIR" ]]; then
            EXCLUDE=1
            break
        fi
    done

    if [[ $EXCLUDE -eq 1 ]]; then
        continue
    fi

    # 构建备份文件名
    BACKUP_FILE="$BACKUP_BASE/${DIR}.tar.gz"

    # 打印备份信息
    echo "Backing up /$DIR to $BACKUP_FILE"

    # 判断是否存在
    if [ -e $BACKUP_FILE ]; then
        echo "$BACKUP_FILE 文件存在，跳过备份"
    else
        # 执行备份
        tar -cvpzf "${BACKUP_FILE}" "${EXCLUDE_PARAMS[@]}" "/$DIR"

        # 检查结果
        if [ $? -eq 0 ]; then
            echo "Backup of /$DIR successful!"
        else
            echo "Backup of /$DIR failed!"
        fi
    fi
done

# # 打包所有备份文件到一个压缩文件
# echo "Packing individual backups into a single archive..."
# TAR_FILE="$BACKUP_DIR/system_backup_$BACKUP_DATE.tar.gz"
# tar -cvpzf "$TAR_FILE" -C "$BACKUP_BASE" .

# # 清理临时备份目录
# rm -rf "$BACKUP_BASE"

# 总体检查结果
if [ $? -eq 0 ]; then
    echo "All backups completed! Combined file: $TAR_FILE"
else
    echo "Backup failed!"
    exit 1
fi