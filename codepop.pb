; -----------------------------------------------------------------------------
; Copyright (c) 2014 Sean Stasiak. All rights reserved.
; Developed by: Sean Stasiak <sstasiak@gmail.com>
; Refer to license terms in LICENSE.txt; In the absence of such a file,
; contact me at the above email address and I can provide you with one.
; -----------------------------------------------------------------------------

EnableExplicit
XIncludeFile "assert.pbi"
XIncludeFile "proc.pbi"
XIncludeFile "form.pbf"

OpenWindow_codepop()

; populate ports
If Not load_ports(Combo_ports, "ports.pref")
  AddGadgetItem(Combo_ports, -1, "NONE")
EndIf
SetGadgetState(Combo_ports, 0)
DisableGadget(Combo_ports, 0)

; process
Repeat
  Define event.i = WaitWindowEvent()
  Select EventWindow()
    Case Window_codepop
      Window_codepop_Events(event)
  EndSelect
Until event = #PB_Event_CloseWindow

Procedure Button_getcodes_Events(event_type)
  If event_type = #PB_EventType_LeftClick
    assert(GetGadgetState(Combo_ports) <> -1)
    pop_codes(GetGadgetText(Combo_ports), ListView_codes)
  EndIf
EndProcedure
; IDE Options = PureBasic 5.21 LTS (Windows - x64)
; CursorPosition = 25
; Folding = -
; EnableXP
; CPU = 1