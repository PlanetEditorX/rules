import hashlib
import os
import time
import re
import exifread

class ModifyList:
    def __init__(self):
        self.allnums = 0
        self.success = 0
        self.skip = 0

def add_time(folder_path):
    #读取文件的日期，将其添加到文件名前缀
    modifyList = ModifyList()
    for dirname, subdirs, filelist in os.walk(folder_path):
        print(f"Scanning {dirname}...", file=f)
        modifyList.nums = len(filelist)
        for filename in filelist:
            file_path = os.path.join(dirname, filename)
            file_time = os.stat(file_path)
            #含有时间前缀的文件名
            pattern = re.compile(r'\d{4}(\-|\/|.)\d{1,2}\1\d{1,2}')
            try:
                if (re.match(pattern,filename).span()):
                    modifyList.skip += 1
                    continue
            except (NameError,AttributeError):
                print(file_path + ' will be modify')

            #st_ctime:创建日期
            #st_mtime: 最后一次修改的时间
            st_ctime = file_time.st_ctime
            st_mtime = file_time.st_mtime
            #找到最早的日期
            if st_ctime >= st_mtime:
                f_time = st_mtime
            else:
                f_time = st_ctime
            #将时间戳转为指定时间格式
            timeArray = time.localtime(f_time)
            preTime = time.strftime("%Y_%m_%d_%H_%M_", timeArray)
            #print(preTime)

            #设置新文件名
            newname = dirname + '\\' + preTime + filename
            os.rename(file_path, newname)
            print(f"{file_path} + ======> + {newname}", file=f)
            modifyList.success += 1

    return modifyList

# 选择你照片视频文件夹的路径
folder_path = 'C:\\Users\\DearX\\Downloads\\picture'
if os.path.exists("logs.txt"):
    f = open("logs.txt", "a")
else:
    f = open("logs.txt", "w")

current_time = time.ctime()
print(f"=================================================================", file=f)
print(f"{current_time}", file=f)

start_time = time.time()
modifyList = add_time(folder_path)
end_time = time.time()

print(f"Found {modifyList.nums} files and add time prefix {modifyList.success} files.", file=f)
print(f"Skip modification {modifyList.skip} files due to time prefix.", file=f)
print(f"Time taken: {end_time - start_time} seconds.", file=f)

f.close()