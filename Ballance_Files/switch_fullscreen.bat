@echo off

echo Note: if any problems are encountered, switch to CMD and run this file as admin.

set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )


reg query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set arch=32bit || set arch=64bit

if %arch%==64bit (
  set reg_path=HKLM\SOFTWARE\WOW6432Node\Ballance\Settings
  set reg_virtual_path=HKCR\VirtualStore\MACHINE\SOFTWARE\WOW6432Node\Ballance\Settings
) else (
  set reg_path=HKLM\SOFTWARE\Ballance\Settings
  set reg_virtual_path=HKCR\VirtualStore\MACHINE\SOFTWARE\Ballance\Settings
)


reg query %reg_virtual_path%
if %errorlevel% == 0 goto set_virtual_path
set settings_path=%reg_path%
goto query_reg

:set_virtual_path
set settings_path=%reg_virtual_path%

:query_reg
reg query %settings_path% /v Fullscreen | find "0x0"
if %errorlevel% == 1 goto off
if %errorlevel% == 0 goto on
goto end

:on
reg add %reg_path% /v Fullscreen /t REG_DWORD /f /d 1
reg add %reg_virtual_path% /v Fullscreen /t REG_DWORD /f /d 1
echo Switched on full screen.
goto end

:off
reg add %reg_path% /v Fullscreen /t REG_DWORD /f /d 0
reg add %reg_virtual_path% /v Fullscreen /t REG_DWORD /f /d 0
echo Switched off full screen.
goto end


:end
pause
exit