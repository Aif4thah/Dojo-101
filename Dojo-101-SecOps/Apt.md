# APT debian

## Lister les paquets

```sh
dpkg -l
```

## info sur un paquet

```sh
dpkg -l apparmor

```

## les depots

```sh
cat /etc/apt/sources.list
```

## Lister les clé gpg

```sh
apt-key list
apt-key --keyring /etc/apt/trusted.gpg finger
```
