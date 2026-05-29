#Requires AutoHotkey v2.0
#SingleInstance Force
F3::{
    SetTitleMatchMode 2
    if WinActive('mp4'){
        ;MsgBox '检测到活跃'
        Send '""{Space}'
    	if WinActive('录制文件'){
           Send '""{Space}'
    	}
    }else{
        ;MsgBox '不活跃'
        ;WinActivate "2.02社会现象·理论(2).mp4"
         WinActivate "mp4"
         Send '""{Space}'
    }
}