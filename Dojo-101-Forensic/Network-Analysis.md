# Traffic Réseau, Network Analysis

## Analyse via IA

* [Packet Safari](https://app.packetsafari.com/packetsafari)

## Windows

Wireshark in background :

```powershell
stop-Process -name tshark
cd 'C:\Program Files\Wireshark'
$name = (new-guid).ToString()
$name = "c:\test\${name}.pcap"
.\tshark.exe -i "Wi-fi" -w $name
```

Alternative sans Wireshark :

```powershell
PktMon.exe
```
