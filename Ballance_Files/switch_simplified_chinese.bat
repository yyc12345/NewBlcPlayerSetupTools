@echo off

if exist Languages\ (
  if exist "3D Entities\" (
    if exist Text\ (
      goto test_languages
    )
  )
)

echo Error: installation not found.
goto end


:test_languages
if exist Languages\cn\ (
  set origin=Languages\cn\
  set replaced=Languages\en\
  if exist Languages\en\ (
    goto error_bad_installation
  )
  goto swap_languages
)
if exist Languages\en\ (
  set origin=Languages\en\
  set replaced=Languages\cn\
  if exist Languages\cn\ (
    goto error_bad_installation
  )
  goto swap_languages
)
goto error_bad_installation


:swap_languages
mkdir %replaced%
for %%f in ("3D Entities\Tutorial.nmo", "3D Entities\Menulevel.nmo", "3D Entities\Menu.nmo", "3D Entities\Language.nmo") do xcopy /e /k /h /i /y %%f "%replaced%3D Entities\"
xcopy /e /k /h /i /y Text\* %replaced%Text\

xcopy /e /k /h /i /y %origin%* .\

del /s /q %origin%
rmdir /s /q %origin%

if (%origin% == Languages\cn\) echo Switched to Simplified Chinese.
if (%origin% == Languages\en\) echo Switched to English.
goto end


:error_bad_installation
echo Error: bad installation.


:end
pause
