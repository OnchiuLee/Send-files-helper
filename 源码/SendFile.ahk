#NoEnv
#SingleInstance, Force
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#Include lib\Class_WinClipAPI.ahk
#Include lib\Class_WinClip.ahk
#Include lib\Class_EasyIni.ahk
WinGetPos,,,,Shell_Wnd ,ahk_class Shell_TrayWnd
If !FileExist(A_temp "\FileHelper")
	FileCreateDir, %A_temp%\FileHelper
global default_obj, AHKIni:=class_EasyIni(A_Temp "\FileHelper\setting.ini")
default_obj:={FilePath:["֧���ļ�\Ŀ¼��ק���˴����������"],FileLists:["������ѡ�����"],Hotkeys:{RunHotkey:"!d"}}
Array_isInValue(aArr, aStr)
{
	for k,v in aArr
	{
		if (IsObject(v) && (aArr[k].count()>0))
		{
			if (Array_isInValue(aArr[k],aStr) = 1)
				return 1
		}
		else if (!IsObject(v) && (v=aStr))
			return 1
	}
}
For Section, element In default_obj
{
	For key, value In element
	{
		if ((%key%:=AHKIni[Section, key])="")
			%key%:=AHKIni[Section, key]:=value
		else
			%key%:=AHKIni[Section, key]
	}
}
AHKIni.Save()
WinClip := new WinClip
Gosub TRAY_Menu
Gosub ReadInis
if FileExist(A_ScriptDir "\*.ico") {
	Loop,Files,*.ico
		IcoFileN:=A_LoopFileLongPath, break
	Menu, Tray, Icon, %IcoFileN%
}
;*****************��ݼ�����*****************
if RunHotkey
	Hotkey, %RunHotkey%, SendFile,on
;******************************************


#Include Script\Script1.ahk