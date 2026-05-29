@echo off
echo ===================================================================================================== >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
echo %date:~0,10%-%time:~0,8% document-copy is start >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"

xcopy "C:\Users\Dear X\Desktop\å­¦ä¹ \" D:\Study\Sync\civil\å­¦ä¹ \ /s /v /y /d /exclude:document-copy-exclude.txt >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"

xcopy "C:\Users\Dear X\Desktop\2023å¹´æ•™ç¨‹\" D:\Study\Sync\civil\2023å¹´æ•™ç¨‹\ /s /v /y /d /exclude:document-copy-exclude.txt >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"

xcopy "C:\Users\Dear X\Documents\script\" D:\Study\Sync\script\ /s /v /y /d /exclude:document-copy-exclude.txt >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"

:: åŽ‹ç¼©å¤§æ–‡ä»¶å¤¹
for /r "D:\Study\Sync\civil\" %%a in (*.pdf *.docx) do (
	if exist %%a.zip.001 (
		del /f /s /q  %%a.zip.*
	)
	:: åŽ‹ç¼©è¶…è¿‡20MBçš„æ–‡ä»¶
	if %%~za gtr 20971520 (
		C:
		cd "C:\Users\Dear X\scoop\apps\7zip\current\"
		.\7z.exe a -v20m %%a.zip %%a
		del /f /s /q  %%a
	)
) >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"

::µ÷ÓÃgit½Å±¾
C:
cd "C:\Users\Dear X\Documents\script"
start document-git.vbs

::pause

::xcopyå‘½ä»¤
::https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/xcopy

::ÖÐÎÄÂÒÂë¾ÍÁí´æÎªANSI¸ñÊ½
echo ===================================================================================================== >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
