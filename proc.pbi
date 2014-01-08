; -----------------------------------------------------------------------------
; Copyright (c) 2014 Sean Stasiak. All rights reserved.
; Developed by: Sean Stasiak <sstasiak@gmail.com>
; Refer to license terms in LICENSE.txt; In the absence of such a file,
; contact me at the above email address and I can provide you with one.
; -----------------------------------------------------------------------------

EnableExplicit

Procedure load_ports(combo_gadget, filename.s)
  If OpenPreferences(filename)
    If PreferenceGroup("ports") And ExaminePreferenceKeys()
      While NextPreferenceKey()
        AddGadgetItem(combo_gadget, -1, PreferenceKeyName())
      Wend
      ProcedureReturn ~0
    EndIf
    ClosePreferences()
  EndIf
  ProcedureReturn 0
EndProcedure

Structure struct_code
  mod.b
  code.b
EndStructure

Procedure pop_codes(port.s, listview_gadget)
  ClearGadgetItems(listview_gadget)
  If OpenSerialPort(0, port, 115200, #PB_SerialPort_NoParity, 8, 1, #PB_SerialPort_NoHandshake, 32, 32)
    Protected code.struct_code
    While WriteSerialPortString(0, "p")
      Repeat
        Delay(50)
      Until AvailableSerialPortInput(0) = 2
      ReadSerialPortData(0, @code, 2)
      AddGadgetItem(listview_gadget, -1, "M:["+Str(code\mod)+"] C:["+Str(code\code)+"]")
      If (code\mod = 0) And (code\code = 0)
        AddGadgetItem(listview_gadget, -1, "Done")
        Break
      EndIf
    Wend
    CloseSerialPort(0)
  Else
    AddGadgetItem(listview_gadget, -1, "Unable to open port")
  EndIf
EndProcedure
; IDE Options = PureBasic 5.21 LTS (Windows - x64)
; CursorPosition = 35
; FirstLine = 6
; Folding = -
; EnableUnicode
; EnableXP
; CPU = 1
; EnablePurifier