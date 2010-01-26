@echo off

:: TODO: If we have strawberry perl, add that to the PATH
:: TODO: If we have MSVC, set that up
set WKPROJECTS=%HOMEDIR%\projects
if "x%*x" == "xx" goto no_args
if "%*" == none goto unset_project
set WKPROJECT="%*"

if exist "%WKPROJECTS%\$WKPROJECT" goto found_project
goto project_not_found

:found_project
prompt $_$$$T$G$S
color 17
echo %WKPROJECT Directory
cd
goto exit_ok

:project_not_found
echo Could not find project %WKPROJECT%
goto exit_ok

:unset_project
prompt $P$G
color 07
goto exit_ok

:no_args
prompt $_$$$T$G$S
color 17
goto exit_ok

:exit_ok
@echo on
