@echo off
echo ===================================================================================================== >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
echo %date:~0,10%-%time:~0,8% document-git civil is start >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
:: 文件同步
::D:
::cd D:\Study\Sync\civil
::git pull >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
::git add .  >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
::git commit -m "`%date:~0,10%-%time:~0,8%`: Update documents"  >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
::git push >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"

echo ===================================================================================================== >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
echo %date:~0,10%-%time:~0,8% document-git script is start >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
:: 脚本同步
D:
cd D:\Study\Sync\script
git pull >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
git add .  >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
git commit -m "`%date:~0,10%-%time:~0,8%`: Update documents"  >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
git push >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"

echo ===================================================================================================== >> "C:\Users\Dear X\Documents\script\CopyAndGit.log"
::pause