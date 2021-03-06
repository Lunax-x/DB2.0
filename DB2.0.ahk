;************************************************
;Script Global Settings0
;************************************************

;#NoEnv						; Clear All Systemvariables
#Persistent 				;Keeps a script permanently running until ExitApp execute

#SingleInstance force		;The word FORCE skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

;************************************************
;Performance PARAMETERS - if you need speed
;************************************************
;SetBatchLines, -1
;Process, Priority, , L  ;A  - Max Speed
;************************************************
; Input PARAMETERS
;************************************************
SendMode Input
SetKeyDelay, 50, 50   ; for speed -1, -1,

SetMouseDelay, 5		;0 recommend -1 for max speed
SetDefaultMouseSpeed, 0		;0-100
;************************************************
;History Protocols
;Switch setting for more Speed
;************************************************
;#KeyHistory 1		;  0 - No Keyhistory
;ListLines  On  		; Off  - for more speed
;************************************************
;Window detection
;************************************************
;SetTitleMatchMode, 2
SetTitleMatchMode Fast	;slow detect hidden windows

;SetWinDelay, 0  		;0 - for more speed
;i double the standard settings to be on the save side

ini_loc = %userprofile%\Documents\.AHKsetting\DB2exec.ini ;ini file location var
winDef = IBM CIRATS
winSrch = DB2 Search
winRes = DB2 Search Results
winRec = DB2 Record Details
winNA = DB2 Patch N/A
winRsk = DB2 Edit risk
winNAcont = DB2 Continue
winAddAct = DB2 Add activity


Makeini()
{
IfNotExist, %ini_loc%
	{
	FileCreateDir, %userprofile%\Documents\.AHKsetting
	FileSetAttrib, +H, %userprofile%\Documents\.AHKsetting
	FileAppend, , %ini_loc%
	}
}
Makeini()



Iniread, b_txt1, %ini_loc%, Text, b_text1
Iniread, b_txt2, %ini_loc%, Text, b_text2
Iniread, b_txt3, %ini_loc%, Text, b_text3
Iniread, b_txt4, %ini_loc%, Text, b_text4
Iniread, b_txt5, %ini_loc%, Text, b_text5
Iniread, b_txt6, %ini_loc%, Text, b_text6
Gui, def:+AlwaysOnTop
Gui, def:Font, bold
Gui, def:Add, Text,, DB2 assist
Gui, def:Font, normal
Gui, def:Add, Text, x120 y278, 2.5b
Gui, def:Add, Text, x10 y20, Controls
Gui, def:Add, Text, x82 y12, Autohide?
Gui, def:Add, Checkbox, x135 y12 vhid

Gui, def:Add, Button, gMassExtend x10 y40, Batch extend
gui, def:font, s6
Gui, def:Add, Text,x85 y40, - only extended
Gui, def:Add, Text,x90 y52, records
gui, def:font,
Gui, def:Add, Button, gMassClose x10 y70, Batch close
Gui, def:Font, s5
Gui, def:Add, Button, ginfo x120 y260 cPink, info
gui, def:font,

Gui, def:Add, Text,x10 y100, Automated text
Gui, def:Add, Button, vtext1 gtext1 x10 y120 w60, %b_txt1%
Gui, def:Add, Button, vtext2 gtext2 x10 y150 w60, %b_txt2%
Gui, def:Add, Button, vtext3 gtext3 x10 y180 w60, %b_txt3%
Gui, def:Add, Button, vtext4 gtext4 x10 y210 w60, %b_txt4%
Gui, def:Add, Button, vtext5 gtext5 x10 y240 w60, %b_txt5%
Gui, def:Add, Button, vtext6 gtext6 x10 y270 w60, %b_txt6%

;setting buttons
Gui, def:Font, s5 cBlue, Arial
Gui, def:Add, Button, gset1 x77 y120 cPink, set
Gui, def:Add, Button, gset2 x77 y150 cPink, set
Gui, def:Add, Button, gset3 x77 y180 cPink, set
Gui, def:Add, Button, gset4 x77 y210 cPink, set
Gui, def:Add, Button, gset5 x77 y240 cPink, set
Gui, def:Add, Button, gset6 x77 y270 cPink, set
Gui, def:Show, W150

;set timers for checks
SetTimer , Autohide, 1000, -1

return

Autohide:
ifwinactive, %A_ScriptName%
goto skip
gui, def:submit, nohide
	if (hid = 1)
	{
		WinGet, win_status, MinMax, %A_ScriptName%
		If (WinActive("DB2") && (win_status = -1))
		{
		winrestore, %A_ScriptName%
		WinActivate, IBM CIRATS 4.2: Patch advisories
		}
		If (!WinActive("DB2") && (win_status = 0))
		{
		WinMinimize, %A_ScriptName%
		}
	}
	skip:
Sleep 500
return

Info:
	Iniread,counter, %ini_loc%, Stats, closed_count
	timesaved := (counter * 2)/60
	timesaved := round(timesaved, 1)
	msgbox, %counter% records were processed and you saved approximately %timesaved% hours of your life.
return

Minput:
	WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
	Iniread, reas, %ini_loc%, Text, reason
	StringReplace, reas, reas, ¥,`n, All, ;recall linebreaks
	Gui,Minput: New,, Edit text
	Gui,Minput:Add, text,,%reas%
	Gui,Minput:Add,Edit,r20 w300 vw_reas
	Gui,Minput:Add,Button,xs+200 gMOK,OK
	Gui,Minput:Add,Button,x+10 gNC,No change
	Gui,Minput:Add,Button,x+10 gMCancel,Cancel
	Gui,Minput:Show
	WinWaitClose,Edit text
return

MCancel:
		Gui, Minput:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Cancel = 1
return

NC:
	Gui, Minput:destroy
	WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return


MOK:
		Gui, submit
		StringReplace, w_reas, w_reas, `n,¥, All, ;linebreak fix
		StringReplace, w_reas, w_reas, %A_Tab%,%A_Space%, All, ;tabbed string fix
		Iniwrite, %w_reas%, %ini_loc%, Text, reason
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

;set buttons functionality

set1:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt1, %ini_loc%, Text, b_text1
		Inputbox, w_btxt1, Enter button label, Current: %b_txt1%,,200,150
		if ErrorLevel
		{
		goto skip1
		}
		else
		Iniwrite, %w_btxt1%, %ini_loc%, Text,  b_text1
		Iniread, b_txt1, %ini_loc%, Text, b_text1
		GuiControl,, text1, %b_txt1%
		skip1:
		Iniread, txt1, %ini_loc%, Text, text1
		StringReplace, txt1, txt1, ¥,`n, All, ;recall linebreaks
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt1%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt1
	Gui,MyGui:Add,Button,xs+200 gOK1,OK
	Gui,MyGui:Add,Button,x+10 gCancel1,Cancel
	Gui,MyGui:Show
	return

		Cancel1:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return

		OK1:
		Gui, submit
		StringReplace, w_txt1, w_txt1, `n,¥, All, ;linebreak fix
		StringReplace, w_txt1, w_txt1, %A_Tab%,%A_Space%, All, ;tabbed string fix
		Iniwrite, %w_txt1%, %ini_loc%, Text, text1
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set2:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt2, %ini_loc%, Text, b_text2
		Inputbox, w_btxt2, Enter button label, Current: %b_txt2%,,200,150
		if ErrorLevel
		{
		goto skip2
		}
		else
		Iniwrite, %w_btxt2%, %ini_loc%, Text,  b_text2
		Iniread, b_txt2, %ini_loc%, Text, b_text2
		GuiControl,, text2, %b_txt2%
		skip2:
		Iniread, txt2, %ini_loc%, Text, text2
		StringReplace, txt2, txt2, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt2%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt2
	Gui,MyGui:Add,Button,xs+200 gOK2,OK
	Gui,MyGui:Add,Button,x+10 gCancel2,Cancel
	Gui,MyGui:Show
	return

		Cancel2:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return

		OK2:
		Gui, submit
		StringReplace, w_txt2, w_txt2, `n,¥, All,
		StringReplace, w_txt2, w_txt2, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt2%, %ini_loc%, Text, text2
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set3:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt3, %ini_loc%, Text, b_text3
		Inputbox, w_btxt3, Enter button label, Current: %b_txt3%,,200,150
		if ErrorLevel
		{
		goto skip3
		}
		else
		Iniwrite, %w_btxt3%, %ini_loc%, Text,  b_text3
		Iniread, b_txt3, %ini_loc%, Text, b_text3
		GuiControl,, text3, %b_txt3%
		skip3:
		Iniread, txt3, %ini_loc%, Text, text3
		StringReplace, txt3, txt3, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt3%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt3
	Gui,MyGui:Add,Button,xs+200 gOK3,OK
	Gui,MyGui:Add,Button,x+10 gCancel3,Cancel
	Gui,MyGui:Show
	return

		Cancel3:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return

		OK3:
		Gui, submit
		StringReplace, w_txt3, w_txt3, `n,¥, All,
		StringReplace, w_txt3, w_txt3, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt3%, %ini_loc%, Text, text3
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set4:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt4, %ini_loc%, Text, b_text4
		Inputbox, w_btxt4, Enter button label, Current: %b_txt4%,,200,150
		if ErrorLevel
		{
		goto skip4
		}
		else
		Iniwrite, %w_btxt4%, %ini_loc%, Text,  b_text4
		Iniread, b_txt4, %ini_loc%, Text, b_text4
		GuiControl,, text4, %b_txt4%
		skip4:
		Iniread, txt4, %ini_loc%, Text, text4
		StringReplace, txt4, txt4, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt4%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt4
	Gui,MyGui:Add,Button,xs+200 gOK4,OK
	Gui,MyGui:Add,Button,x+10 gCancel4,Cancel
	Gui,MyGui:Show
	return

		Cancel4:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return

		OK4:
		Gui, submit
		StringReplace, w_txt4, w_txt4, `n,¥, All,
		StringReplace, w_txt4, w_txt4, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt4%, %ini_loc%, Text, text4
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set5:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt5, %ini_loc%, Text, b_text5
		Inputbox, w_btxt5, Enter button label, Current: %b_txt5%,,200,150
		if ErrorLevel
		{
		goto skip5
		}
		else
		Iniwrite, %w_btxt5%, %ini_loc%, Text,  b_text5
		Iniread, b_txt5, %ini_loc%, Text, b_text5
		GuiControl,, text5, %b_txt5%
		skip5:
		Iniread, txt5, %ini_loc%, Text, text5
		StringReplace, txt5, txt5, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt5%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt5
	Gui,MyGui:Add,Button,xs+200 gOK5,OK
	Gui,MyGui:Add,Button,x+10 gCancel5,Cancel
	Gui,MyGui:Show
	return

		Cancel5:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return

		OK5:
		Gui, submit
		StringReplace, w_txt5, w_txt5, `n,¥, All,
		StringReplace, w_txt5, w_txt5, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt5%, %ini_loc%, Text, text5
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set6:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt6, %ini_loc%, Text, b_text6
		Inputbox, w_btxt6, Enter button label, Current: %b_txt6%,,200,150
		if ErrorLevel
		{
		goto skip6
		}
		else
		Iniwrite, %w_btxt6%, %ini_loc%, Text,  b_text6
		Iniread, b_txt6, %ini_loc%, Text, b_text6
		GuiControl,, text6, %b_txt6%
		skip6:
		Iniread, txt6, %ini_loc%, Text, text6
		StringReplace, txt6, txt6, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt6%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt6
	Gui,MyGui:Add,Button,xs+200 gOK6,OK
	Gui,MyGui:Add,Button,x+10 gCancel6,Cancel
	Gui,MyGui:Show
	return

		Cancel6:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return

		OK6:
		Gui, submit
		StringReplace, w_txt6, w_txt6, `n,¥, All,
		StringReplace, w_txt6, w_txt6, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt6%, %ini_loc%, Text, text6
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

CMDsubmit:
ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, ahk_class MozillaWindowClass
ClipSaved := ClipboardAll
clipboard := CMDsubmit
ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, ahk_class MozillaWindowClass
clipboard := ClipSaved
return



CMDclose:
ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, %winRec%
ClipSaved := ClipboardAll
clipboard := CMDclose
ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRec%
clipboard := ClipSaved
return



MassClose:
	Runwait C:\Windows\Notepad.exe "%userprofile%\Documents\.AHKsetting\APAR list.txt"	;settings

	GoSub Minput																		;multiline entry
	Sleep 150
	if (Cancel = 1 or ErrorLevel = 1)
		return

	;line count
	WinGetPos, Xpos, Ypos,,, %winSrch%
	Xpos := Xpos + 7
	Ypos := Ypos + 7
	XposP := Xpos
	YposP := Ypos + 37
	FileRead File, %userprofile%\Documents\.AHKsetting\APAR list.txt
	StringReplace File, File, `n, `n, All UseErrorLevel
	line_count := ErrorLevel + 1
	timeleft := ((line_count) * 20)
	timeleft := round(timeleft)

	progr = 0
	Loop, read, %userprofile%\Documents\.AHKsetting\APAR list.txt
	{
		progr := progr + 1
		progrbar := 100*(progr/line_count)

;COMMANDS DEFINED
		CMDna = submitParameters(['id','markButton','mast-record-id','Mode','target-mode','from-mode','recordStatus','EFLUX_ACTION'],['%A_LoopReadLine%','true','725899','Child-patch-advisory-details','Patch-not-applicable','Child-patch-advisory-details','1','CLEAR_CHANGES'])
		CMDsubmit = submitParameters(['Mode','id','mast-record-id','from-mode','recordStatus','titleAttr','titleHeading'],['Patch-not-applicable','%A_LoopReadLine%','','Child-patch-advisory-details','1','Patch not applicable confirmation','Patch advisory status updated'])
		CMDreason = document.getElementById('reasonNA').value=
		CMDclose = submitParameters(['id','closureParam','recordStatusUpdateFilterName','pendingNotifyInsertFilterName','redirectMode','Mode','EFLUX_ACTION','from-mode'],['%A_LoopReadLine%','true','pendingStatusUpdateFilter','pendingNotificationFilter','Closure-request-confirmation-PA','Child-patch-advisory-details','CLEAR_CHANGES','Child-patch-advisory-details'])
		CMDreturn = submitNewFormParameters(['EFLUX_BREADCRUMB','EFLUX_BREADCRUMB','Mode','FROM_ACTIVITY'],['true','true','PAAdvanced-search','NAVIGATION'])
		CMDfillRec = document.getElementById('recordNum').value=
		CMDsubmitRec = submitParameters(['Mode','FROM_ACTIVITY','fromMode','searchFlag'],['PAAdvanced-search','pagination','Patch-advisories-list','PA-ADV-SEARCH-SUBMIT'])
		CMDclickFound = submitParameters(['Mode','cleanUp','id','recordStatus','recordType'],['Patch-advisories-list','true','%A_LoopReadLine%','1','Patch Advisory'])
		CMDcontinue = submitParameters(['Mode','FROM_ACTIVITY'],['Child-patch-advisory-details','pagination'])


	SplashImage,, x%xpos% y%ypos% b fs10, Processing %progr%/%line_count% #%A_LoopReadLine% `n Time remaining %timeleft% sec.
	Progress, b ZH10 w300 CT000000 x%xposP% y%YposP%
	Progress, %progrbar%,, working...

	;START-------------------------------------------------------------------------
	;go record
	winwait, %winSrch%,,15
	if ErrorLevel = 1
	{
	msgbox Not at search page. Try again.
	return
	}
  ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, %winSrch%
	Sleep 1000
	ClipSaved := ClipboardAll
	clipboard = %CMDfillRec%"%A_LoopReadLine%"
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winSrch%
	Sleep 100
;add check in case no results found
	clipboard = %CMDsubmitRec%
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winSrch%

	winwait, %winRes%,,15
	Sleep 200
	clipboard = %CMDclickFound%
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRes%

	winwait, %winRec%,,15
	Sleep 200
	clipboard = %CMDna%
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRec%

	winwait, %winNA%,,15
	Sleep 200
	Iniread, reas, %ini_loc%, Text, reason
	StringReplace, reas, reas, ¥,`n, All, ;recall linebreaks
	clipboard = %CMDreason%``%reas%``
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winNA%
	Sleep 150

	;CMDsubmit:
	ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, ahk_class MozillaWindowClass
	clipboard := CMDsubmit
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, ahk_class MozillaWindowClass

	winwait, %winNAcont%
	Sleep 200
	clipboard := CMDcontinue
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, ahk_class MozillaWindowClass

	winwait, %winRec%
	Sleep 200
  ;close:
	ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, %winRec%
	clipboard := CMDclose
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRec%

	end:
	winwait, %winDef%
	Sleep 200
	clipboard := CMDreturn
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winDef%

	timeleft := ((line_count - A_index) * 20)
	timeleft := round(timeleft)
	Iniread, closed_r, %ini_loc%, Stats, closed_count, 0
	closed := closed_r + 1
	Iniwrite, %closed%, %ini_loc%, Stats, closed_count
	Sleep 8000
	}
	SplashImage, Off
	Progress, Off

	clipboard := ClipSaved
	final:
	if error = 1
	msgbox Processing failed at record #%A_LoopReadLine%
	else
	msgbox Processing complete
return

MassExtend:
	Inputbox, RskRecNr, Enter Risk Evaluation record number
	Inputbox, date, Enter date for extension, Ex.: 1 Jun 2019 - any other format will fail
	Runwait C:\Windows\Notepad.exe "%userprofile%\Documents\.AHKsetting\APAR list.txt"	;settings

	GoSub Minput																		;multiline entry
	Sleep 150
	if (Cancel = 1 or ErrorLevel = 1)
		return

	;line count
	WinGetPos, Xpos, Ypos,,, %winSrch%
	Xpos := Xpos + 7
	Ypos := Ypos + 7
	XposP := Xpos
	YposP := Ypos + 37
	FileRead File, %userprofile%\Documents\.AHKsetting\APAR list.txt
	StringReplace File, File, `n, `n, All UseErrorLevel
	line_count := ErrorLevel + 1
	timeleft := ((line_count) * 20)
	timeleft := round(timeleft)

	progr = 0
	Loop, read, %userprofile%\Documents\.AHKsetting\APAR list.txt
	{
		progr := progr + 1
		progrbar := 100*(progr/line_count)

;COMMANDS DEFINED
		CMDna = submitParameters(['id','markButton','mast-record-id','Mode','target-mode','from-mode','recordStatus','EFLUX_ACTION'],['%A_LoopReadLine%','true','725899','Child-patch-advisory-details','Patch-not-applicable','Child-patch-advisory-details','1','CLEAR_CHANGES'])
		CMDsubmit = submitParameters(['Mode','id','mast-record-id','from-mode','recordStatus','titleAttr','titleHeading'],['Patch-not-applicable','%A_LoopReadLine%','','Child-patch-advisory-details','1','Patch not applicable confirmation','Patch advisory status updated'])
		CMDreason = document.getElementById('reasonNA').value=
		CMDclose = submitParameters(['id','closureParam','recordStatusUpdateFilterName','pendingNotifyInsertFilterName','redirectMode','Mode','EFLUX_ACTION','from-mode'],['%A_LoopReadLine%','true','pendingStatusUpdateFilter','pendingNotificationFilter','Closure-request-confirmation-PA','Child-patch-advisory-details','CLEAR_CHANGES','Child-patch-advisory-details'])
		CMDreturn = submitNewFormParameters(['EFLUX_BREADCRUMB','EFLUX_BREADCRUMB','Mode','FROM_ACTIVITY'],['true','true','PAAdvanced-search','NAVIGATION'])
		CMDfillRec = document.getElementById('recordNum').value=
		CMDsubmitRec = submitParameters(['Mode','FROM_ACTIVITY','fromMode','searchFlag'],['PAAdvanced-search','pagination','Patch-advisories-list','PA-ADV-SEARCH-SUBMIT'])
		CMDclickFound = submitParameters(['Mode','cleanUp','id','recordStatus','recordType'],['Patch-advisories-list','true','%A_LoopReadLine%','1','Patch Advisory'])
		CMDcontinue = submitParameters(['Mode','FROM_ACTIVITY'],['Child-patch-advisory-details','pagination'])
		CMDaddAct = submitParameters(['Mode','FromMode'],['Activity-history-add-activity','Child-patch-advisory-details'])
		CMDactText = document.getElementById('activityText').value=
		CMDsubmitAct = submitUpload(['Mode','EFLUX_ACTION','FromMode'],['Activity-history-add-activity','CLEAR_CHANGES','Child-patch-advisory-details'])
		CMDeditRsk = submitParameters(['Mode','recId','from-mode'],['Risk-acceptance-request-edit','%A_LoopReadLine%','Child-patch-advisory-details'])
		CMDeditRskNr = document.getElementById('wwradbNumber').value=
		CMDeditDate = document.MainForm.targetDate.value='%date%'
		CMDsubmitExt = submitParameters(['Mode','id','from-mode','EFLUX_ACTION','tab-name','duedate','wwrno','cleanUp'],['Risk-acceptance-request-edit','%A_LoopReadLine%','Child-patch-advisory-details','CLEAR_CHANGES','riskAcceptanceTab','%date%','%RskRecNr%','true'])


	SplashImage,, x%xpos% y%ypos% b fs10, Processing %progr%/%line_count% #%A_LoopReadLine% `n Time remaining %timeleft% sec.
	Progress, b ZH10 w300 CT000000 x%xposP% y%YposP%
	Progress, %progrbar%,, working...

	;START-------------------------------------------------------------------------
	;go record
	winwait, %winSrch%,,15
	if ErrorLevel = 1
	{
	msgbox Not at search page. Try again.
	return
	}
  ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, %winSrch%
	Sleep 1000
	ClipSaved := ClipboardAll
	clipboard = %CMDfillRec%"%A_LoopReadLine%"
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winSrch%
	Sleep 100
;add check in case no results found
	clipboard = %CMDsubmitRec%
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winSrch%

	winwait, %winRes%,,15
	Sleep 200
	clipboard = %CMDclickFound%
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRes%

	winwait, %winRec%,,15
	Sleep 200
	clipboard = %CMDaddAct%
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRec%

	winwait, %winAddAct%,,15
	Sleep 200
	Iniread, reas, %ini_loc%, Text, reason
	StringReplace, reas, reas, ¥,`n, All, ;recall linebreaks
	clipboard = %CMDactText%``%reas%``
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winAddAct%
	Sleep 150

	;CMDsubmit:
	ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, ahk_class MozillaWindowClass
	clipboard := CMDsubmitAct
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, ahk_class MozillaWindowClass

	winwait, %winNAcont%
	Sleep 200
	clipboard := CMDcontinue
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, ahk_class MozillaWindowClass

	winwait, %winRec%
	Sleep 200
  ;extend:
	ControlSend, ahk_parent, {Ctrl down}{Shift down}k{Ctrl up}{Shift up}, %winRec%
	clipboard := CMDeditRsk
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRec%

	winwait, %winRsk%
	Sleep 200
	clipboard = %CMDeditRskNr%``%RskRecNr%``
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRsk%
	Sleep 200
	clipboard := CMDeditDate
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRsk%
	Sleep 200
	clipboard := CMDsubmitExt
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, ahk_class MozillaWindowClass

	winwait, %winNAcont%
	Sleep 200
	clipboard := CMDcontinue
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, ahk_class MozillaWindowClass

	;end:
	winwait, %winRec%
	Sleep 200
	clipboard := CMDreturn
	ControlSend, ahk_parent, {Ctrl down}v{Ctrl up}{enter}, %winRec%

	timeleft := ((line_count - A_index) * 20)
	timeleft := round(timeleft)
	Iniread, closed_r, %ini_loc%, Stats, closed_count, 0
	closed := closed_r + 1
	Iniwrite, %closed%, %ini_loc%, Stats, closed_count
	Sleep 8000
	}
	SplashImage, Off
	Progress, Off

	clipboard := ClipSaved
	;final:
	if error = 1
	msgbox Processing failed at record #%A_LoopReadLine%
	else
	msgbox Processing complete
return

text1:

	Iniread, txt1, %ini_loc%, Text, text1
	StringReplace, txt1, txt1, ¥,`n, All,
	WinActivate, ahk_class MozillaWindowClass
	Sendinput, %txt1%
	Sleep, 150

return

text2:

	Iniread, txt2, %ini_loc%, Text, text2
	StringReplace, txt2, txt2, ¥,`n, All,
	WinActivate, ahk_class MozillaWindowClass
	Sendinput, %txt2%
	Sleep, 150

return

text3:

	Iniread, txt3, %ini_loc%, Text, text3
	StringReplace, txt3, txt3, ¥,`n, All,
	WinActivate, ahk_class MozillaWindowClass
	Sendinput, %txt3%
	Sleep, 150

return

text4:

	Iniread, txt4, %ini_loc%, Text, text4
	StringReplace, txt4, txt4, ¥,`n, All,
	WinActivate, ahk_class MozillaWindowClass
	Sendinput, %txt4%
	Sleep, 150

return

text5:

	Iniread, txt5, %ini_loc%, Text, text5
	StringReplace, txt5, txt5, ¥,`n, All,
	WinActivate, ahk_class MozillaWindowClass
	Sendinput, %txt5%
	Sleep, 150

return

text6:

	Iniread, txt6, %ini_loc%, Text, text6
	StringReplace, txt6, txt6, ¥,`n, All,
	WinActivate, ahk_class MozillaWindowClass
	Sendinput, %txt6%
	Sleep, 150

return



defGuiClose:
ExitApp

MinputGuiClose:
Gui, Minput:destroy
Cancel = 1
WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

F12::reload  ; to reload the script after making changes (don't forget to save)
