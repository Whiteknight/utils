@echo off
if exist "C:\Program Files\Notepad++\Notepad++.exe" goto have_notepad_pp
notepad %*
goto _end
:have_notepad_pp
"C:\Program Files\Notepad++\Notepad++.exe" %*
:_end
@echo on