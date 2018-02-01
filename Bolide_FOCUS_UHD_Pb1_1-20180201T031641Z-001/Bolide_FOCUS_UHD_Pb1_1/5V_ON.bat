rem Set EasyAVRuntimeEnginePath=c:\Program Files\Common Files\Logitech\EasyAVRuntimeEngine\
Set PATH=%PATH%;"C:\Program Files\Kinetic\kinetic\"
RS232V6_line.exe COM1 "VOLT 12;CURR 1.5"
rem call "UltimateScpiCmd.exe" /option:send /scpicmd="output:state On"
rem call "UltimateScpiCmd.exe" /option:send /scpicmd="voltage 5"
rem call "UltimateScpiCmd.exe" /option:send /scpicmd="current 1"
ksleep 10000

lvreg testxu write 0x0a 0x08
ksleep 250
lvreg testxu write 0x0a 0x08
ksleep 250

lvreg eeprom write 0x86 0x00
ksleep 250
lvreg eeprom write 0x87 0x00
ksleep 250

lvreg register write 0x70c6 0x00
lvreg register write 0x2400 0x00
lvreg register write 0xdd0 0x00
lvreg register write 0xd27 0x00
lvreg register write 0xd29 0x00
lvreg pcxu write 0x09 0100012002

exit %Status%
