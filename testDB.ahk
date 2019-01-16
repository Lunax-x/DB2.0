#SingleInstance force
SendMode Input
SetKeyDelay, 5, 1   ; for speed -1, -1,
SetTitleMatchMode Fast	;slow detect hidden windows

ini_loc = %userprofile%\Documents\.AHKsetting\DB2exec.ini ;ini file location var

window = DB2 Record Details
winDef = IBM CIRATS 4.2: Patch advisories
winSrch = DB2 Search
winRes = DB2 Search Results
winRec = DB2 Record Details
winNA = DB2 Patch N/A
winRsk = DB2 Edit risk
winNAcont = DB2 Continue

CMDcontinue = submitParameters(['Mode','FROM_ACTIVITY'],['Child-patch-advisory-details','pagination'])
CMDna = submitParameters(['id','markButton','mast-record-id','Mode','target-mode','from-mode','recordStatus','EFLUX_ACTION'],['106186814','true','725899','Child-patch-advisory-details','Patch-not-applicable','Child-patch-advisory-details','1','CLEAR_CHANGES'])
CMDsubmit = submitParameters(['Mode','id','mast-record-id','from-mode','recordStatus','titleAttr','titleHeading'],['Patch-not-applicable','106186814','','Child-patch-advisory-details','1','Patch not applicable confirmation','Patch advisory status updated'])
CMDreason = document.getElementById('reasonNA').value=
CMDclose = submitParameters(['id','closureParam','recordStatusUpdateFilterName','pendingNotifyInsertFilterName','redirectMode','Mode','EFLUX_ACTION','from-mode'],['106765260','true','pendingStatusUpdateFilter','pendingNotificationFilter','Closure-request-confirmation-PA','Child-patch-advisory-details','CLEAR_CHANGES','Child-patch-advisory-details'])
CMDfound = submitParameters(['Mode','cleanUp','id','recordStatus','recordType'],['Patch-advisories-list','true','106186814','1','Patch Advisory'])
CMDfillRec = document.getElementById('recordNum').value=
CMDsubmitRec = submitParameters(['Mode','FROM_ACTIVITY','fromMode','searchFlag'],['PAAdvanced-search','pagination','Patch-advisories-list','PA-ADV-SEARCH-SUBMIT'])
CMDreturn = submitNewFormParameters(['EFLUX_BREADCRUMB','EFLUX_BREADCRUMB','Mode','FROM_ACTIVITY'],['true','true','PAAdvanced-search','NAVIGATION'])

number = 8888

Gui, Add, Text,, DB2 assist
Gui, Add, Button, gctrl1 x10 y40, test
Gui, Show, W150
return


ctrl1:
Iniread, reas, %ini_loc%, Text, reason
StringReplace, reas, reas, ¥,`n, All, ;recall linebreaks
	clipboard = %CMDreason%"%reas%"
return

GuiClose:
ExitApp

F12::reload  ; to reload the script after making changes (don't forget to save)
