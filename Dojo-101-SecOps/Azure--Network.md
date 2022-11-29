

VPN Gtw:
    Connect on-premises datacenters to Azure virtual networks through a site-to-site connection.
    Connect individual devices to Azure virtual networks through a point-to-site connection.
    Connect Azure virtual networks to other Azure virtual networks through a network-to-network connect

VPN Type:
    Policy Based:
        Support for IKEv1 only.
        Use of static routing, where combinations of address prefixes from both networks control how traffic is encrypted and decrypted through the VPN tunnel. The source and destination of the tunneled networks are declared in the policy and don't need to be declared in routing tables.
        Policy-based VPNs must be used in specific scenarios that require them, such as for compatibility with legacy on-premises VPN devices.
    Route Based (Prefered):
      usage:
        Connections between virtual networks
        Point-to-site connections
        Multisite connections
        Coexistence with an Azure ExpressRoute gateway

      Key features:
        Supports IKEv2.
        Uses any-to-any (wildcard) traffic selectors.
        Can use dynamic routing protocols, where routing/forwarding tables direct traffic to different IPSec tunnels. In this case, the source and destination networks are not statically defined as they are in policy-based VPNs or even in route-based VPNs with static routing. Instead, data packets are encrypted based on network routing tables that are created dynamically using routing protocols such as BGP (Border Gateway Protocol).

    Proto: PSK + IKE (1 ou 2) + IPSEC

    TABLE 1
        SKU	Site-to-site/VNet-to-VNet tunnels	Aggregate throughput benchmark	Border Gateway Protocol (BGP) support
        Basic*	Maximum: 10	100 Mbps	Not supported
        VpnGw1/Az	Maximum: 30	650 Mbps	Supported
        VpnGw2/Az	Maximum: 30	1 Gbps	Supported
        VpnGw3/Az	Maximum: 30	1.25 Gbps	Supported

Deployment required Azure Ressources:

    Virtual network.
    GatewaySubnet (subnet called "GatewaySubnet"
    Public IP
    Local Network Gtw (Defined on-premise network conf)
    Virtual Network Gtw
    Connection

HA scénario: Active/StandBy  - Active/Active

exercice
==================

Run this command in Azure Cloud Shell to create the Azure-VNet-1 virtual network and the Services subnet.

az network vnet create \
    --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
    --name Azure-VNet-1 \
    --address-prefix 10.0.0.0/16 \
    --subnet-name Services \
    --subnet-prefix 10.0.0.0/24



add the GatewaySubnet subnet to Azure-VNet-1.

az network vnet subnet create \
    --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
    --vnet-name Azure-VNet-1 \
    --address-prefix 10.0.255.0/27 \
    --name GatewaySubnet

create the LNG-HQ-Network local network gateway -  represents the on-premises network that you're connecting to

az network local-gateway create \
    --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
    --gateway-ip-address 94.0.252.160 \
    --name LNG-HQ-Network \
    --local-address-prefixes 172.16.0.0/16

verify: az network vnet list --output table

Name          ResourceGroup                               Location    NumSubnets    Prefixes       DnsServers    DDOSProtection    VMProtection
------------  ------------------------------------------  ----------  ------------  -------------  ------------  ----------------  --------------
Azure-VNet-1  learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba  westus      2             10.0.0.0/16                  False             False

vaca@Azure:~$ az network local-gateway list \
>     --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
>     --output table
Name              Location    ResourceGroup                               ProvisioningState    GatewayIpAddress    AddressPrefixes
----------------  ----------  ------------------------------------------  -------------------  ------------------  -----------------
LNG-HQ-Network    westus      learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba  Succeeded            94.0.252.160        172.16.0.0/16


create the PIP-VNG-Azure-VNet-1 public IP address.
    az network public-ip create \
    --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
    --name PIP-VNG-Azure-VNet-1 \
    --allocation-method Dynamic

 create the VNG-Azure-VNet-1 virtual network gateway

az network vnet-gateway create \
    --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
    --name VNG-Azure-VNet-1 \
    --public-ip-address PIP-VNG-Azure-VNet-1 \
    --vnet Azure-VNet-1 \
    --gateway-type Vpn \
    --vpn-type RouteBased \
    --sku VpnGw1 \
    --no-wait

Verifying deployment of VPN Gtw: 
    az network vnet-gateway list \
        --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
        --output table


Run this command in Cloud Shell to update the LNG-HQ-Network local network gateway so that it points to 
the public IP address attached to the VNG-HQ-Network virtual network gateway.

    az network local-gateway update \
        --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
        --name LNG-HQ-Network \
        --gateway-ip-address $PIPVNGHQNETWORK


Connection:

    az network vpn-connection create \
        --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
        --name Azure-VNet-1-To-HQ-Network \
        --vnet-gateway1 VNG-Azure-VNet-1 \
        --shared-key <128 char> \
        --local-gateway2 LNG-HQ-Network

Verification:

    az network vpn-connection show \
    --resource-group learn-f73286d1-cde3-419a-bb25-fee4cec5f7ba \
    --name Azure-VNet-1-To-HQ-Network  \
    --output table \
    --query '{Name:name,ConnectionStatus:connectionStatus}'


Express Route:

    Connectivity model:
        CloudExchange co-location: L2 et L3, located in the co-location facilitiy
        Point-to-point Ethernet connection :L2 et L3 on premise <-> Microsoft Azure
        Any-to-any connection : L3 Azure will integrate with your WAN connection to provide a seamless connection, just like you would have between your datacenter and any branch offices.

    Microsoft Peering:pour O365

     99.95 percent availability for an ExpressRoute dedicated circuit.

NSG:
    archi: VNet
                NSG
                    subnet
                        NSG 
                            VM

    Network security groups are assigned to a network interface or a subnet

    Security rules:

        Property	Explanation
        Name	A unique name within the network security group.
        Priority	A number between 100 and 4096.
        Source or destination	Any, or an individual IP address, classless inter-domain routing (CIDR) block (10.0.0.0/24, for example), service tag, or application security group.
        Protocol	TCP, UDP, or Any.
        Direction	Whether the rule applies to inbound, or outbound traffic.
        Port range	An individual port or range of ports.
        Action	Allow or deny the traffic.

    The default rules for inbound traffic are:

        TABLE 2
        Priority	Rule name	Description
        65000	AllowVnetInbound	Allow inbound coming from any VM to any VM within the subnet.
        65001	AllowAzureLoadBalancerInbound	Allow traffic from the default load balancer to any VM within the subnet.
        65500	DenyAllInBound	Deny traffic from any external source to any of the VMs.
        The default rules for outbound traffic are:

        TABLE 3
        Priority	Rule name	Description
        65000	AllowVnetOutbound	Allow outbound going from any VM to any VM within the subnet.
        65001	AllowInternetOutbound	Allow outbound traffic going to the internet from any VM.
        65500	DenyAllOutBound	Deny traffic from any internal VM to a system outside the virtual network.


    Création NSG: 
        Créer un groupe de ressources:
        rg=<resource group name>
        az group create --name $rg --location <location>

        Créer VNET:

        az network vnet create \
        --resource-group $rg \
        --name ERP-servers \
        --address-prefix 10.0.0.0/16 \
        --subnet-name Applications \
        --subnet-prefix 10.0.0.0/24

        Creer Subnet:
        az network vnet subnet create \
        --resource-group $rg \
        --vnet-name ERP-servers \
        --address-prefix 10.0.1.0/24 \
        --name Databases

        Creer NSG:
        az network nsg create \
        --resource-group $rg \
        --name ERP-SERVERS-NSG

        add a NIC to a NSG:

        az vm create \
            --resource-group $rg \
            --name AppServer \
            --vnet-name ERP-servers \
            --subnet Applications \
        --nsg ERP-SERVERS-NSG \
            --image UbuntuLTS \
            --size Standard_DS1_v2 \
            --admin-username azureuser \
            --custom-data cloud-init.yml \
            --no-wait \
            --admin-password <password>

        Creer Security rules:
        az network nsg rule create \
            --resource-group $rg \
            --nsg-name ERP-SERVERS-NSG \
            --name httpRule \
            --direction Inbound \
            --priority 150 \
            --source-address-prefixes 10.0.1.4 \
            --source-port-ranges '*' \
            --destination-address-prefixes 10.0.0.4 \
            --destination-port-ranges 80 \
            --access Deny \
            --protocol Tcp \
            --description "Deny from DataServer to AppServer on port 80"


Application Security Group (ASG)

    az network asg create \
    --resource-group $rg \
    --name ERP-DB-SERVERS-ASG

    associer un server à ASG:
    az network nic ip-config update \
    --resource-group $rg \
    --application-security-groups ERP-DB-SERVERS-ASG \
    --name ipconfigDataServer \
    --nic-name DataServerVMNic \
    --vnet-name ERP-servers \
    --subnet Databases

    créer un regles NGS qui se réfaire au group ASG
    az network nsg rule update \
    --resource-group $rg \
    --nsg-name ERP-SERVERS-NSG \
    --name httpRule \
    --direction Inbound \
    --priority 150 \
    --source-address-prefixes "" \
    --source-port-ranges '*' \
    --source-asgs ERP-DB-SERVERS-ASG \
    --destination-address-prefixes 10.0.0.4 \
    --destination-port-ranges 80 \
    --access Deny \
    --protocol Tcp \
    --description "Deny from DataServer to AppServer on port 80 using application security group"



Service EndPoint:

    Use virtual network service endpoints to extend your private address space in Azure by providing a direct connection to your Azure services. 
    Service endpoints let you secure your Azure resources to only your virtual network. Service traffic will remain on the Azure backbone, 
    and doesn't go out to the internet.

    Azure service endpoints are available for many services, such as:

    Azure Storage
    Azure SQL Database
    Azure Cosmos DB
    Azure Key Vault
    Azure Service Bus
    Azure Data Lake

    To enable a service endpoint, you must do two things:

        Turn off public access to the service.
        Add the service endpoint to a virtual network.

    When you enable a service endpoint, you restrict the flow of traffic, and allow your Azure virtual machines to access the service 
    directly from your private address space. Devices cannot access the service from a public network. 
    On a deployed virtual machine vNIC, if you look at Effective routes, you'll notice the service endpoint as the Next Hop Type.


    assign the Microsoft.Storage endpoint to the subnet.
    az network vnet subnet update \
    --vnet-name ERP-servers \
    --resource-group $rg \
    --name Databases \
    --service-endpoints Microsoft.Storage

    deny all access to change the default action to Deny. After network access is denied, the storage account is not accessible from any network.
    az storage account update \
    --resource-group $rg \
    --name $STORAGEACCT \
    --default-action Deny

    restrict access to the storage account. By default, storage accounts are open to accept all traffic. 
    You want only traffic from the Databases subnet to be able to access the storage.
    az storage account network-rule add \
    --resource-group $rg \
    --account-name $STORAGEACCT \
    --vnet ERP-servers \
    --subnet Databases


Network Peering:
    traffic use only private ip Address

    type:
        Virtual Network peering: Vnet in same region
        Global virtual network peering: differents region

    Virtual network peering is nontransitive. Only virtual networks that are directly peered can communicate with each other. The virtual networks can't communicate with the peers of their peers.
    Sauf avec configuration d'une Gateway

creation Vnet Peering:

    az network vnet peering create \
    --name MarketingVNet-To-ResearchVNet \
    --remote-vnet ResearchVNet \
    --resource-group learn-f640a4fb-d052-43f2-af2a-cf16fd66db64 \
    --vnet-name MarketingVNet \
    --allow-vnet-access

    az network vnet peering create \
    --name ResearchVNet-To-MarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group learn-f640a4fb-d052-43f2-af2a-cf16fd66db64 \
    --vnet-name ResearchVNet \
    --allow-vnet-access

cheek Network peering:

    az network vnet peering list \
    --resource-group learn-f640a4fb-d052-43f2-af2a-cf16fd66db64 \
    --vnet-name SalesVNet \
    --output table

roote apply on nic:

        vaca@Azure:~$ az network nic show-effective-route-table \
        >     --resource-group learn-f640a4fb-d052-43f2-af2a-cf16fd66db64 \
        >     --name SalesVMVMNic \
        >     --output table
        Source    State    Address Prefix    Next Hop Type    Next Hop IP
        --------  -------  ----------------  ---------------  -------------
        Default   Active   10.1.0.0/16       VnetLocal
        Default   Active   10.2.0.0/16       VNetPeering
        Default   Active   0.0.0.0/0         Internet
        Default   Active   10.0.0.0/8        None
        Default   Active   100.64.0.0/10     None
        Default   Active   192.168.0.0/16    None

recuperer les IP des VM:

    vaca@Azure:~$ az vm list \
    >     --resource-group learn-f640a4fb-d052-43f2-af2a-cf16fd66db64 \
    >     --query "[*].{Name:name, PrivateIP:privateIps, PublicIP:publicIps}" \
    >     --show-details \
    >     --output table
    Name         PrivateIP    PublicIP
    -----------  -----------  --------------
    MarketingVM  10.2.1.4     52.169.0.91
    SalesVM      10.1.1.4     52.178.164.208
    ResearchVM   10.3.1.4     52.232.69.242


Traffice Manager:
    Traffice Manager Endpoints:

        Azure endpoints are used for services hosted in Azure. These can be services like Azure App Service, as well as public IP resources that are associated with load balancers or virtual machines.
        
        External endpoints are used for IPv4/IPv6 addresses, FQDNs, or for services hosted outside Azure that can either be on-premises or with a different hosting provider.
        
        Nested endpoints are used to combine Traffic Manager profiles to create more flexible traffic-routing schemes to support the needs of larger, more complex deployments.

    Traffic Manager Methods:

        Notes: le traffic Manager effectue en fait des réponse DNS = DNS load Balancer

        Weighted: int 1..1000 connection not through traffic Manager
        Performance routing: latencies, connection not through traffic Manager
        Géographic routing: DNS queries origine, connection not through traffic Manager
        Multiware rooting: retries to other endpoints, connection not through traffic Manager
        Subnet routing: Maps IP range within Traffic Manager, connection not through traffic Manager
        Priority routing: highest priority if status == online


Traffic Manager Création:  

    #priority
    az network traffic-manager profile create \
    --resource-group learn-30a1a602-562b-40e2-a983-0293ea64fa4d \
    --name TM-MusicStream-Priority \
    --routing-method Priority \
    --unique-dns-name TM-MusicStream-Priority-$RANDOM

    performance rooting:
        az network traffic-manager profile create \
    --resource-group learn-30a1a602-562b-40e2-a983-0293ea64fa4d \
    --name TM-MusicStream-Performance \
    --routing-method Performance \
    --unique-dns-name TM-MusicStream-Performance-$RANDOM \
    --output table

Add a endpoints to traffic Manager:

        WestId=$(az network public-ip show \
            --resource-group learn-30a1a602-562b-40e2-a983-0293ea64fa4d \
            --name westus2-vm-nic-pip \
            --query id \
            --out tsv)

        az network traffic-manager endpoint create \
            --resource-group learn-30a1a602-562b-40e2-a983-0293ea64fa4d \
            --profile-name TM-MusicStream-Priority \
            --name "Primary-WestUS" \
            --type azureEndpoints \
            --priority 1 \
            --target-resource-id $WestId

        EastId=$(az network public-ip show \
            --resource-group learn-30a1a602-562b-40e2-a983-0293ea64fa4d \
            --name eastasia-vm-nic-pip \
            --query id \
            --out tsv)

        az network traffic-manager endpoint create \
            --resource-group learn-30a1a602-562b-40e2-a983-0293ea64fa4d \
            --profile-name TM-MusicStream-Priority \
            --name "Failover-EastAsia" \
            --type azureEndpoints \
            --priority 2 \
            --target-resource-id $EastId

Lister les Endpoints du traffic manager:

        az network traffic-manager endpoint list \
            --resource-group learn-30a1a602-562b-40e2-a983-0293ea64fa4d \
            --profile-name TM-MusicStream-Priority \
            --output table

Azure Load Balancer:

    Use hash based distribution algorithm with 5 elements - 5 tuple hash:
        Source IP: The IP address of the requesting client.
        Source port: The port of the requesting client.
        Destination IP: The destination IP of the request.
        Destination port: The destination port of the request.
        Protocol type: The specified protocol type, TCP or UDP.

    Availability sets: gestion des machines / service
    Availability zone: group d'un ou pluisieurs datacentre

    
    2 products:
            Basic load balancers allow:

                Port forwarding
                Automatic reconfiguration
                Health probes
                Outbound connections through source network address translation (SNAT)
                Diagnostics through Azure Log Analytics for public-facing load balancers
                Basic load balancers can be used only with availability sets.

            Standard load balancers support all of the basic features. They also allow:

                HTTPS health probes
                Availability zones
                Diagnostics through Azure Monitor, for multidimensional metrics
                High availability (HA) ports
                Outbound rules
                A guaranteed SLA (99.99% for two or more virtual machines)

    modes:
        5 tuple hash (default) !incompatible avec Remote Desktop Gateway or media upload

        2 tuple hash (source IP + dest IP) - aka session affinity or client IP affinity.
        The hash ensures that requests from a specific client are always sent to the same virtual machine behind the load balancer
            $lb = Get-AzLoadBalancer -Name MyLb -ResourceGroupName MyResourceGroup
            $lb.LoadBalancingRules[0].LoadDistribution = 'sourceIp'
            Set-AzLoadBalancer -LoadBalancer $lb

        LB public
        LB interne: toutes les machines derriere le LB doivent etre dans le meme subnet


Aplication Gateway: (work at layer 7)

    Path-based routing: ex "/site1/*"

    Multiple site hosting ex: https://contoso.com

    Others capabilities:
        Redirection - Redirection can be used to another site, or from HTTP to HTTPS.
        Rewrite HTTP headers - HTTP headers allow the client and server to pass additional information with the request or the response.
        Custom error pages - Application Gateway allows you to create custom error pages instead of displaying default error pages. You can use your own branding and layout using a custom error page.

    Load balancing: Application Gateway will automatically load balance requests sent to the servers in each back-end pool using a round-robin mechanism. However, you can configure session stickiness

There are currently two versions of Application Gateway: v1 and v2. They have similar capabilities but have slightly different implementation details. The v2 version provides additional features and performance improvements.


    

Configure the network for Application Gateway:

az network vnet subnet create \
  --resource-group $rg \
  --vnet-name vehicleAppVnet  \
  --name appGatewaySubnet \
  --address-prefixes 10.0.0.0/24

az network public-ip create \
  --resource-group $rg \
  --name appGatewayPublicIp \
  --sku Standard \
  --dns-name vehicleapp${RANDOM}

az network application-gateway create \
--resource-group $rg \
--name vehicleAppGateway \
--sku WAF_v2 \
--capacity 2 \
--vnet-name vehicleAppVnet \
--subnet appGatewaySubnet \
--public-ip-address appGatewayPublicIp \
--http-settings-protocol Http \
--http-settings-port 8080 \
--frontend-port 8080

az network application-gateway address-pool create \
  --gateway-name vehicleAppGateway \
  --resource-group $rg \
  --name vmPool \
  --servers $WEBSERVER1IP $WEBSERVER2IP

Front end port:
az network application-gateway frontend-port create \
    --resource-group $rg \
    --gateway-name vehicleAppGateway \
    --name port80 \
    --port 80

az network application-gateway http-listener create \
    --resource-group $rg \
    --name vehicleListener \
    --frontend-port port80 \
    --gateway-name vehicleAppGateway

=========================

Configuration de l'application Gtw:

applicationGtw <-> backend pool

    az network application-gateway address-pool create \
  --resource-group $rgName \
  --gateway-name gw-shipping \
  --name ap-backend \
  --servers $privateip


   az network application-gateway root-cert create \
  --resource-group $rgName \
  --gateway-name gw-shipping \
  --name shipping-root-cert \
  --cert-file server-config/shipping-ssl.crt

   export rgID="$(az group show --name $rgName --query id --output tsv)"

az network application-gateway http-settings update \
    --resource-group $rgName \
    --gateway-name gw-shipping \
    --name https-settings \
    --set trustedRootCertificates='[{"id": "'$rgID'/providers/Microsoft.Network/applicationGateways/gw-shipping/trustedRootCertificates/shipping-root-cert"}]'

    Run the following commands to set the trusted certificate for the backend pool to the certificate installed on the backend VM.

    export rgID="$(az group show --name $rgName --query id --output tsv)"

    az network application-gateway http-settings update \
        --resource-group $rgName \
        --gateway-name gw-shipping \
        --name https-settings \
        --set trustedRootCertificates='[{"id": "'$rgID'/providers/Microsoft.Network/applicationGateways/gw-shipping/trustedRootCertificates/shipping-root-cert"}]'

client <-> applicationGtw


    az network application-gateway frontend-port create \
    --resource-group $rgName \
    --gateway-name gw-shipping \
    --name https-port \
    --port 443


    az network application-gateway ssl-cert create \
   --resource-group $rgName \
   --gateway-name gw-shipping \
   --name appgateway-cert \
   --cert-file server-config/appgateway.pfx \
   --cert-password somepassword


    az network application-gateway http-listener create \
  --resource-group $rgName \
  --gateway-name gw-shipping \
  --name https-listener \
  --frontend-port https-port \
  --ssl-cert appgateway-cert

  az network application-gateway rule create \
    --resource-group $rgName \
    --gateway-name gw-shipping \
    --name https-rule \
    --address-pool ap-backend \
    --http-listener https-listener \
    --http-settings https-settings \
    --rule-type Basic

    

===========================

Address prefix	Next hop type
Unique to the virtual network	Virtual network
0.0.0.0/0	Internet
10.0.0.0/8	None
172.16.0.0/12	None
192.168.0.0/16	None
100.64.0.0/10	None


Azure Routing

        S'appui sur le capabilities:
        Virtual network peering
        Service chaining
        Virtual network gateway
        Virtual network service endpoint

Create a route table and custom route

    az network route-table create \
    --name publictable \
    --resource-group [sandbox resource group name] \
    --disable-bgp-route-propagation false

    az network route-table route create \
    --route-table-name publictable \
    --resource-group [sandbox resource group name] \
    --name productionsubnet \
    --address-prefix 10.0.1.0/24 \
    --next-hop-type VirtualAppliance \
    --next-hop-ip-address 10.0.2.4   

    #association avec un subnet:

    az network vnet subnet update \
    --name [subnet name] \
    --vnet-name vnet \
    --resource-group [sandbox resource group name] \
    --route-table publictable

network virtual appliance (NVA).

    A network virtual appliance (NVA) is a virtual appliance that consists of various layers like:

    a firewall
    a WAN optimizer
    application-delivery controllers
    routers
    load balancers
    IDS/IPS
    proxies

    Such providers include Check Point, Barracuda, Sophos, WatchGuard, and SonicWal
    cela peut aussi etre une simple VM windows avec IpForwarding, routing tables, user defined route et updated subnet

    notes: ip forwarding à activer sur l'interface...

    az network nic update --name $NICNAME \
    --resource-group learn-69a75da9-3a8e-4924-8076-f8581e8e7837 \
    --ip-forwarding true

    ...and in the appliance: ssh -t -o StrictHostKeyChecking=no azureuser@$NVAIP 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'

HUB and SPOKE:
    A hub and spoke consists of a centralized architecture (a hub) connecting to multiple points (spokes).


Azure firewall:
    Azure Firewall is a fully stateful network firewall that tracks the operating state	

Monitoring:

Network Watcher:

    Monitoring tools:
        Topology
        Connection Monitor
        Network Performance Monitor
    Diagnostic tools
        IP flow verify
        Next hop
        Security group view
        Packet capture ( Network Watcher Agent VM Extension)
        Connection troubleshoot
        VPN troubleshoot