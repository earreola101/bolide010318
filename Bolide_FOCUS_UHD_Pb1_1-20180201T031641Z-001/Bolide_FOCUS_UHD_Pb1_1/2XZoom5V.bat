Rem inside file:Test.bat
Rem SET RETRYNUM=1
Set EasyAVRuntimeEnginePath=c:\Program Files\Common Files\Logitech\EasyAVRuntimeEngine\
rem Set EasyAVRuntimeEnginePath=m:\video\Tools\Windows\VideoOnly\DirectShowDLL-Multiple\EasyVideoCOM\Tools\EasyVideoCmd\Build\Debug-Unicode\
Set Kinetic=C:\Program Files\kinetic\kinetic
Set PATH=%PATH%;%Kinetic%;%EasyAVRuntimeEnginePath%
Set RETRYNUM=0
REM -----Add TDE mode check-------

rem set /A RETRYNUM=%RETRYNUM%+1
LVREG.EXE testxu write 0x0a 0x08
:recheck
set /A RETRYNUM=%RETRYNUM%+1
EasyVideoCmd.exe /Option:Set /Device:"USB Video Device" /Property:"Focus" /Cur:3 /Duration:1000
if %errorlevel% == 0 (
    echo Device can focus or zoom
) else (
   REM TIMEOUT /T 5
   echo Device can't focus or zoom
   call "UltimateScpiCmd.exe" /option:send /scpicmd="output:state off"
   ping -n 2 127.0.0.1>nul
   call "UltimateScpiCmd.exe" /option:send /scpicmd="output:state on"
   call "UltimateScpiCmd.exe" /option:send /scpicmd="voltage 5"
   call "UltimateScpiCmd.exe" /option:send /scpicmd="current 1.2"
   ping -n 15 127.0.0.1>nul
   REM set /A RETRYNUM=%RETRYNUM%+1
   IF %RETRYNUM% GTR 3 GOTO END
    goto recheck
)
ping -n 2 127.0.0.1>nul
EasyVideoCmd.exe /Option:Set /Device:"USB Video Device" /Property:"ZOOM" /Cur:0 /Duration:1000
ping -n 2 127.0.0.1>nul
Set RETRYNUM=0
:recheck1
set /A RETRYNUM=%RETRYNUM%+1
EasyVideoCmd.exe /Option:Set /Device:"USB Video Device" /Property:"ZOOM" /Cur:200 /Duration:1000
if %errorlevel% == 0 (
    echo Device can focus or zoom
) else (
   REM TIMEOUT /T 5
   echo Device can't focus or zoom
   call "UltimateScpiCmd.exe" /option:send /scpicmd="output:state off"
   ping -n 2 127.0.0.1>nul
   call "UltimateScpiCmd.exe" /option:send /scpicmd="output:state on"
   call "UltimateScpiCmd.exe" /option:send /scpicmd="voltage 5"
   call "UltimateScpiCmd.exe" /option:send /scpicmd="current 1.2"
   ping -n 15 127.0.0.1>nul
   REM set /A RETRYNUM=%RETRYNUM%+1
   IF %RETRYNUM% GTR 3 GOTO END
    goto recheck1
)
ping -n 2 127.0.0.1>nul
EXIT 0

