@echo off

echo Notice: This batch file only works in CMD (not Powershell) with admin permission.
echo If you encounter any problems, switch to CMD and run this file as admin.
echo -----------------------------------


if exist Startup.exe (
  if exist base.cmo (
    goto uninstallation
  )
)


echo Error: installation not found.
goto end


:uninstallation

reg query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set arch=32bit || set arch=64bit

if %arch%==64bit (
  set reg_path=HKLM\SOFTWARE\WOW6432Node\Ballance\Settings
) else (
  set reg_path=HKLM\SOFTWARE\Ballance\Settings
)


del /s /q .\
set installation_path=%cd%
cd ..\
rmdir /s /q %installation_path%


reg delete %reg_path%


:end
