# Azure storage

## Data

* Structured (SQL)
* Semi-structured (JSON, XML, YAML)

## Azure Storage:
* Azure Blobs
* Azure Files
* Azure Queues
* Azure Tables

## NOT Azure Storage:
Azure SQL
Azure Cosmos DB

## Storage Account Settings (storage service):

- subscritpion
- Location
- Performance (HW disk: Standard (magnetic), premium (SSD), Ultra SSD)
- Replication:
    * LRS (locally redundant storage) 3 copies within the datacenter
    * GRS géo redundant storage (different datacenter)
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

## Connection types

2 permission storage account: management and data

## commandes

```powershell
# create storage account:

az storage account create \
--name  mslearn$RANDOM \
--resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3 \
--sku Standard_GRS \
--kind StorageV2

#exemple connection strings:
AccountEndpoint=https://<YOUR-COSMOS-DB-NAME>.documents.azure.com:443/;AccountKey=<PRIMARY-MASTER-KEY>;

# list master key:
az cosmosdb keys list \
--name COSMOS-DB-NAME \
--resource-group myresourcegroup \
--subscription "My Subscription" \
--type keys

# Creer un compte cosmosDB:

export NAME=cosmos$RANDOM
az cosmosdb create \
--name $NAME \
--kind GlobalDocumentDB \
--resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3

#obtain de connection string:

az cosmosdb keys list \
--name $NAME \
--resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3 \
--type keys

#recuperer la master key:

az cosmosdb keys list \
--name $NAME \
--resource-group learn-f49c159b-f0dc-4180-bc93-37f3d7fbf4b3 \
--type keys


## create a data lake:

az extension add --name storage-preview
```
1 subscription = 200 storage accounts = 200*500 TB 

## Azure data services

### Azure storage includes four types of data:

* Blobs: A massively scalable object store for text and binary data. Can include support for Azure Data Lake Storage Gen2.
* Files: Managed file shares for cloud or on-premises deployments.
* Queues: A messaging store for reliable messaging between application components.
* Table Storage: A NoSQL store for schemaless storage of structured data. Table Storage is not covered in this module.


## Create azure storage account:

```powershell
az storage account create \
--resource-group learn-13dcafaa-99a8-4050-85ac-16c032a3d62a \
--kind StorageV2 \
--sku Standard_LRS \
--access-tier Cool \
--name <name>
```

## To work with data in a storage account, your app will need two pieces of data:

* An access key
* The REST API endpoint

API REST Endpoints:

| Data type | Example endpoint|
|-----|-----|
| Blobs | https://[name].blob.core.windows.net/ |
| Queues | https://[name].queue.core.windows.net/ |
| Table |https://[name].table.core.windows.net/ |
| Files | https://[name].file.core.windows.net/ |





## Sécu:

### cross-origin resource sharing (CORS)

CORS uses HTTP headers so that a web application at one domain can access resources from a server at a different domain.
By using CORS, web apps ensure that they load only authorized content from authorized sources

### shared access signature (SAS)
 A shared access signature is a string that contains a security token that can be attached to a URI. you allow only the access that the application needs to do the task.

## Type of SAS:
Service Level: to allow access to specific resources in a storage account (ex: allow an app to retrieve list of files)
Account Level: Service Level + resources and abilities (ex: create File systems)

## Network access Rules:

Go to the storage account you want to secure.
Select Firewalls and virtual networks.
To restrict traffic from selected networks, choose Selected networks. To allow traffic from all networks, select All networks.
Select Save to apply your changes.

```powershell

Add-AzStorageAccountNetworkRule `
-ResourceGroupName "myresourcegroup" `
-AccountName "mystorageaccount" `
-IPAddressOrRange "NNN.NNN.NNN.NNN"

az storage account network-rule add \
--resource-group "myresourcegroup" \
--account-name "mystorageaccount" \
--ip-address "NNN.NNN.NNN.NNN"

#HTTPS Only:

Set-AzStorageAccount `
-Name "StorageAccountName" `
-ResourceGroupName "ResourceGroupName" `
-EnableHttpsTrafficOnly $True

az storage account update \
--resource-group ResourceGroupName \
--name StorageAccountName \
--https-only true
```

## ATP:

* On the Settings page, select Advanced security.
* Select Enable Advanced Threat Protection to enable this layer of protection.  
