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

---

*Dojo-101 — [🏠 Sommaire principal](../README.md) • [📂 Sommaire du thème](./README.md) • [💖 Soutenir ce projet sur GitHub Sponsors](https://github.com/sponsors/Aif4thah/)*
