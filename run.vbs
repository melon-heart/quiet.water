Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """C:\Program Files\LOVE\love.exe"" """ & CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & """", 1, False
