## Managed Disks:

    Managed disks are the newer and recommended disk storage model. 
    They elegantly solve this complexity by putting the burden of managing the storage accounts onto Azure. You specify the disk type (Premium or Standard) and the size of the disk, 
    and Azure creates and manages both the disk and the storage it uses. You don't have to worry about storage account limits, which makes them easier to scale out. They also offer several other benefits:

    - Increased reliability: Azure ensures that VHDs associated with high-reliability VMs will be placed in different parts of Azure Storage to provide similar levels of resilience.
    - Better security: Managed disks are real managed resources in the resource group. This means they can use role-based access control to restrict who can work with the VHD data.
    - Snapshot support: Snapshots can be used to create a read-only copy of a VHD. You have to shut down the owning VM, but creating the snapshot only takes a few seconds. Once it's done, you can power on the VM and use the snapshot to create a duplicate VM to troubleshoot a production issue or roll back the VM to the point in time that the snapshot was taken.
    - Backup support: Managed disks can be automatically backed up to different regions for disaster recovery with Azure Backup without affecting the service of the VM.

    Types of disks:

        OS disk: When you create an Azure VM, Azure automatically attaches a VHD for the operating system (OS).

        Temporary disk: When you create an Azure VM, Azure also automatically adds a temporary disk. This disk is used for data, such as page and swap files. The data on this disk may be lost during maintenance or a VM redeploy. Don't use it for storing permanent data, such as database files or transaction logs.

        Data disks: A data disk is a VHD that's attached to a virtual machine to store application data or other data you need to keep.


## NSG:

    NSGs use rules to allow or deny traffic moving through the network. Each rule identifies the source and destination address (or range), protocol, port (or range), 
    direction (inbound or outbound), a numeric priority, and whether to allow or deny the traffic that matches the rule.

    The rules are evaluated in priority order, starting with the lowest priority rule. Deny rules always stop the evaluation. 
    For example, if a network interface rule blocks an outbound request, any rules applied to the subnet will not be checked. 
    For traffic to be allowed through the security group, it must pass through all applied groups.


    az vm open-port \
        --port 80 \
        --resource-group learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3 \
        --name SampleVM

## VM Sizing:

    Type	Sizes	Description
    General purpose	Dsv3, Dv3, DSv2, Dv2, DS, D, Av2, A0-7	Balanced CPU-to-memory. Ideal for dev/test and small to medium applications and data solutions.
    Compute optimized	Fs, F	High CPU-to-memory. Good for medium-traffic applications, network appliances, and batch processes.
    Memory optimized	Esv3, Ev3, M, GS, G, DSv2, DS, Dv2, D	High memory-to-core. Great for relational databases, medium to large caches, and in-memory analytics.
    Storage optimized	Ls	High disk throughput and IO. Ideal for big data, SQL, and NoSQL databases.
    GPU optimized	NV, NC	Specialized VMs targeted for heavy graphic rendering and video editing.
    High performance	H, A8-11	Our most powerful CPU VMs with optional high-throughput network interfaces (RDMA).

    az vm list --output table

    az vm list-ip-addresses -n SampleVM -o table

    az vm show --resource-group learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3 --name SampleVM

    az vm list-sizes --location eastus --output table

    az vm list-vm-resize-options \
    >     --resource-group learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3 \
    >     --name SampleVM \
    >     --output table

    az vm resize \
        --resource-group learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3 \
        --name SampleVM \
        --size Standard_D2s_v3

## AZ CLI:

    Sub-command	Description
    create	Create a new virtual machine
    deallocate	Deallocate a virtual machine
    delete	Delete a virtual machine
    list	List the created virtual machines in your subscription
    open-port	Open a specific network port for inbound traffic
    restart	Restart a virtual machine
    show	Get the details for a virtual machine
    start	Start a stopped virtual machine
    stop	Stop a running virtual machine
    update	Update a property of a virtual machine

    az vm create \
    --resource-group learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3 \
    --location westus \
    --name SampleVM \
    --image UbuntuLTS \
    --admin-username azureuser \
    --generate-ssh-keys \
    --verbose 

    output:
        SSH key files '/home/vaca/.ssh/id_rsa' and '/home/vaca/.ssh/id_rsa.pub' have been generated under ~/.ssh to allow SSH access to the VM. If using machines without permanent storage, back up your keys to a safe location.
        Succeeded: SampleVMVMNic (Microsoft.Network/networkInterfaces)
        {
        "fqdns": "",
        "id": "/subscriptions/f26515d9-3bc6-4a50-8192-cb816a833f54/resourceGroups/learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3/providers/Microsoft.Compute/virtualMachines/SampleVM",
        "location": "westus",
        "macAddress": "00-0D-3A-59-2A-B9",
        "powerState": "VM running",
        "privateIpAddress": "10.0.0.4",
        "publicIpAddress": "40.112.220.125",
        "resourceGroup": "learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3",
        "zones": ""
        }
        command ran in 71.459 seconds.


    az vm stop \
        --name SampleVM \
        --resource-group learn-f95b0f1e-6792-468f-bd1d-88a0391c03a3




    connection:
        ssh azureuser@40.112.220.125 -i .ssh/id_rsa

    lister les images les plus populaire:
        az vm image list --output table



## Update:

    There are several advantages to the Update Management solution:

    There are no agents or additional configuration within the virtual machine.
    You can run updates without logging into the VM. You also don't have to create passwords to install the update.
    The Update Management solution lists missing updates and provides information about failed deployments in an easy-to-read format.

    Update Management solution supports Windows and Linux, specifically:

        Windows Server (2008 and newer)
        CentOS 6 (x86/X64) and CentOS 7
        Red Hat Enterprise 6 (x86/x64) and 7 (x64)
        SUSE Linux Enterprise Server 11 (x86/x64) and 12 (x64)
        Ubuntu 14.04 LTS, 16.04 LTS and 18.04 (x86/x64)

    The following configurations are used to perform assessment and update deployments:

        Microsoft Monitoring Agent (MMA) for Windows or Linux.
        PowerShell Desired State Configuration (DSC) for Linux.
        Automation Hybrid Runbook Worker.
        Microsoft Update or Windows Server Update Services (WSUS) for Windows computers.


## Netowk:

    Communicate between Azure resources
        Virtual networks

            Virtual networks can connect not only VMs, but other Azure resources, such as the App Service Environment, 
            Azure Kubernetes Service, and Azure virtual machine scale sets.

        Service endpoints

            You can use service endpoints to connect to other Azure resource types, such as Azure SQL databases and storage accounts. 
            This approach enables you to link multiple Azure resources to virtual networks, thereby improving security and providing optimal routing between resources.

    Communicate with on-premises resources

        Point-to-site Virtual Private Networks

            This approach is like a Virtual Private Network (VPN) connection that a computer outside your organization makes back into your corporate network, 
            except that it's working in the opposite direction. In this case, the client computer initiates an encrypted VPN connection to Azure, connecting that computer to the Azure virtual network.

            Site-to-site Virtual Private Networks A site-to-site VPN links your on-premises VPN device or gateway to the Azure VPN gateway in a virtual network. In effect, the devices in Azure can appear as being on the local network. The connection is encrypted and works over the Internet.

        Azure ExpressRoute

            For environments where you need greater bandwidth and even higher levels of security, Azure ExpressRoute is the best approach. 
            Azure ExpressRoute provides dedicated private connectivity to Azure that does not travel over the Internet.

    Route network traffic
        By default, Azure will route traffic between subnets on any connected virtual networks, on-premises networks, and the Internet. 
        However, you can control routing and override those settings as follows:

        Route tables

            A route table allows you to define rules as to how traffic should be directed. You can create custom route tables that control how packets are routed between subnets.

        Border Gateway Protocol

            Border Gateway Protocol (BGP) works with Azure VPN gateways or ExpressRoute to propagate on-premises BGP routes to Azure virtual networks.

    Filter network traffic
        Azure virtual networks enable you to filter traffic between subnets by using the following approaches:

        Network security groups

            A network security group is an Azure resource that can contain multiple inbound and outbound security rules. 
            You can define these rules to allow or block traffic, based on factors such as source and destination IP address, port, and protocol.

        Network virtual appliances

            A network virtual appliance is a specialized VM that can be compared to a hardened network appliance. 
            A network virtual appliance carries out a particular network function, such as running a firewall or performing WAN optimization.


## Create a resource group:

    $Location = "EastUS" 
    New-AzResourceGroup -Name vm-networks -Location $Location

## Create a subnet and virtual network

    $Subnet= New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24
    New-AzVirtualNetwork -Name myVnet -ResourceGroupName vm-networks -Location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet


### créer une VM et connaitre son IP publique:

    New-AzVm `
    -ResourceGroupName "vm-networks" `
    -Name "dataProcStage1" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "default" `
    -image "Win2016Datacenter" `
    -Size "Standard_DS2_v2"

    Get-AzPublicIpAddress -Name dataProcStage1

### désassocier l'IP publique:

    $nic = Get-AzNetworkInterface -Name dataProcStage2 -ResourceGroup vm-networks
    $nic.IpConfigurations.publicipaddress.id = $null
    Set-AzNetworkInterface -NetworkInterface $nic 


### Azure VPN Gateway:
    Each virtual network can have only one VPN gateway

    gateway type :

        Network-to-network connections over IPsec/IKE VPN tunneling, linking VPN gateways to other VPN gateways.

        Cross-premises IPsec/IKE VPN tunneling, for connecting on-premises networks to Azure through dedicated VPN devices to create site-to-site connections.

        Point-to-site connections over IKEv2 or SSTP, to link client computers to resources in Azure.


                            Point to site	                Site to site	                        ExpressRoute
Azure supported services	Cloud services and VMs	        Cloud services and VMs	                All supported services
Typical bandwidth	        Depends on VPN Gateway SKU	    Depends on VPN Gateway SKU	            See ExpressRoute bandwidth options
Protocols supported	        SSTP and IPsec	                IPsec	                                Direct connection, VLANs
Routing	                    RouteBased (dynamic)	        PolicyBased (static) and RouteBased	    BGP
Connection resiliency	    Active-passive	                Active-passive or active-active	Active-active
Use case	                Testing and prototyping	Dev, 	Enterprise/mission                      critical
                            test and small-scale production


    VPN Workflow:

        Design your connectivity topology, listing the address spaces for all connecting networks.

        Create an Azure virtual network.

        Create a VPN gateway for the virtual network.

        Create and configure connections to on-premises networks or other virtual networks, as required.

        If required, create and configure a point-to-site connection for your Azure VPN gateway.




    The type of VPN gateway you create will depend on your architecture. Options are:

        RouteBased

        Route-based VPN devices use any-to-any (wildcard) traffic selectors, and let routing/forwarding tables direct traffic to different IPsec tunnels. 
        Route-based connections are typically built on router platforms where each IPsec tunnel is modeled as a network interface or VTI (virtual tunnel interface).

        PolicyBased

        Policy-based VPN devices use the combinations of prefixes from both networks to define how traffic is encrypted/decrypted through IPsec tunnels. 
        A policy-based connection is typically built on firewall devices that perform packet filtering. IPsec tunnel encryption and decryption are added to the packet filtering and processing engine.

        Set up a VPN gateway
        
                Create a virtual network

                Add a gateway subnet

                Specify a DNS server (optional)

                Create a virtual network gateway

                Generate certificates

                Add the client address pool

                Configure the tunnel type

                Configure the authentication type

                Upload the root certificate public certificate data

                Install an exported client certificate

                Generate and install the VPN client configuration package

                Connect to Azure

### ExpressRoute:

    Advantages that ExpressRoute provides include:

        Faster speeds, from 50 Mbps to 10 Gbps, with dynamic bandwidth scaling

        Lower latency

        Greater reliability through built-in peering

        Highly secure

    ExpressRoute brings a number of further benefits, such as:

        Connectivity to all supported Azure services

        Global connectivity to all regions (requires premium add-on)

        Dynamic routing over Border Gateway Protocol

        Service-level agreements (SLAs) for connection uptime

        Quality of Service (QoS) for Skype for Business

    ExpressRoute connectivity models

        IP VPN network (any-to-any)

        Virtual cross-connection through an Ethernet exchange

        Point-to-point Ethernet connection

### Azure template:
    json files. on décrit les ressources et pas la maniere de les déployer (Infra as code)

    Pour démarrer: QuickStart Template Gallery: https://azure.microsoft.com/fr-fr/resources/templates/

    exemple de déploiement - validation puis création:
        az deployment group validate \
        --resource-group $RESOURCEGROUP \
        --template-uri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json" \
        --parameters adminUsername=$USERNAME \
        --parameters adminPassword=$PASSWORD \
        --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX

        az deployment group create \
        --name MyDeployment \
        --resource-group $RESOURCEGROUP \
        --template-uri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json" \
        --parameters adminUsername=$USERNAME \
        --parameters adminPassword=$PASSWORD \
        --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX

    avec un fichier json:

        az deployment group create \
    --name MyDeployment \
    --resource-group $RESOURCEGROUP \
    --template-file azuredeploy.json \
    --parameters adminUsername=$USERNAME \
    --parameters adminPassword=$PASSWORD \
    --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX


### VHD Files:

    Azure Disks are designed for 99.999% availability.

    Storage account type	            Services supported	                                    Types of blobs supported
    General-purpose standard	        Azure Blob storage, Azure Files, Azure Queue storage	Block blobs, page blobs, and append blobs
    General-purpose premium	            Blob storage	                                        Page blobs
    Blob storage, hot and               Blob storage	Block blobs and append blobs
    cool access tiers

    ajouter un disk vide:
            az vm disk attach \
        --vm-name support-web-vm01 \
        --name uploadDataDisk1 \
        --size-gb 64 \
        --sku Premium_LRS \
        --new

    initialize and format Disks:

        az vm extension set \
    --vm-name support-web-vm01 \
    --name customScript \
    --publisher Microsoft.Azure.Extensions \
    --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-add-and-size-disks-in-azure-virtual-machines/master/add-data-disk.sh"]}' \
    --protected-settings '{"commandToExecute": "./add-data-disk.sh"}'

Premium storage:  Apps such as Dynamics CRM, Exchange Server, SAP Business Suite, SQL Server, Oracle, and SharePoint require constant high performance and low latency to run at their best.

### Types of disks:

    Ultra disks
    Premium SSD disks - VM sizes that include an "s" 
    Standard SSD

### Data replication

    Locally redundant storage (LRS) - Azure replicates the data within the same Azure data center. The data remains available if a node fails. However, if an entire data center fails, data may be unavailable.

    Geo-redundant storage (GRS) - Azure replicates your data to a second region that is hundreds of miles away from the primary region. If your storage account has GRS enabled, then your data is durable even if there's a complete regional outage or a disaster in which the primary region isn't recoverable.

    Read-access geo-redundant storage (RA-GRS) - Azure provides read-only access to the data in the secondary location, and geo-replication across two regions. If a data center fails, the data remains readable but can't be modified.

    Zone-redundant storage (ZRS) - Azure replicates your data synchronously across three storage clusters in a single region. Each storage cluster is physically separated from the others and resides in its own availability zone (AZ). With this type of replication, you can still access and manage your data in the event that a zone becomes unavailable


### Expanding a disk:

    Before: Stop and deallocate VM
    az vm stop --ressource-group ... --name ...
    az vm deallocate --ressource-group ... --name ...

    az disk update \
    --resource-group <resource-group-name> \
    --name <disk-name> \
    --size-gb 200

    il faudra ensuite étendre la partition ;)


    az vm deallocate --name support-web-vm01
    az disk update --name uploadDataDisk1 --size-gb 128
    az vm start --name support-web-vm01

    trouver ensuite l'IP public pour étendre la partition:
    ipaddress=$(az vm show --name support-web-vm01 -d --query [publicIps] -o tsv)



## lister les disks:

    az disk list \
  --query '[*].{Name:name,Gb:diskSizeGb,Tier:sku.tier}' \
  --output table



## Cache:
    IOPS x I/O size = throughput

    Type of Azure Disk Caching:
        Azure storage caching
        Azure virtual machine (VM) disk caching

                Read-only	    Read/write	        None
    OS disk	    yes	            yes (default)	    yes
    Data disk	yes (default)	yes	                yes
    Temp disk	no	            no	                no

    Azure PowerShell has specific cmdlets to help manage VMs and disks.


        Command	Description
        Get-AzVM	Gets the properties of a virtual machine.
        Update-AzVM	Updates the state of an Azure virtual machine.
        New-AzDiskConfig	Creates a configurable disk object.
        Add-AzVMDataDisk	Adds a data disk to a virtual machine.


        $myRgName = "learn-bf14aad4-d69f-41cd-a9e8-5d56f5a9f6a2"
        $myVMName = "fotoshareVM
        $myVM = Get-AzVM -ResourceGroupName $myRgName -VMName $myVmName
        $myVM | select-object -property ResourceGroupName, Name, Type, Location #info sur la VM
        $myVM.StorageProfile.OsDisk.Caching #info sur le cache du disque OS

        #changer la proprieté - pour l'OS DISK la VM doit redémarrer:
        $myVM.StorageProfile.OsDisk.Caching = "ReadWrite"
        Update-AzVM -ResourceGroupName $myRGName -VM $myVM

        Ajouter un disque: Add-AzVMDataDisk -VM $myVM -Name $newDiskName  -LUN 1  -DiskSizeinGB 1 -CreateOption Empty

## Azure disk encryption technologies

    Storage Service Encryption (SSE) - protect data at rest, azure managed disks, enabled by default: AES256
    Azure Disk Encryption (ADE) - managed by VM owner, OS level: Bitlocker | DM-crypt - required for VMs backed up to the Recovery Vault

## Azure Disk Encryption prerequisites

    Create a key vault.
    Set the key vault access policy to support disk encryption.
    Use the key vault to store the encryption keys for ADE.

### créer key vault:

    New-AzKeyVault -Location <location> `
    -ResourceGroupName <resource-group> `
    -VaultName "myKeyVault" `
    -EnabledForDiskEncryption

    az keyvault create \
        --name "myKeyVault" \
        --resource-group <resource-group> \
        --location <location> \
        --enabled-for-disk-encryption True  

    GUI: home -> create ressource -> Key Vault

### Enabling access policy:

    There are three policies you can enable.

    Disk encryption - Required for Azure Disk encryption.
    Deployment - (Optional) Enables the Microsoft.Compute resource provider to retrieve secrets from this key vault when this key vault is referenced in resource creation, for example when creating a virtual machine.
    Template deployment - (Optional) Enables Azure Resource Manager to get secrets from this key vault when this key vault is referenced in a template deployment.

    Set-AzKeyVaultAccessPolicy -VaultName <keyvault-name> -ResourceGroupName <resource-group> -EnabledForDiskEncryption

    az keyvault update --name <keyvault-name> --resource-group <resource-group> --enabled-for-disk-encryption "true"

### Encrypt Disk:

    Set-AzVmDiskEncryptionExtension `
	-ResourceGroupName <resource-group> `
    -VMName <vm-name> `
    -VolumeType [All | OS | Data]
	-DiskEncryptionKeyVaultId <keyVault.ResourceId> `
	-DiskEncryptionKeyVaultUrl <keyVault.VaultUri> `
     -SkipVmBackup

    az vm encryption enable \
    --resource-group <resource-group> \
    --name <vm-name> \
    --disk-encryption-keyvault <keyvault-name> \
    --volume-type [all | os | data] \

### disks Encryption status:

    Get-AzVmDiskEncryptionStatus  -ResourceGroupName <resource-group> -VMName <vm-name>

    az vm encryption show --resource-group <resource-group> --name <vm-name>


## DSC:

    LCM: local configuration manager

    Every time the LCM runs, it completes the following steps:

        Get: Get the current state of the node.
        Test: Compare the current state of a node against the desired state by using a compiled DSC script (.mof file).
        Set: Update the node to match the desired state described in the .mof file.

    Archi:
        Push
        Pull (avec un serveur)

    Supported
        Server 2019
        Server 2016
        Server 2012 R2
        Server 2012
        Server 2008 R2 SP1
        10
        8.1
        7
        Most variants, but not Debian or Ubuntu 18.04

    On Azure:

    1 - create DSC configuration script
    (Azure Automation)
    2- Create Azure automation account
    3 - Upload DSC confiduration script
    4 - Add required modules
    5 - Compile configuration
    6 - Register virtual Machine
    (VM)
    7- install DSC VM extention
    8 - Install WMF
    9 - LCM applies de Desired States

