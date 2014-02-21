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

Procedure pop_codes(port.s, listview_gadget)
  ClearGadgetItems(listview_gadget)
  If OpenSerialPort(0, port, 115200, #PB_SerialPort_NoParity, 8, 1, #PB_SerialPort_NoHandshake, 32, 32)
    Protected retry.i = 0
    While WriteSerialPortString(0, "p")
      Delay(100)
      Protected cnt.i = AvailableSerialPortInput(0)
      If cnt
        retry = 0
        Dim buff.b(64)
        ReadSerialPortData(0, @buff(0), cnt)
        AddGadgetItem(listview_gadget, -1, PeekS(@buff(0),10,#PB_Ascii) )
        If PeekS(@buff(0),10,#PB_Ascii) = "M[00]C[00]"
          AddGadgetItem(listview_gadget, -1, "Done")
          Break
        EndIf
      Else
        retry + 1
        If retry > 3
          AddGadgetItem(listview_gadget, -1, "Timeout")
          Break
        EndIf
      EndIf
    Wend
    CloseSerialPort(0)
  Else
    AddGadgetItem(listview_gadget, -1, "Unable to open port")
  EndIf
EndProcedure
; IDE Options = PureBasic 5.21 LTS (Windows - x64)
; CursorPosition = 34
; FirstLine = 17
; Folding = -
; EnableUnicode
; EnableXP
; CPU = 1
; EnablePurifier