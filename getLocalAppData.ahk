#Requires AutoHotkey v1.1.0+
#Include %A_ScriptDir%
#Include .\lib\getKnownFolderPath.ahk
;==============================================================
; getLocalAppData — Helper to retrieve the LocalAppData path
;
; GitHub: https://github.com/SevenKeyboard/get-local-app-data
; Author: SevenKeyboard Ltd. (2025)
; License: The Unlicense
;==============================================================
class VersionManager_getLocalAppData
{
    static _ := VersionManager_getLocalAppData._init()
    _init()    {
        global
        GETLOCALAPPDATA_VERSION := "1.0.0"
        if (!this._verCheck(GETKNOWNFOLDERPATH_VERSION, "1.0.0"))
            throw exception("getKnownFolderPath version 1.x is required (minimum 1.0.0).")
        return true
    }
    _verCheck(byRef actual, required)    {
        if !isSet(actual)
            return false
        actualMajor     := strSplit(actual, ".",, 2)[1]
        requiredMajor   := strSplit(required, ".",, 2)[1]
        if (actualMajor != requiredMajor)
            return false
        return verCompare(actual, ">=" required)
    }
}
getLocalAppData()    {
    static FOLDERID_LocalAppData := "{F1B32785-6FBA-4FCF-9D55-7B8E7F157091}"
    localAppData := getKnownFolderPath(FOLDERID_LocalAppData)
    if (localAppData == "")
        envGet localAppData, LocalAppData
    return localAppData
}