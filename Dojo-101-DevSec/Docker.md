# Docker basics

## Installation de docker engine sous ubuntu / debian

Docker engine est préférable aux applications desktop, car pas besoin d'hyperviseur ou de virtualisation imbriquée

[documentation](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

Add Docker's official GPG key :

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Add the repository to Apt sources :

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

install + "hello world" :

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
```


## checks

```sh
docker info
docker run hello-world
```

## lister les images et les containers qui tournent

```sh
docker image ls
docker ps
```

## lister les containers, meme ceux arraté

`docker ps -a`

## télécharger une image (ex: splunk)

`docker pull splunk/splunk:latest`

## lancer un container en mode intéractif

i = interactf
t = TTY

```sh
docker run -it debian
```

## lancer un container en arrière plan (ex: splunk)

`docker run -d -p 8000:8000 -e "SPLUNK_START_ARGS=--accept-license" -e "SPLUNK_PASSWORD=<password>" --name splunk splunk/splunk:latest`

## Détacher: 

`Ctrl-P + Ctrl-Q`

## shooter tous les container : 

`docker rm $(docker ps -a -q)`

## stopper un container en interactif 

`ctrl P + ctrl D`

## executer une commande dans un container détaché:

`docker exec -it MyContainer bash`

## réattacher le container

`docker attach <id>`

## bind de port: 

`docker run -p <host_port1>:<container_port1> -p <host_port2>:<container_port2>`

exemple:

`docker run --rm -it -p 8080:80 nginx`

## partager le stockage (volume)

`docker run -it -v /host/path:/path nginx`

## lire les logs

`docker logs <id>`

## supprimer un container

`docker rm -f <id/name>`

## en bridge

`docker run --rm -it --network bridge debian ip addr`

## sauvegarde de l'image: 

`sudo docker save -o docker_save_ForensicsExam.tar secit/forensicsexam:latest`

## pour charger l'image ce sera: 

`sudo docker load -i ./docker_save_ForensicsExam.tar`

## Pousser un container sur le repo: 

```bash
$ sudo docker image ls
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
<none>                   <none>              85a603db6265        3 minutes ago       218MB
alpine                   latest              961769676411        8 days ago          5.58MB
ep9piegi/forensicsexam   1.0                 18906800a393        3 months ago        620MB
splunk/splunk            latest              d0e924f35601        4 months ago        537MB
centos                   latest              9f38484d220f        5 months ago        202MB
arvindr226/alpine-ssh    latest              eae0904b4356        2 years ago         11.3MB
$ sudo docker tag 85a603db6265 ep9piegi/alpine_escalation:latest
$ sudo docker login
Authenticating with existing credentials...
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

$ sudo docker push ep9piegi/alpine_escalation
The push refers to repository [docker.io/ep9piegi/alpine_escalation]
d870b445421f: Pushed 
222e39406225: Layer already exists 
cff9126566c1: Layer already exists 
288789f98c30: Layer already exists 
d8b33d0bad10: Layer already exists 
285c1bd5d4b1: Pushed 
03901b4a2ea8: Layer already exists 
latest: digest: sha256:0d24ff93bcfc6d1114ee170b2f804ac8156a9ebfd1ea22098708795078334776 size: 1780
```

## Dockerfile

The docker build command builds an image from a Dockerfile and a context. The build’s context is the set of files at a specified location PATH or URL. The PATH is a directory on your local filesystem. The URL is a Git repository location.
A context is processed recursively. So, a PATH includes any subdirectories and the URL includes the repository and its submodules. This example shows a build command that uses the current directory as context:

```bash
$ docker build .
```


## Aller plus loin

### Terraform

[source](https://developer.hashicorp.com/terraform/tutorials/docker-get-started/infrastructure-as-code)

fichier `terraform.tf` (provider + version)

```json
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
  required_version = "~> 1.7"
}
```

fichier `main.tf` (configuration)

```json
provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```


```sh
terraform init
terraform apply
```

Le container est ensuite déployé sur la machine, on peu le vérifier via `docker ps`. `terraform destroy` permet de supprimer les containers.


