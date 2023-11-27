@echo off

echo Notice: This batch file only works in CMD (not Powershell) with admin permission.
echo If you encounter any problems, switch to CMD and run this file as admin.
echo -----------------------------------

set "reply1=n"
set "reply2=n"
set /p "reply1=Are you sure to uninstall Ballance? [y/N]: "
if /i not "%reply1%" == "y" goto :abort
set /p "reply2=This will completely remove anything that's in the Ballance folder. [y/N]: "
if /i not "%reply2%" == "y" goto :abort

set "params=%*"
set _sdp0=%~sdp0%
set _s0=%~s0%
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%_sdp0%"" && ""%_s0% %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )


if exist Startup.exe (
  if exist base.cmo (
    goto uninstallation
  )
)


echo Error: installation not found.
goto end


:uninstallation

set installation_path=%cd%
cd ..\
rmdir /s /q "%installation_path%"


:abort
echo Uninstallation aborted.

:end
pause
exit
