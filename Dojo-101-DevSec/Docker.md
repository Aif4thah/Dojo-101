# Docker basics

## Installation de docker engine sous ubuntu / debian

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

```bash
docker ps -a
```

## télécharger une image (ex: splunk)

```bash
docker pull splunk/splunk:latest
```

## lancer un container en mode intéractif

i = interactf
t = TTY

```sh
docker run -it debian
```

## stopper et supprimer un container

```sh
docker stop <container id>
docker rm <container id>
```

## supprimer tous les container : 

```sh
docker rm $(docker ps -a -q)`
```

## supprimer une image

```sh
docker rmi <image id>
```


## lancer un container en arrière plan (-d) avec parage de port (-p) et variable d'environnement (-e)

```sh
docker run -d -p 8000:8000 -e "SPLUNK_START_ARGS=--accept-license" -e "SPLUNK_PASSWORD=<password>" --name splunk splunk/splunk:latest
```

## Détacher: 

`Ctrl-P` + `Ctrl-Q`

## stopper un container en interactif 

`ctrl P` + `ctrl D`

## stopper un container au premier plan

`crtl D` + `ctrl C`

## executer une commande dans un container détaché:

```sh
docker exec -it MyContainer bash
```

## réattacher le container

```sh
docker attach <id>
```

## bind de port: 

```sh
docker run -p <host_port1>:<container_port1> -p <host_port2>:<container_port2>
```

## partager le stockage (volume)

```sh
docker run -it -v /host/path:/path nginx
```

## lire les logs

```sh
docker logs <id>
```

## supprimer un container

```sh
docker rm -f <id/name>
```

## en bridge

```sh
docker run --rm -it --network bridge debian ip addr
```

## sauvegarde de l'image: 

```sh
sudo docker save -o docker_save_ForensicsExam.tar secit/forensicsexam:latest
```

## pour charger l'image ce sera: 

```sh
sudo docker load -i ./docker_save_ForensicsExam.tar
```

## Pousser un container sur le repo: 

```bash
sudo docker tag 85a603db6265 ep9piegi/alpine_escalation:latest
sudo docker login
sudo docker push ep9piegi/alpine_escalation
```

## Dockerfile

exemple de contenu :

```Dockerfile
# syntax=docker/dockerfile:1
FROM ubuntu:latest
RUN apt-get update && apt-get install -y --no-install-recommends git dotnet-sdk-8.0
RUN git clone <project>
RUN dotnet build
CMD ["dotnet","run"]
```

éxecution :

```bash
docker build .
```

l'image est ensuite ajouté (`docker image ls`)


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


