@echo off & setlocal enabledelayedexpansion
rem setlocal enabledelayedexpansion用于开启变量延迟，这是告诉解释器，在遇到复合语句的时候，不要将其作为一条语句同时处理，而仍然一条一条地去解释

for /f "delims=" %%a in ('dir /a-d /s /b ^|find /v "%~nx0"') do (
	rem 分卷压缩大于50MB的文件
	if %%~za gtr 52428800 (
		set/a size=%%~za/1048576 & echo,%%a !size!MB
		C:
		cd C:\Users\96212\scoop\apps\7zip\current\
		.\7z.exe a -v50m %%a.zip %%a
		del /f /s /q  %%a
	)
)
::压缩当前文件夹下大于50MB的文件
pause