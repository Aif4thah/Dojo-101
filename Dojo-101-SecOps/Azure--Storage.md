# Azure storage

## DATA:
    Structured (SQL)
    Semi-structured (JSON, XML, YAML)


A transaction is a logical group of database operations that execute together.

Transactions are often defined by a set of four requirements, referred to as ACID guarantees. ACID stands for Atomicity, Consistency, Isolation, and Durability:

    Atomicity means a transaction must execute exactly once and must be atomic; either all of the work is done, or none of it is. Operations within a transaction usually share a common intent and are interdependent.
    Consistency ensures that the data is consistent both before and after the transaction.
    Isolation ensures that one transaction is not impacted by another transaction.
    Durability means that the changes made due to the transaction are permanently saved in the system. Committed data is saved by the system so that even in the event of a failure and system restart, the data is available in its correct state.


Transactional databases are often called OLTP (Online Transaction Processing) systems.
 OLTP systems commonly support lots of users, have quick response times, and handle large volumes of data. They are also highly available (meaning they have very minimal downtime), and typically handle small or relatively simple transactions.

On the contrary, OLAP (Online Analytical Processing) systems commonly support fewer users, have longer response times,
 can be less available, and typically handle large and complex transactions.

Azure Cosmos DB: Semi structured (NoSQL): ACID-compliant, idéal pour Procuct Catalog data


Azure blog storage (no structured) - idéal pour photos et video

Azure SQL Database idéal pour Business Database



## Azure Storage:
    Azure Blobs, 
    Azure Files, 
    Azure Queues, 
    Azure Tables

## NOT Azure Storage:
Azure SQL
Azure Cosmos DB

## Storage Account Settings (storage service):

    - subscritpion
    - Location
    - Performance (HW disk: Standard (magnetic), premium (SSD), Ultra SSD)
    - Replication:
        LRS (locally redundant storage) 3 copies within the datacenter
        GRS géo redundant storage (different datacenter)
    - Secure Transfert required (disable HTTP)
    - Virtual Network (access onlu for specify Vnet)

    1 storage account = 1 settings


## Storage account settings (Account):
    - Name ( 3...24)
    - Deployment model:
        Resource Manager: the current model that uses the Azure Resource Manager API
        Classic: a legacy offering that uses the Azure Service Management API
    - Account kind:
        StorageV2 (general purpose v2): the current offering that supports all storage types and all of the latest features
        Storage (general purpose v1): a legacy kind that supports all storage types but may not support all features
        Blob storage: a legacy kind that allows only block blobs and append blobs


## The available creation tools are:

    Azure Portal
    Azure CLI (Command-line interface)
    Azure PowerShell
    Management client libraries

## Storage Account name = Globaly Unique


 Azure storage explorer:
    Azure Blob storage. Blob storage is used to store unstructured data as a binary large object (blob).
    Azure Table storage. Table storage is used to store NoSQL, semi-structured data.
    Azure Files. Azure Files is a file-sharing service that enables access through the Server Message Block protocol, similar to traditional file servers.
    Azure Data Lake Storage. Azure Data Lake, based on Apache Hadoop, is designed for large data volumes and can store unstructured and structured data.

    Dev (pour pas payer de storage account):
        Azure Storage Emulator uses a local instance of Microsoft SQL Server 2012 Express LocalDB. It emulates Azure Table, Queue, and Blob storage.
        Azurite, which is based on Node.js, is an open-source emulator that supports most Azure Storage commands through an API.

    Connection types

        2 permission storage account: management and data
        There are many ways to connect an Azure Storage Explorer instance to your Azure resources. For example:

        Add resources by using Azure Active Directory (Azure AD)
        Use a connection string
        Use a shared access signature URI
        Use a name and key
        Attach to a local emulator
        Attach to Azure Cosmos DB through a connection string
        Attach to Azure Data Lake by using a URI
    
    To add a resource by using Azure AD:

        Open Storage Explorer.
        Select the Add an Azure Account option and sign in to Azure.
        Connect to your Azure storage account.
        Select Add a resource via Azure AD, and then choose the Azure tenant and the associated account.
        When you're prompted, provide the type of resource that you're connecting to.
        Review and verify the connection details, and then select Connect.

    To add a SAS connection:

        Open Storage Explorer.
        Connect to your Azure storage account.
        Select the connection type: shared access signature (SAS) URI.
        Provide a meaningful name for the connection.
        When you're prompted, provide the SAS URI.
        Review and verify the connection details, and then select Connect

    Name and key:

        Open Storage Explorer.
        Connect to your Azure storage account.
        Select the connection type: storage account name and key.
        Provide a meaningful name for the connection.
        When you're prompted, provide the name of the storage account and either of the account keys needed to access it.
        From the provided list, select the storage domain that you want to use.
        Review and verify the connection details, and then select Connect.

    create storage account:

    az storage account create \
        --name  mslearn$RANDOM \
        --resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3 \
        --sku Standard_GRS \
        --kind StorageV2

exemple connection strings:
    AccountEndpoint=https://<YOUR-COSMOS-DB-NAME>.documents.azure.com:443/;AccountKey=<PRIMARY-MASTER-KEY>;

list master key:
    az cosmosdb keys list \
    --name COSMOS-DB-NAME \
    --resource-group myresourcegroup \
    --subscription "My Subscription" \
    --type keys

Creer un compte cosmosDB:

    export NAME=cosmos$RANDOM
    az cosmosdb create \
        --name $NAME \
        --kind GlobalDocumentDB \
        --resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3

obtain de connection string:

    az cosmosdb keys list \
    --name $NAME \
    --resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3 \
    --type keys

output:



{
  "capabilities": [],
  "connectorOffer": null,
  "consistencyPolicy": {
    "defaultConsistencyLevel": "Session",
    "maxIntervalInSeconds": 5,
    "maxStalenessPrefix": 100
  },
  "databaseAccountOfferType": "Standard",
  "disableKeyBasedMetadataWriteAccess": false,
  "documentEndpoint": "https://cosmos21646.documents.azure.com:443/",
  "enableAutomaticFailover": false,
  "enableCassandraConnector": null,
  "enableMultipleWriteLocations": false,
  "failoverPolicies": [
    {
      "failoverPriority": 0,
      "id": "cosmos21646-westus",
      "locationName": "West US"
    }
  ],
  "id": "/subscriptions/284abde4-8473-410e-bf15-dce5f4c882df/resourceGroups/learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3/providers/Microsoft.DocumentDB/databaseAccounts/cosmos21646",
  "ipRangeFilter": "",
  "isVirtualNetworkFilterEnabled": false,
  "keyVaultKeyUri": null,
  "kind": "GlobalDocumentDB",
  "location": "West US",
  "locations": [
    {
      "documentEndpoint": "https://cosmos21646-westus.documents.azure.com:443/",
      "failoverPriority": 0,
      "id": "cosmos21646-westus",
      "isZoneRedundant": false,
      "locationName": "West US",
      "provisioningState": "Succeeded"
    }
  ],
  "name": "cosmos21646",
  "provisioningState": "Succeeded",
  "readLocations": [
    {
      "documentEndpoint": "https://cosmos21646-westus.documents.azure.com:443/",
      "failoverPriority": 0,
      "id": "cosmos21646-westus",
      "isZoneRedundant": false,
      "locationName": "West US",
      "provisioningState": "Succeeded"
    }
  ],
  "resourceGroup": "learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3",
  "tags": {},
  "type": "Microsoft.DocumentDB/databaseAccounts",
  "virtualNetworkRules": [],
  "writeLocations": [
    {
      "documentEndpoint": "https://cosmos21646-westus.documents.azure.com:443/",
      "failoverPriority": 0,
      "id": "cosmos21646-westus",
      "isZoneRedundant": false,
      "locationName": "West US",
      "provisioningState": "Succeeded"
    }
  ]
}


recuperer la master key:

    az cosmosdb keys list \
    --name $NAME \
    --resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3 \
    --type keys

output:

        {
        "primaryMasterKey": "dx7HSy6JGDQmYCy8ujPIVJmjPRROKsO0zuOAw0hFEjthICYsDxgv7WfnRKAOzis9pXL3Tt8YzNMYeIMwLWVMRw==",
        "primaryReadonlyMasterKey": "AkGhkhsdfCACiFxsdFnf8sDRO2Ht8Ukj6eDg53Nov2L9tWMfegtizqNaaSZ3NIR8Q4VgVJEeMl4zxOKkU70fJQ==",
        "secondaryMasterKey": "OdnA9xD3dLCagSHjgMDbf88nsi9wxmLSmuc9Fse43goyQHV5qay3uDa2qlSPbhzlRX5ug95SwcKZgxvLCvpo3g==",
        "secondaryReadonlyMasterKey": "Wntzb0kQptOtfCXgptuMs52ZKKwXGBpCTNqhPy547tqgbQAOGN0vXU3nsL3N4NjRpGrQliqFYD7CPvJbS3vJJQ=="
        }
        
    vaca@Azure:~$ echo $NAME
        cosmos21646


build connextion strings:


    AccountEndpoint=https://cosmos21646.documents.azure.com:443/;AccountKey=dx7HSy6JGDQmYCy8ujPIVJmjPRROKsO0zuOAw0hFEjthICYsDxgv7WfnRKAOzis9pXL3Tt8YzNMYeIMwLWVMRw==;
    on utilise cette chaine pour se connecter avec Azure Storage Explorer


## create a data lake:

    az extension add --name storage-preview

1 subscription = 200 storage accounts = 200*500 TB 

Azure data services
Azure storage includes four types of data:

Blobs: A massively scalable object store for text and binary data. Can include support for Azure Data Lake Storage Gen2.
Files: Managed file shares for cloud or on-premises deployments.
Queues: A messaging store for reliable messaging between application components.
Table Storage: A NoSQL store for schemaless storage of structured data. Table Storage is not covered in this module.


## Azure Storage supports three kinds of blobs:

TABLE 2
Blob type	Description
Block blobs	Block blobs are used to hold text or binary files up to ~5 TB (50,000 blocks of 100 MB) in size. The primary use case for block blobs is the storage of files that are read from beginning to end, such as media files or image files for websites. They are named block blobs because files larger than 100 MB must be uploaded as small blocks, which are then consolidated (or committed) into the final blob.
Page blobs	Page blobs are used to hold random-access files up to 8 TB in size. Page blobs are used primarily as the backing storage for the VHDs used to provide durable disks for Azure Virtual Machines (Azure VMs). They are named page blobs because they provide random read/write access to 512-byte pages.
Append blobs	Append blobs are made up of blocks like block blobs, but they are optimized for append operations. These are frequently used for logging information from one or more sources into the same blob. For example, you might write all of your trace logging to the same append blob for an application running on multiple VMs. A single append blob can be up to 195 GB.

Files:
Storing shared configuration files for VMs, tools, or utilities so that everyone is using the same version.
Log files such as diagnostics, metrics, and crash dumps.
Shared data between on-premises applications and Azure VMs to allow migration of apps to the cloud over a period of time.

Queues
The Azure Queue service is used to store and retrieve messages. Queue messages can be up to 64 KB in size, and a queue can contain millions of messages. Queues are generally used to store lists of messages to be processed asynchronously.

Account type	Description
General-purpose v2 (GPv2)	General-purpose v2 (GPv2) accounts are storage accounts that support all of the latest features for blobs, files, queues, and tables. Pricing for GPv2 accounts has been designed to deliver the lowest per gigabyte prices.
General-purpose v1 (GPv1)	General-purpose v1 (GPv1) accounts provide access to all Azure Storage services but may not have the latest features or the lowest per gigabyte pricing. For example, cool storage and archive storage are not supported in GPv1. Pricing is lower for GPv1 transactions, so workloads with high churn or high read rates may benefit from this account type.
Blob storage accounts	A legacy account type, blob storage accounts support all the same block blob features as GPv2, but they are limited to supporting only block and append blobs. Pricing is broadly similar to pricing for general-purpose v2 accou


## Create azure storage account:

    az storage account create \
        --resource-group learn-13dcafaa-99a8-4050-85ac-16c032a3d62a \
        --kind StorageV2 \
        --sku Standard_LRS \
        --access-tier Cool \
        --name <name>


## To work with data in a storage account, your app will need two pieces of data:

        An access key
        The REST API endpoint


API REST Endpoints:
TABLE 1
    Data type	Example endpoint
    Blobs	https://[name].blob.core.windows.net/
    Queues	https://[name].queue.core.windows.net/
    Table	https://[name].table.core.windows.net/
    Files	https://[name].file.core.windows.net/


Type of redundant storage:

        LRS	ZRS	GRS	RA-GRS


## Sécu:

    cross-origin resource sharing (CORS): CORS uses HTTP headers so that a web application at one domain can access resources from a server at a different domain.
    By using CORS, web apps ensure that they load only authorized content from authorized sources

    shared access signature (SAS). A shared access signature is a string that contains a security token that can be attached to a URI. you allow only the access that the application needs to do the task.

    Type of SAS:
        Service Level: to allow access to specific resources in a storage account (ex: allow an app to retrieve list of files)
        Account Level: Service Level + resources and abilities (ex: create File systems)

    Network access Rules:
        Go to the storage account you want to secure.
        Select Firewalls and virtual networks.
        To restrict traffic from selected networks, choose Selected networks. To allow traffic from all networks, select All networks.
        Select Save to apply your changes.

        Add-AzStorageAccountNetworkRule `
            -ResourceGroupName "myresourcegroup" `
            -AccountName "mystorageaccount" `
            -IPAddressOrRange "NNN.NNN.NNN.NNN"

        az storage account network-rule add \
            --resource-group "myresourcegroup" \
            --account-name "mystorageaccount" \
            --ip-address "NNN.NNN.NNN.NNN"

    HTTPS Only:

        Set-AzStorageAccount `
        -Name "StorageAccountName" `
        -ResourceGroupName "ResourceGroupName" `
        -EnableHttpsTrafficOnly $True

        az storage account update \
        --resource-group ResourceGroupName \
        --name StorageAccountName \
        --https-only true

    ATP:
      On the Settings page, select Advanced security.
      Select Enable Advanced Threat Protection to enable this layer of protection.  

    Data Lake: RBAC (POSIX Compliant) - permissions granulaire etc...


Azure Files:
    direct access (monted drive in your OS)
    Windows server + Azure File Sync

    Pefs:
        Standard performance: Double-digit ms latency, 10,000 IOPS, 300-MBps bandwidth
        Premium performance: Single-digit ms latency, 100,000 IOPS, 5-GBps bandwidth

    Migration solutions:
    Utility	Description
        AzCopy	Command-line tool that offers the best performance, especially for a low volume of small files.
        Robocopy	Command-line tool shipped with Windows and Windows Server. AzCopy is written to be Azure aware and performs better.
        Azure Storage Explorer	Graphical file management utility that runs on Windows, Linux, and macOS.
        Azure portal	Use the portal to import files and folders.
        Azure File Sync	Can be used to do the initial data transfer, and then uninstalled after the data is transferred.
        Azure Data Box	If you have up to 35 TB of data and you need it imported in less than a week.


    Microsoft has created three new roles for permissions levels of access to SMB file shares for users:

        Storage File Data SMB Share Reader
        Storage File Data SMB Share Contributor
        Storage File Data SMB Share Elevated Contributor

    Deletion protection: Snapshot

Troobleshooting tools:

    Transaction metrics

    Capacity metrics

        Capacity, which records the sum total of the storage occupied by the blobs in your storage account.
        Container count, which shows how many containers have been created across blob storage in your storage account.
        Object count, which displays the total number of blobs created across all of your containers.


    Set-AzureStorageServiceMetricsProperty

    $context = New-AzureStorageContext -StorageAccountName <storage account name> -StorageAccountKey <storage account key>

    Set-AzureStorageServiceMetricsProperty -Context $context -ServiceType Blob -MetricsType Hour -MetricsLevel ServiceAndApi -PassThru -RetentionDays 7

    az storage metrics update \
    --hour true \
    --api true \
    --services b \
    --retention 7 \
    --connection-string <storage account connection string>

    Logs:

    Set-AzureStorageServiceLoggingProperty -Context $context -ServiceType Blob -LoggingOperations read,write,delete -RetentionDays 7

    az storage logging update \
    --log rwd \
    --services b \
    --retention 7 \
    --version 2 \
    --connection-string <storage account connection string>


    Download logs:

        $context = New-AzureStorageContext -StorageAccountName <your-storage-account-name> -StorageAccountKey <storage account key>

        $logBlobs = Get-AzureStorageBlob -Container '$logs' -Context $context
        $destination = "C:\Logs"

        foreach ($logFile in $logBlobs)
        {
            Get-AzureStorageBlobContent -Container '$logs' -Blob $logFile.Name -Destination $destination -Context $context
        }

## The WAImportExport tool performs the following tasks:

    Prepares disk drives to be shipped to the Azure datacenter. WAImportExport formats the drive and checks it for errors before data is copied to the disks.
    Encrypts the data on the drive.
    Quickly scans the data and determines how many physical drives are required to hold the data being transferred.
    Creates the journal files that are used for import and export operations. A journal file contains information about the drive serial number, encryption key, and storage account. Each drive you prepare with the Azure Import/Export tool has a single journal file.


Version 1 supports import or export of data to or from Azure Blob storage.
Version 2 supports import of data into Azure Files.

Offline transfert:
Data Box Disk: Provides one ~35-TB transfer to Azure. Connect and copy data over USB.
Data Box: Provides one ~80-TB transfer to Azure per order. Connect and copy data to the device over standard network interface protocols like SMB and NFS.
Data Box Heavy: Provides one ~800-TB transfer to Azure. Use high-throughput network interfaces to connect and copy data to the device. This process uses standard network interface protocols like SMB and NFS. Data Box Heavy is like two Data Boxes, each with an independent node.

Online transfert:
Data Box Edge: This device is a dedicated appliance with 12 TB of local SSD storage. It can preprocess and run machine learning on data before uploading it to Azure.
Data Box Gateway: This device is an entirely virtual appliance. It's based on a virtual machine that you provision in your on-premises environment.

PageBlob, BlockBlob, AzureFile, or ManagedDisk:

Use the ManagedDisk folder for virtual hard disks (VHDs) that you want to migrate to Azure. Use the PageBlob folder for VHDX files.
Any files copied directly to the PageBlob or BlockBlob folders are inserted in a default $root container. Subfolders are created as containers in Azure.
For Azure Files, files must be in subfolders under the AzureFile folder. Any files copied to the root of the AzureFile folder are uploaded as block blobs instead of Azure Files items.

rappel databox:
passkey sur le azure portal:
vhdx=pageblock
vhd=managed disk