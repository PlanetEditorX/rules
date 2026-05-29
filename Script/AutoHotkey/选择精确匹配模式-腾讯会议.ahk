#Requires AutoHotkey v2.0
#SingleInstance Force
F3::{
    SetTitleMatchMode 2
    if WinActive('录制文件'){
        ;MsgBox '检测到活跃'
        Send '""{Space}'
    	if WinActive('录制文件'){
           Send '""{Space}'
    	}
    }else{
        ;MsgBox '不活跃'
         WinActivate "录制文件"
         Send '""{Space}'
    }
}