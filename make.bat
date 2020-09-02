set TARGET_DSK=disco.dsk

if exist %TARGET_DSK% del /f /Q %TARGET_DSK%
copy tools\Disk-Manager\main.dsk .\%TARGET_DSK%
rem añadimos todos los .bas de la carpeta objects al disco
rem por favor mirar for /?
for /R src/ %%a in (*.bas) do (
    start /wait tools/Disk-Manager/DISKMGR.exe -A -F -C %TARGET_DSK% "%%a")   

rem añadimos todos los arhivos binarios de la carpeta bin al disco
rem recuerda que un sc2, sc5, sc8 es también un archivo binario, renombralo
rem por favor mirar for /?
for /R bin/ %%a in (*.bin) do (
    start /wait tools/Disk-Manager/DISKMGR.exe -A -F -C %TARGET_DSK% "%%a")   


rem copy %TARGET_DSK% tools\emulators\BlueMSX
rem start /wait tools/emulators/BlueMSX/blueMSX.exe -diska %TARGET_DSK%
rem start /wait emulators/fMSX/fMSX.exe -diska %TARGET_DSK%
start /wait tools/emulators/openmsx/openmsx.exe -machine Philips_NMS_8255 -diska %TARGET_DSK%