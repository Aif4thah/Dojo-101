# Volatility

## OS

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw imageinfo
 Volatile Systems Volatility Framework 2.0
           Suggested Profile(s) : WinXPSP3x86, WinXPSP2x86 (Instantiated with WinXPSP2x86)
                      AS Layer1 : JKIA32PagedMemory (Kernel AS)
                      AS Layer2 : FileAddressSpace (/root/Desktop/memdump.raw)
                       PAE type : No PAE
                            DTB : 0x39000
                           KDBG : 0x8054cde0L
                           KPCR : 0xffdff000L
              KUSER_SHARED_DATA : 0xffdf0000L
            Image date and time : 2012-05-09 11:06:48 
      Image local date and time : 2012-05-09 11:06:48 
           Number of Processors : 1
                     Image Type : Service Pack 3
```

## Processus

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw --profile=WinXPSP3x86 pslist
 Volatile Systems Volatility Framework 2.0
  Offset(V)  Name                 PID    PPID   Thds   Hnds   Time 
 ———- ——————– —— —— —— —— ——————- 
 0x812ed020 System                    4      0     55    231 1970-01-01 00:00:00       
 0x811cc5a0 smss.exe                368      4      3     19 2012-05-09 20:06:10       
 0xffbcada0 csrss.exe               584    368     10    368 2012-05-09 20:06:10       
 0xffb03310 winlogon.exe            608    368     25    539 2012-05-09 20:06:10       
 0xffb9d668 services.exe            652    608     21    270 2012-05-09 20:06:11       
 0xffaf5488 lsass.exe               664    608     25    359 2012-05-09 20:06:11       
 0xffb506e8 VBoxService.exe         820    652      8    106 2012-05-09 20:06:11       
 0xffb94368 svchost.exe             864    652     19    195 2012-05-09 11:06:12       
 0xffb02da0 svchost.exe             952    652     14    225 2012-05-09 11:06:12       
 0xffb175a0 svchost.exe            1044    652     65   1151 2012-05-09 11:06:12       
 0xffb3b7a0 svchost.exe            1092    652      5     60 2012-05-09 11:06:12       
 0xffaf17e0 svchost.exe            1124    652     11    170 2012-05-09 11:06:12       
 0xffb7b608 explorer.exe           1508   1484     21    556 2012-05-09 11:06:13       
 0x81121638 spoolsv.exe            1596    652     13    115 2012-05-09 11:06:13       
 0xffb4c978 VBoxTray.exe           1708   1508      6     57 2012-05-09 11:06:13       
 0xffbcf360 ctfmon.exe             1720   1508      1     93 2012-05-09 11:06:13       
 0x81129a48 PassKeep.exe           1864   1508      2     39 2012-05-09 11:06:17       
 0xffb22da0 PassKeep.exe           1872   1864      2    104 2012-05-09 11:06:17       
 0x8120cc08 svchost.exe            1972    652      5    106 2012-05-09 11:06:21       
 0xffb7a440 wscntfy.exe            1040   1044      1     39 2012-05-09 11:06:24       
 0x8113f910 alg.exe                1228    652      7    104 2012-05-09 11:06:24       
 0xffb43c08 DumpIt.exe              124   1508      1     25 2012-05-09 11:06:46

```

## Dump memoire

```sh
root@bt:/volatility# mkdir dumpFolder
 root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw memdump --profile=WinXPSP3x86 –dump-dir dumpFolder
 Volatile Systems Volatility Framework 2.0
 ************************************************************************
 Writing System [     4] to 4.dmp
 ************************************************************************
 Writing smss.exe [   368] to 368.dmp
 ************************************************************************
 Writing csrss.exe [   584] to 584.dmp
 ************************************************************************
 Writing winlogon.exe [   608] to 608.dmp
 …
 ```

## lister les DLL

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw --profile=WinXPSP3x86 dlllist –pid=124
 Volatile Systems Volatility Framework 2.0
 ************************************************************************
 DumpIt.exe pid:    124
 Command line : « C:\Documents and Settings\rootbsd\Desktop\DumpIt\DumpIt.exe » 
 Service Pack 3
Base         Size         Path
 0x00400000   0x035000     C:\Documents and Settings\rootbsd\Desktop\DumpIt\DumpIt.exe
 0x7c900000   0x0b2000     C:\WINXP\system32\ntdll.dll
 0x7c800000   0x0f6000     C:\WINXP\system32\kernel32.dll
 0x77dd0000   0x09b000     C:\WINXP\system32\ADVAPI32.dll
 0x77e70000   0x093000     C:\WINXP\system32\RPCRT4.dll
 0x77fe0000   0x011000     C:\WINXP\system32\Secur32.dll
 0x77f60000   0x076000     C:\WINXP\system32\SHLWAPI.dll
 0x77f10000   0x049000     C:\WINXP\system32\GDI32.dll
 0x7e410000   0x091000     C:\WINXP\system32\USER32.dll
 0x77c10000   0x058000     C:\WINXP\system32\msvcrt.dll
 0x76390000   0x01d000     C:\WINXP\system32\IMM32.DLL

 ```

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw --profile=WinXPSP3x86 dlldump -r ntdll -D pony
 Volatile Systems Volatility Framework 2.0
 Dumping ntdll.dll, Process: smss.exe, Base: 7c900000 output: module.368.10d45a0.7c900000.dll
 Dumping ntdll.dll, Process: csrss.exe, Base: 7c900000 output: module.584.3f69da0.7c900000.dll
 Dumping ntdll.dll, Process: winlogon.exe, Base: 7c900000 output: module.608.45fa310.7c900000.dll
 Dumping ntdll.dll, Process: services.exe, Base: 7c900000 output: module.652.40d8668.7c900000.dll
 Dumping ntdll.dll, Process: lsass.exe, Base: 7c900000 output: module.664.470a488.7c900000.dll
 Dumping ntdll.dll, Process: VBoxService.exe, Base: 7c900000 output: module.820.43296e8.7c900000.dll
 Dumping ntdll.dll, Process: svchost.exe, Base: 7c900000 output: module.864.4123368.7c900000.dll
 Dumping ntdll.dll, Process: svchost.exe, Base: 7c900000 output: module.952.45fbda0.7c900000.dll
 Dumping ntdll.dll, Process: svchost.exe, Base: 7c900000 output: module.1044.45a65a0.7c900000.dll
 Dumping ntdll.dll, Process: svchost.exe, Base: 7c900000 output: module.1092.46807a0.7c900000.dll
 Dumping ntdll.dll, Process: svchost.exe, Base: 7c900000 output: module.1124.498e7e0.7c900000.dll
 Dumping ntdll.dll, Process: explorer.exe, Base: 7c900000 output: module.1508.417c608.7c900000.dll
 Dumping ntdll.dll, Process: spoolsv.exe, Base: 7c900000 output: module.1596.1029638.7c900000.dll
 Dumping ntdll.dll, Process: VBoxTray.exe, Base: 7c900000 output: module.1708.436d978.7c900000.dll
 Dumping ntdll.dll, Process: ctfmon.exe, Base: 7c900000 output: module.1720.3f24360.7c900000.dll
 Dumping ntdll.dll, Process: PassKeep.exe, Base: 7c900000 output: module.1864.1031a48.7c900000.dll
 Dumping ntdll.dll, Process: PassKeep.exe, Base: 7c900000 output: module.1872.455bda0.7c900000.dll
 Dumping ntdll.dll, Process: svchost.exe, Base: 7c900000 output: module.1972.1114c08.7c900000.dll
 Dumping ntdll.dll, Process: wscntfy.exe, Base: 7c900000 output: module.1040.417d440.7c900000.dll
 Dumping ntdll.dll, Process: alg.exe, Base: 7c900000 output: module.1228.1047910.7c900000.dll
 Dumping ntdll.dll, Process: DumpIt.exe, Base: 7c900000 output: module.124.4378c08.7c900000.dll
root@bt:/volatility# cd pony
root@bt:/volatility/pony# ls
module.1040.417d440.7c900000.dll  module.1872.455bda0.7c900000.dll
 module.1044.45a65a0.7c900000.dll  module.1972.1114c08.7c900000.dll
 module.1092.46807a0.7c900000.dll  module.368.10d45a0.7c900000.dll
 module.1124.498e7e0.7c900000.dll  module.584.3f69da0.7c900000.dll
 module.1228.1047910.7c900000.dll  module.608.45fa310.7c900000.dll
 module.124.4378c08.7c900000.dll   module.652.40d8668.7c900000.dll
 module.1508.417c608.7c900000.dll  module.664.470a488.7c900000.dll
 module.1596.1029638.7c900000.dll  module.820.43296e8.7c900000.dll
 module.1708.436d978.7c900000.dll  module.864.4123368.7c900000.dll
 module.1720.3f24360.7c900000.dll  module.952.45fbda0.7c900000.dll
 module.1864.1031a48.7c900000.dll

 ```


## Connexion

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw connections
 Volatile Systems Volatility Framework 2.0
  Offset(V)  Local Address             Remote Address            Pid   
 ———- ————————- ————————- ——
 ```

## Ports

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw --profile=WinXPSP3x86 sockets
 Volatile Systems Volatility Framework 2.0
  Offset(V)  PID    Port   Proto               Address        Create Time               
 ———- —— —— ——————- ————– ————————– 
 0xffb44af0   1044    123     17 UDP            10.0.2.15          2012-05-09 11:06:21       
 0x81134960    664    500     17 UDP            0.0.0.0            2012-05-09 11:06:21       
 0xff9942e0   1228   1028      6 TCP            127.0.0.1          2012-05-09 11:06:24       
 0xffb4d390      4    445      6 TCP            0.0.0.0            2012-05-09 20:06:10       
 0xffbdc9d0    952    135      6 TCP            0.0.0.0            2012-05-09 11:06:12       
 0xff9cee98   1124   1900     17 UDP            10.0.2.15          2012-05-09 11:06:24       
 0x81132c08      4    139      6 TCP            10.0.2.15          2012-05-09 11:06:15       
 0x81132c08    664      0    255 Reserved       0.0.0.0            2012-05-09 11:06:21       
 0xffb0b5f8   1044    123     17 UDP            127.0.0.1          2012-05-09 11:06:21       
 0xffb80a90      4    137     17 UDP            10.0.2.15          2012-05-09 11:06:15       
 0xff9cfd98   1124   1900     17 UDP            127.0.0.1          2012-05-09 11:06:24       
 0xffaef008    664   4500     17 UDP            0.0.0.0            2012-05-09 11:06:21       
 0xffb4d008      4    445     17 UDP            0.0.0.0            2012-05-09 20:06:10       
 0xffb4d008      4    138     17 UDP            10.0.2.15          2012-05-09 11:06:15

 ```

## Registry

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw --profile=WinXPSP3x86 hivelist
 Volatile Systems Volatility Framework 2.0
 Virtual     Physical    Name
 0xe1ad3348  0x0a7e2348   \Device\HarddiskVolume1\Documents and Settings\rootbsd\Local  Settings\Application Data\Microsoft\Windows\UsrClass.dat
 0xe1a7db60  0x0a7c8b60  \Device\HarddiskVolume1\Documents and Settings\rootbsd\NTUSER.DAT
 0xe17ef738  0x09205738   \Device\HarddiskVolume1\Documents and Settings\LocalService\Local  Settings\Application Data\Microsoft\Windows\UsrClass.dat
 0xe17e7a28  0x09233a28  \Device\HarddiskVolume1\Documents and Settings\LocalService\NTUSER.DAT
 0xe17c5a60  0x08e04a60   \Device\HarddiskVolume1\Documents and Settings\NetworkService\Local  Settings\Application Data\Microsoft\Windows\UsrClass.dat
 0xe17beb60  0x08d76b60  \Device\HarddiskVolume1\Documents and Settings\NetworkService\NTUSER.DAT
 0xe14e4b60  0x02b36b60  \Device\HarddiskVolume1\WINXP\system32\config\software
 0xe145d008  0x070f1008  \Device\HarddiskVolume1\WINXP\system32\config\default
 0xe1455980  0x06f8f980  \Device\HarddiskVolume1\WINXP\system32\config\SECURITY
 0xe145d820  0x070f1820  \Device\HarddiskVolume1\WINXP\system32\config\SAM
 0xe135db60  0x01abdb60  [no name]
 0xe1019600  0x017b1600  \Device\HarddiskVolume1\WINXP\system32\config\system
 0xe1006030  0x016f4030  [no name]
 0x8068fdd8  0x0068fdd8  [no name]

```

On va maintenant lister les sous-clés de la ruche « \Device\HarddiskVolume1\WINXP\system32\config\SAM » :

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw --profile=WinXPSP3x86 hivedump -o 0xe145d820
 Volatile Systems Volatility Framework 2.0
 Last Written         Key
 2012-05-09 11:41:30  \SAM
 2012-05-09 11:41:30  \SAM\SAM
 2012-05-09 11:41:30  \SAM\SAM\Domains
 2012-05-09 18:50:39  \SAM\SAM\Domains\Account
 2012-05-09 18:47:12  \SAM\SAM\Domains\Account\Aliases
 2012-05-09 18:47:21  \SAM\SAM\Domains\Account\Aliases\000003E9
 2012-05-09 18:47:21  \SAM\SAM\Domains\Account\Aliases\Members
 2012-05-09 18:47:21  \SAM\SAM\Domains\Account\Aliases\Members\S-1-5-21-1078081533-1383384898-1060284298
 2012-05-09 18:47:21  \SAM\SAM\Domains\Account\Aliases\Members\S-1-5-21-1078081533-1383384898-1060284298\000003EA
 2012-05-09 18:47:12  \SAM\SAM\Domains\Account\Aliases\Names
 2012-05-09 18:47:12  \SAM\SAM\Domains\Account\Aliases\Names\HelpServicesGroup
 2012-05-09 11:41:30  \SAM\SAM\Domains\Account\Groups
 2012-05-09 18:50:39  \SAM\SAM\Domains\Account\Groups\00000201
 2012-05-09 11:41:30  \SAM\SAM\Domains\Account\Groups\Names
 2012-05-09 11:41:30  \SAM\SAM\Domains\Account\Groups\Names\None
 2012-05-09 18:50:39  \SAM\SAM\Domains\Account\Users
 2012-05-09 11:45:09  \SAM\SAM\Domains\Account\Users\000001F4
 2012-05-09 11:41:30  \SAM\SAM\Domains\Account\Users\000001F5
 2012-05-09 18:46:41  \SAM\SAM\Domains\Account\Users\000003E8
 2012-05-09 18:47:21  \SAM\SAM\Domains\Account\Users\000003EA
 2012-05-09 11:06:13  \SAM\SAM\Domains\Account\Users\000003EB
 2012-05-09 18:50:39  \SAM\SAM\Domains\Account\Users\Names
 2012-05-09 11:41:30  \SAM\SAM\Domains\Account\Users\Names\Administrator
 2012-05-09 11:41:30  \SAM\SAM\Domains\Account\Users\Names\Guest
 2012-05-09 18:46:41  \SAM\SAM\Domains\Account\Users\Names\HelpAssistant
 2012-05-09 18:50:39  \SAM\SAM\Domains\Account\Users\Names\rootbsd
 2012-05-09 18:47:21  \SAM\SAM\Domains\Account\Users\Names\SUPPORT_388945a0
 2012-05-09 18:50:39  \SAM\SAM\Domains\Builtin
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases
 2012-05-09 18:50:39  \SAM\SAM\Domains\Builtin\Aliases\00000220
 2012-05-09 11:42:17  \SAM\SAM\Domains\Builtin\Aliases\00000221
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\00000222
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\00000223
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\00000227
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\00000228
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\0000022B
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\0000022C
 2012-05-09 11:42:17  \SAM\SAM\Domains\Builtin\Aliases\Members
 2012-05-09 11:42:17  \SAM\SAM\Domains\Builtin\Aliases\Members\S-1-5
 2012-05-09 11:42:17  \SAM\SAM\Domains\Builtin\Aliases\Members\S-1-5\00000004
 2012-05-09 11:42:17  \SAM\SAM\Domains\Builtin\Aliases\Members\S-1-5\0000000B
 2012-05-09 18:50:39  \SAM\SAM\Domains\Builtin\Aliases\Members\S-1-5-21-1078081533-1383384898-1060284298
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Members\S-1-5-21-1078081533-1383384898-1060284298\000001F4
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Members\S-1-5-21-1078081533-1383384898-1060284298\000001F5
 2012-05-09 18:50:39  \SAM\SAM\Domains\Builtin\Aliases\Members\S-1-5-21-1078081533-1383384898-1060284298\000003EB
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Administrators
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Backup Operators
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Guests
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Network Configuration Operators
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Power Users
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Remote Desktop Users
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Replicator
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Aliases\Names\Users
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Groups
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Groups\Names
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Users
 2012-05-09 11:41:30  \SAM\SAM\Domains\Builtin\Users\Names
 2012-05-09 11:41:30  \SAM\SAM\RXACT
On peut également aller chercher des clés/sous-clés précises :
root@bt:/volatility# python  vol.py -f /root/Desktop/memdump.raw –profile=WinXPSP3x86 printkey -K  « Software\Microsoft\Windows\CurrentVersion\Internet Settings »
 Volatile Systems Volatility Framework 2.0
 Legend: (S) = Stable   (V) = Volatile
—————————-
 Registry: \Device\HarddiskVolume1\Documents and Settings\NetworkService\NTUSER.DAT
 Key name: Internet Settings (S)
 Last updated: 2012-05-09 18:49:25 
Subkeys:
   (S) 5.0
   (S) Lockdown_Zones
   (S) ZoneMap
   (S) Zones
Values:
 REG_SZ        User Agent      : (S) Mozilla/4.0 (compatible; MSIE 8.0; Win32)
 REG_SZ        IE5_UA_Backup_Flag : (S) 5.0
 REG_BINARY    ZonesSecurityUpgrade : (S) 
 0000   10 BC 89 23 14 2E CD 01                            …#….
REG_DWORD     EnableNegotiate : (S) 1
 —————————-
 Registry: \Device\HarddiskVolume1\Documents and Settings\rootbsd\NTUSER.DAT
 Key name: Internet Settings (S)
 Last updated: 2012-05-09 18:51:23 
Subkeys:
   (S) 5.0
   (S) CACHE
   (S) Connections
   (S) Lockdown_Zones
   (S) P3P
   (S) ZoneMap
   (S) Zones
Values:
 REG_SZ        User Agent      : (S) Mozilla/4.0 (compatible; MSIE 8.0; Win32)
 REG_SZ        IE5_UA_Backup_Flag : (S) 5.0
 REG_BINARY    ZonesSecurityUpgrade : (S) 
 0000   10 BC 89 23 14 2E CD 01                            …#….
REG_DWORD     EnableNegotiate : (S) 1
 REG_SZ        EmailName       : (S) IEUser@
 REG_SZ        AutoConfigProxy : (S) wininet.dll
 REG_SZ        MimeExclusionListForCache : (S) multipart/mixed multipart/x-mixed-replace multipart/x-byteranges 
 REG_BINARY    WarnOnPost      : (S) 
 0000   01 00 00 00                                        ….
REG_BINARY    UseSchannelDirectly : (S) 
 0000   01 00 00 00                                        ….
REG_DWORD     EnableHttp1_1   : (S) 1
 REG_DWORD     UrlEncoding     : (S) 0
 REG_DWORD     SecureProtocols : (S) 160
 REG_DWORD     PrivDiscUiShown : (S) 1
 REG_DWORD     PrivacyAdvanced : (S) 0
 REG_DWORD     DisableCachingOfSSLPages : (S) 0
 REG_DWORD     WarnonZoneCrossing : (S) 0
 REG_DWORD     MigrateProxy    : (S) 1
 REG_DWORD     ProxyEnable     : (S) 0
 —————————-
 Registry: \Device\HarddiskVolume1\WINXP\system32\config\default

```

## Credentials

```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw hashdump -y 0xe1019600 -s 0xe145d820
 Volatile Systems Volatility Framework 2.0
 ERROR   : psyco.support       : Unable to read hashes from registry
Pas de chance de ce côté, aucune information n’est disponible. On va  essayer via un dump du secret LSA. Pour cela, il faut remplacer  l’adresse de la ruche SAM par celle de SECURITY :
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw lsadump -y 0xe1019600 -s 0xe1455980
 Volatile Systems Volatility Framework 2.0
 ERROR   : psyco.support       : Unable to read LSA secrets from registry
Encore loupé, c’est pas notre jour ! ^_^
Aller, on ne se démotive pas et on va aller regarder les clés présentes dans la ruche « \Device\HarddiskVolume1\WINXP\system32\config\software » (pour rappel, l’adresse virtuelle est 0xe14e4b60) :
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw –profile=WinXPSP3x86 printkey –hive-offset 0xe14e4b60
 Volatile Systems Volatility Framework 2.0
 Legend: (S) = Stable   (V) = Volatile
—————————-
 Registry: User Specified
 Key name: $$$PROTO.HIV (S)
 Last updated: 2012-05-09 19:55:49 
Subkeys:
   (S) C07ft5Y
   (S) Classes
   (S) Clients
   (S) Gemplus
   (S) Licenses
   (S) Macromedia
   (S) Microsoft
   (S) ODBC
   (S) Oracle
   (S) Policies
   (S) Program Groups
   (S) Schlumberger
   (S) Secure
   (S) Software by Design
   (S) Windows 3.1 Migration Status

```


```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw –profile=WinXPSP3x86 printkey –hive-offset 0xe14e4b60 –key « GemPlus »
 Volatile Systems Volatility Framework 2.0
 Legend: (S) = Stable   (V) = Volatile
—————————-
 Registry: User Specified
 Key name: Gemplus (S)
 Last updated: 2012-05-09 18:47:28 
Subkeys:
   (S) Cryptography

```


 ```sh
root@bt:/volatility# python vol.py -f /root/Desktop/memdump.raw –profile=WinXPSP3x86 printkey –hive-offset 0xe14e4b60 –key « GemPlus\Cryptography »
 Volatile Systems Volatility Framework 2.0
 Legend: (S) = Stable   (V) = Volatile
—————————-
 Registry: User Specified
 Key name: Cryptography (S)
 Last updated: 2012-05-09 18:47:28 
Subkeys:
   (S) SmartCards
   ```


## retrouver le nom d'une machine (et fouiller dans la registry):

```sh
$ ./vol.py -f /data/downloads/ch2.dmp --profile=Win7SP0x86 hivelist
Volatility Foundation Volatility Framework 2.4
Virtual    Physical   Name
---------- ---------- ----
0x8ee66740 0x141c0740 \SystemRoot\System32\Config\SOFTWARE
0x90cab9d0 0x172ab9d0 \SystemRoot\System32\Config\DEFAULT
0x9670e9d0 0x1ae709d0 \??\C:\Users\John Doe\ntuser.dat
0x9670f9d0 0x04a719d0 \??\C:\Users\John Doe\AppData\Local\Microsoft\Windows\UsrClass.dat
0x9aad6148 0x131af148 \SystemRoot\System32\Config\SAM
0x9ab25008 0x14a61008 \SystemRoot\System32\Config\SECURITY
0x9aba79d0 0x11a259d0 \??\C:\Windows\ServiceProfiles\LocalService\NTUSER.DAT
0x9abb1720 0x0a7d4720 \??\C:\Windows\ServiceProfiles\NetworkService\NTUSER.DAT
0x8b20c008 0x039e1008 [no name]
0x8b21c008 0x039ef008 \REGISTRY\MACHINE\SYSTEM
0x8b23c008 0x02ccf008 \REGISTRY\MACHINE\HARDWARE
0x8ee66008 0x141c0008 \Device\HarddiskVolume1\Boot\BCD
```

Now, let's dump the registry key where the hostname will be revealed: 

```sh
$ ./vol.py -f /data/downloads/ch2.dmp --profile=Win7SP0x86 printkey -o 0x8b21c008 -K 'ControlSet001\Control\ComputerName\ComputerName'
Volatility Foundation Volatility Framework 2.4
Legend: (S) = Stable   (V) = Volatile

----------------------------
Registry: \REGISTRY\MACHINE\SYSTEM
Key name: ComputerName (S)
Last updated: 2013-01-12 00:58:30 UTC+0000

Subkeys:

Values:
REG_SZ                        : (S) mnmsrvc
REG_SZ        ComputerName    : (S) WIN-ETSA******
```

## Dumper les hash:

```sh
michael@k:~/Documents/Projets/RootMe/Forensic/ch2-2$ volatility -f ch2.dmp --profile=Win7SP1x86_23418 hivelist
Volatility Foundation Volatility Framework 2.6
Virtual    Physical   Name
---------- ---------- ----
0x8ee66740 0x141c0740 \SystemRoot\System32\Config\SOFTWARE
0x90cab9d0 0x172ab9d0 \SystemRoot\System32\Config\DEFAULT
0x9670e9d0 0x1ae709d0 \??\C:\Users\John Doe\ntuser.dat
0x9670f9d0 0x04a719d0 \??\C:\Users\John Doe\AppData\Local\Microsoft\Windows\UsrClass.dat
0x9aad6148 0x131af148 \SystemRoot\System32\Config\SAM
0x9ab25008 0x14a61008 \SystemRoot\System32\Config\SECURITY
0x9aba79d0 0x11a259d0 \??\C:\Windows\ServiceProfiles\LocalService\NTUSER.DAT
0x9abb1720 0x0a7d4720 \??\C:\Windows\ServiceProfiles\NetworkService\NTUSER.DAT
0x8b20c008 0x039e1008 [no name]
0x8b21c008 0x039ef008 \REGISTRY\MACHINE\SYSTEM
0x8b23c008 0x02ccf008 \REGISTRY\MACHINE\HARDWARE
0x8ee66008 0x141c0008 \Device\HarddiskVolume1\Boot\BCD

michael@k:~/Documents/Projets/RootMe/Forensic/ch2-2$ volatility -f ch2.dmp --profile=Win7SP1x86_23418 hashdump -y 0x8b21c008 -s 0x9aad6148
Volatility Foundation Volatility Framework 2.6
Administrator:500:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
John Doe:1000:aad3b435b51404eeaad3b435b51404ee:b9f917853e3dbf6e6831ecce60725930:::
```

## Trouver un malware:

```sh
volatility -f ch2.dmp --profile=Win7SP1x86_23418 pstree  ##regarder les process et process parents
Volatility Foundation Volatility Framework 2.6
Name                                                  Pid   PPid   Thds   Hnds Time
-------------------------------------------------- ------ ------ ------ ------ ----
 0x892ac2b8:wininit.exe                               456    396      3     77 2013-01-12 16:38:14 UTC+0000
. 0x896294c0:services.exe                             560    456      6    205 2013-01-12 16:38:16 UTC+0000
.. 0x89805420:svchost.exe                             832    560     19    435 2013-01-12 16:38:23 UTC+0000
... 0x87c90d40:audiodg.exe                           1720    832      5    117 2013-01-12 16:58:11 UTC+0000
.. 0x89852918:svchost.exe                             904    560     17    409 2013-01-12 16:38:24 UTC+0000
... 0x87ad44d0:dwm.exe                               2496    904      5     77 2013-01-12 16:40:25 UTC+0000
.. 0x898b2790:svchost.exe                            1172    560     15    475 2013-01-12 16:38:27 UTC+0000
.. 0x89f3d2c0:svchost.exe                            3352    560      9    141 2013-01-12 16:40:58 UTC+0000
.. 0x898fbb18:SearchIndexer.                         2900    560     13    636 2013-01-12 16:40:38 UTC+0000
.. 0x8986b030:svchost.exe                             928    560     26    869 2013-01-12 16:38:24 UTC+0000
.. 0x8a1d84e0:vmtoolsd.exe                           1968    560      6    220 2013-01-12 16:39:14 UTC+0000
.. 0x8962f030:svchost.exe                             692    560     10    353 2013-01-12 16:38:21 UTC+0000
.. 0x898911a8:svchost.exe                            1084    560     10    257 2013-01-12 16:38:26 UTC+0000
.. 0x898a7868:AvastSvc.exe                           1220    560     66   1180 2013-01-12 16:38:28 UTC+0000
.. 0x89f1d3e8:svchost.exe                            3624    560     14    348 2013-01-12 16:41:22 UTC+0000
.. 0x9542a030:TPAutoConnSvc.                         1612    560      9    135 2013-01-12 16:39:23 UTC+0000
... 0x87ae2880:TPAutoConnect.                        2568   1612      5    146 2013-01-12 16:40:28 UTC+0000
.. 0x88cded40:sppsvc.exe                             1872    560      4    143 2013-01-12 16:39:02 UTC+0000
.. 0x8a102748:svchost.exe                            1748    560     18    310 2013-01-12 16:38:58 UTC+0000
.. 0x8a0f9c40:spoolsv.exe                            1712    560     14    338 2013-01-12 16:38:58 UTC+0000
.. 0x9541c7e0:wlms.exe                                336    560      4     45 2013-01-12 16:39:21 UTC+0000
.. 0x8a1f5030:VMUpgradeHelpe                          448    560      4     89 2013-01-12 16:39:21 UTC+0000
... 0x892ced40:winlogon.exe                           500    448      3    111 2013-01-12 16:38:14 UTC+0000
... 0x88d03a00:csrss.exe                              468    448     10    471 2013-01-12 16:38:14 UTC+0000
.... 0x87c595b0:conhost.exe                          3228    468      2     54 2013-01-12 16:44:50 UTC+0000
.... 0x87a9c288:conhost.exe                          2600    468      1     35 2013-01-12 16:40:28 UTC+0000
.... 0x954826b0:conhost.exe                          2168    468      2     49 2013-01-12 16:55:50 UTC+0000
.. 0x87bd35b8:wmpnetwk.exe                           3176    560      9    240 2013-01-12 16:40:48 UTC+0000
.. 0x87ac0620:taskhost.exe                           2352    560      8    149 2013-01-12 16:40:24 UTC+0000
.. 0x897b5c20:svchost.exe                             764    560      7    263 2013-01-12 16:38:23 UTC+0000
. 0x8962f7e8:lsm.exe                                  584    456     10    142 2013-01-12 16:38:16 UTC+0000
. 0x896427b8:lsass.exe                                576    456      6    566 2013-01-12 16:38:16 UTC+0000
 0x8929fd40:csrss.exe                                 404    396      9    469 2013-01-12 16:38:14 UTC+0000
 0x87978b78:System                                      4      0    103   3257 2013-01-12 16:38:09 UTC+0000
. 0x88c3ed40:smss.exe                                 308      4      2     29 2013-01-12 16:38:09 UTC+0000
 0x87ac6030:explorer.exe                             2548   2484     24    766 2013-01-12 16:40:27 UTC+0000
. 0x87b6b030:iexplore.exe                            2772   2548      2     74 2013-01-12 16:40:34 UTC+0000
.. 0x89898030:cmd.exe                                1616   2772      2    101 2013-01-12 16:55:49 UTC+0000
. 0x95495c18:taskmgr.exe                             1232   2548      6    116 2013-01-12 16:42:29 UTC+0000
. 0x87bf7030:cmd.exe                                 3152   2548      1     23 2013-01-12 16:44:50 UTC+0000
.. 0x87cbfd40:winpmem-1.3.1.                         3144   3152      1     23 2013-01-12 16:59:17 UTC+0000
. 0x898fe8c0:StikyNot.exe                            2744   2548      8    135 2013-01-12 16:40:32 UTC+0000
. 0x87b784b0:AvastUI.exe                             2720   2548     14    220 2013-01-12 16:40:31 UTC+0000
. 0x87b82438:VMwareTray.exe                          2660   2548      5     80 2013-01-12 16:40:29 UTC+0000
. 0x87c6a2a0:swriter.exe                             3452   2548      1     19 2013-01-12 16:41:01 UTC+0000
.. 0x87ba4030:soffice.exe                            3512   3452      1     28 2013-01-12 16:41:03 UTC+0000
... 0x87b8ca58:soffice.bin                           3564   3512     12    400 2013-01-12 16:41:05 UTC+0000
. 0x9549f678:iexplore.exe                            1136   2548     18    454 2013-01-12 16:57:44 UTC+0000
.. 0x87d4d338:iexplore.exe                           3044   1136     37    937 2013-01-12 16:57:46 UTC+0000
. 0x87aa9220:VMwareUser.exe                          2676   2548      8    190 2013-01-12 16:40:30 UTC+0000
 0x95483d18:soffice.bin                              3556   3544      0 ------ 2013-01-12 16:41:05 UTC+0000


volatility -f ch2.dmp --profile=Win7SP1x86 malfind
Volatility Foundation Volatility Framework 2.6
Process: svchost.exe Pid: 1748 Address: 0x130000
Vad Tag: VadS Protection: PAGE_EXECUTE_READWRITE
Flags: CommitCharge: 11, MemCommit: 1, PrivateMemory: 1, Protection: 6

0x00130000  03 00 00 00 00 00 00 00 7c 56 ec 76 d0 98 e7 70   ........|V.v...p
0x00130010  6c 0e e9 70 00 00 00 00 02 00 00 00 6a 30 e9 5b   l..p........j0.[
0x00130020  56 d9 76 00 00 00 00 00 00 00 00 00 00 00 00 00   V.v.............
0x00130030  05 00 00 00 6a 30 68 70 1c ed 76 e9 43 56 d9 76   ....j0hp..v.CV.v

0x00130000 0300             ADD EAX, [EAX]
0x00130002 0000             ADD [EAX], AL
0x00130004 0000             ADD [EAX], AL
0x00130006 0000             ADD [EAX], AL
0x00130008 7c56             JL 0x130060
0x0013000a ec               IN AL, DX
0x0013000b 76d0             JBE 0x12ffdd
0x0013000d 98               CWDE
0x0013000e e770             OUT 0x70, EAX
0x00130010 6c               INS BYTE [ES:EDI], DX
0x00130011 0e               PUSH CS
0x00130012 e970000000       JMP 0x130087
0x00130017 0002             ADD [EDX], AL
0x00130019 0000             ADD [EAX], AL
0x0013001b 006a30           ADD [EDX+0x30], CH
0x0013001e e95b56d976       JMP 0x76ec567e
0x00130023 0000             ADD [EAX], AL
0x00130025 0000             ADD [EAX], AL
0x00130027 0000             ADD [EAX], AL
0x00130029 0000             ADD [EAX], AL
0x0013002b 0000             ADD [EAX], AL
0x0013002d 0000             ADD [EAX], AL
0x0013002f 00050000006a     ADD [0x6a000000], AL
0x00130035 306870           XOR [EAX+0x70], CH
0x00130038 1ced             SBB AL, 0xed
0x0013003a 76e9             JBE 0x130025
0x0013003c 43               INC EBX
0x0013003d 56               PUSH ESI
0x0013003e d9               DB 0xd9
0x0013003f 76               DB 0x76
<SNIP>


sudo cp /home/michael/Documents/Projets/Volatility_plugins/Psinfo/psinfo.py /usr/lib/python2.7/dist-packages/volatility/plugins
michael@k:~/Documents/Projets/RootMe/Forensic$ volatility -f ch2.dmp --profile=Win7SP1x86 psinfo -p 2772

#Nous voyons ici que ce n'est pas le chemin habituel pour iexplore.exe et que ce processus est parents d'un cmd.exe suspect
Process Information:
	Process: iexplore.exe PID: 2772
	Parent Process: explorer.exe PPID: 2548
	Creation Time: 2013-01-12 16:40:34 UTC+0000
	Process Base Name(PEB): iexplore.exe
	Command Line(PEB): "C:\Users\John Doe\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\iexplore.exe" 

VAD and PEB Comparison:
	Base Address(VAD): 0x400000
	Process Path(VAD): \Users\John Doe\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\iexplore.exe
	Vad Protection: PAGE_EXECUTE_WRITECOPY
	Vad Tag: Vad 

	Base Address(PEB): 0x400000
	Process Path(PEB): C:\Users\John Doe\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\iexplore.exe
	Memory Protection: PAGE_EXECUTE_WRITECOPY
	Memory Tag: Vad 

Similar Processes:
C:\Users\John Doe\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\iexplore.exe
	iexplore.exe(2772) Parent:explorer.exe(2548) Start:2013-01-12 16:40:34 UTC+0000
C:\Program Files\Internet Explorer\iexplore.exe
	iexplore.exe(3044) Parent:iexplore.exe(1136) Start:2013-01-12 16:57:46 UTC+0000
C:\Program Files\Internet Explorer\iexplore.exe
	iexplore.exe(1136) Parent:explorer.exe(2548) Start:2013-01-12 16:57:44 UTC+0000

Suspicious Memory Regions:
	0x260000(No PE/Possibly Code)  Protection: PAGE_EXECUTE_READWRITE  Tag: VadS
	0x270000(No PE/Possibly Code)  Protection: PAGE_EXECUTE_READWRITE  Tag: VadS
	0x3c0000(No PE/Possibly Code)  Protection: PAGE_EXECUTE_READWRITE  Tag: VadS
	0x778a0000(No PE/Possibly Code)  Protection: PAGE_EXECUTE_WRITECOPY  Tag: Vad 
```

## dumper le processus (dans un executable): 

```sh
volatility -f ch2.dmp --profile=Win7SP1x86 procdump -p 2772 --dump-dir .
Volatility Foundation Volatility Framework 2.6
Process(V) ImageBase  Name                 Result
---------- ---------- -------------------- ------
0x87b6b030 0x00400000 iexplore.exe         OK: executable.2772.exe
```

on peut ensuite le soumettre sur virus total ou l'éxecuter dans une VM d'analyse

## dumper la mémoire d'un processus:
```sh
volatility -f ch2.dmp --profile=Win7SP1x86 memdump -p 2168 --dump-dir .
```
on peut ensuite faire un string pour récuperer les commandes et chaines de caractère

## LISTER LES CONNECTIONS:

```sh
volatility -f ch2.dmp --profile=Win7SP1x86 netscan
```

## LISTER LES CONSOLES:

```sh
volatility -f ch2.dmp --profile=Win7SP1x86 consoles
```




