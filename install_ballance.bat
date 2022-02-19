@echo off


echo Notice: This batch file only works in CMD (not Powershell) with admin permission.
echo If you encounter any problems, switch to CMD and run this file as admin.


set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )


if not exist Ballance_Files\ (
  echo Error: installation folder not found.
  goto end
)


reg query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set arch=32bit || set arch=64bit

if %arch%==64bit (
  set reg_path=HKLM\SOFTWARE\WOW6432Node\Ballance\Settings
  set reg_virtual_path=HKCR\VirtualStore\MACHINE\SOFTWARE\WOW6432Node\Ballance\Settings
) else (
  set reg_path=HKLM\SOFTWARE\Ballance\Settings
  set reg_virtual_path=HKCR\VirtualStore\MACHINE\SOFTWARE\Ballance\Settings
)


set full_path=%~dp0
set installation_path=%full_path:~0,-1%


xcopy /e /k /h /i Ballance_Files\ .\
del /s /q Ballance_Files\
rmdir /s /q Ballance_Files


reg add %reg_path%
reg add %reg_virtual_path%
reg add %reg_path% /v Fullscreen /t REG_DWORD /f /d 1
reg add %reg_path% /v Language /t REG_DWORD /f /d 1
reg add %reg_path% /v ScrDir /t REG_SZ /f /d C:\Setup
reg add %reg_path% /v ScrDisc /t REG_SZ /f /d C:\
reg add %reg_path% /v SetupCommand /t REG_SZ /f /d "C:\Program Files\InstallShield Installation Information\{42E0783D-3BA4-454B-B58A-BF26E49EB7DE}\setup.exe"
reg add %reg_path% /v SrcDir /t REG_SZ /f /d C:\setup
reg add %reg_path% /v SrcDisc /t REG_SZ /f /d C:
reg add %reg_path% /v TargetDir /t REG_SZ /f /d %installation_path%
reg add %reg_path% /v VideoDriver /t REG_DWORD /f /d 0x04000300
reg add %reg_virtual_path% /v VideoDriver /t REG_DWORD /f /d 0x04000300
reg add %reg_path% /v VideoMode /t REG_DWORD /f /d 0
reg add %reg_virtual_path% /v VideoMode /t REG_DWORD /f /d 0


echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo strDesktop = oWS.SpecialFolders("Desktop") >> CreateShortcut.vbs
echo sLink = WScript.CreateObject("WScript.Shell").SpecialFolders("Desktop") >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLink + "\Ballance.lnk") >> CreateShortcut.vbs
echo oLink.WorkingDirectory = "%installation_path%" >> CreateShortcut.vbs
echo oLink.TargetPath = "%full_path%Startup.exe" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
echo Set oLinkPlayer = oWS.CreateShortcut(sLink + "\Ballance Player.lnk") >> CreateShortcut.vbs
echo oLinkPlayer.WorkingDirectory = "%full_path%bin" >> CreateShortcut.vbs
echo oLinkPlayer.TargetPath = "%full_path%bin\Player.exe" >> CreateShortcut.vbs
echo oLinkPlayer.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs


:end
