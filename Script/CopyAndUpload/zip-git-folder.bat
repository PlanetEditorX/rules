:: 压缩大文件夹
for /r "D:\Study\Sync\civil\" %%a in (*.pdf *.docx) do (
	if exist %%a.zip.001 (
		del /f /s /q  %%a.zip.*
	)
	:: 压缩超过20MB的文件
	if %%~za gtr 20971520 (
		C:
		cd "C:\Users\Dear X\scoop\apps\7zip\current\"
		.\7z.exe a -v20m %%a.zip %%a
		del /f /s /q  %%a
	)
) >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"