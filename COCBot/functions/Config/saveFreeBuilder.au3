If GUICtrlRead($chkFreeBuilder) = $GUI_CHECKED Then

        IniWrite($config, "other", "chkFreeBuilder", 1)
    Else
        IniWrite($config, "other", "chkFreeBuilder", 0)
    EndIf
