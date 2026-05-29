import sys
import re
import os
from datetime import datetime
from pathlib import Path
import xml.etree.ElementTree as ET


# 适用格式 [作品类型(作者)]
def move_folder(name, root_path):
    path = root_path + "\\" + name
    premiered = read_nfo(path)
    # 拼接目标文件
    suffix_list = ['.nfo', '.mkv', '.mp4', '-poster.png', '-poster.jpg', '-fanart.jpg', '-fanart.png', '-thumb.jpg', '-thumb.png']
    # 使用 os.path.splitext() 分割文件名和扩展名
    base_name, extension = os.path.splitext(name)

    for suffix in suffix_list:
        file_path = f"{root_path}\\{base_name}{suffix}"
        if os.path.exists(file_path):
            # 重命名文件
            new_name = f"{root_path}\\{premiered}{base_name}{suffix}"
            os.rename(file_path, new_name)
    return


def read_nfo(file_path):
    try:
        # 解析 XML 文件
        tree = ET.parse(file_path)
        root = tree.getroot()
        # 创建一个字典来存储解析后的数据
        info_dict = {}
        # 遍历 XML 文件中的所有标签
        for element in root:
            # 将标签名和内容存储到字典中
            info_dict[element.tag] = element.text
        # 访问特定的字段
        premiered = info_dict.get("premiered", "未知")
        releasedate = info_dict.get("releasedate", "未知")
        # 首播日期
        print(f"文件{file_path}的首播日期为: {premiered}")
        # 发布日期
        # print(f"Release Date: {releasedate}")
        # 将字符串转换为 datetime 对象
        date_obj = datetime.strptime(premiered, "%Y-%m-%d")
        # 提取年、月、日
        year = str(date_obj.year)[-2:]
        month = str(date_obj.month).zfill(2)
        day = str(date_obj.day).zfill(2)
        return f"[{year}{month}{day}]"
    except FileNotFoundError:
        print(f"文件 {file_path} 未找到！")
    except ET.ParseError:
        print("文件格式不是有效的 XML！")
    except Exception as e:
        print(f"读取文件时发生错误：{e}")


if len(sys.argv) > 1:
	# 获取命令行参数
    root_path = sys.argv[1]

else:
	root_path = os.getcwd()
print(f"运行目录为：{root_path}")
folder_list = os.listdir(root_path)
pattern = r"^(?!\[\d{6}\]).*"
for folder_item in folder_list:
    if os.path.splitext(folder_item)[-1].lower() == '.nfo' and re.match(pattern, folder_item):
        move_folder(folder_item, root_path)