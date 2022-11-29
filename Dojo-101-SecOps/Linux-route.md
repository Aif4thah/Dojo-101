# route

Display Current Routing Table Using ip command
By using the ip command, you can set up and view static route. For example, to display the current routing table you can type the command:

## lister et ajouter

```shell
$ ip route show
Sample output:
192.168.2.0/24 dev eth1 proto kernel  scope link  src 192.168.2.1
192.168.1.0/24 dev eth0  proto kernel  scope link  src 192.168.1.2
default via 192.168.1.254 dev eth0You can add static route using following command:
ip route add {NETWORK} via {IP} dev {DEVICE}
For example network 192.168.55.0/24 available via 192.168.1.254:

$ ip route add 192.168.55.0/24 via 192.168.1.254 dev eth1

# Alternatively, you can use old good route command too:

$ route add -net 192.168.55.0 netmask 255.255.255.0 gw 192.168.1.254 dev eth1
```

