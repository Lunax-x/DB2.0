#SingleInstance force
SendMode Input
SetKeyDelay, 5, 1   ; for speed -1, -1,
SetTitleMatchMode Fast	;slow detect hidden windows

window = IBM CIRATS 4.2: Patch advisories - Mozilla Firefox
CMDna = submitParameters(['id','markButton','mast-record-id','Mode','target-mode','from-mode','recordStatus','EFLUX_ACTION'],['106186814','true','725899','Child-patch-advisory-details','Patch-not-applicable','Child-patch-advisory-details','1','CLEAR_CHANGES'])
CMDsubmit = submitParameters(['Mode','id','mast-record-id','from-mode','recordStatus','titleAttr','titleHeading'],['Patch-not-applicable','106186814','','Child-patch-advisory-details','1','Patch not applicable confirmation','Patch advisory status updated'])
CMDreason = document.getElementById('reasonNA').value="sample text"

Gui, Add, Text,, DB2 assist
Gui, Add, Button, gctrl1 x10 y40, test
Gui, Show, W150
return

ctrl1:
{
  ControlSend, , ^+k, %window%
  sleep 500
  ClipSaved := ClipboardAll
  clipboard := CMDna
  ControlSend, , ^v{enter}, %window%
  sleep 3000
  clipboard := CMDreason
  ControlSend, , ^v{enter}, %window%
  sleep 200
  clipboard := CMDsubmit
  ControlSend, , ^v{enter}, %window%
  clipboard := ClipSaved
}
return

GuiClose:
ExitApp

F12::reload  ; to reload the script after making changes (don't forget to save)
