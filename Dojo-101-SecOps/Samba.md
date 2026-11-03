# Samba

Installation d'un serveur Samba

```sh
apt install samba 

systemctl start smbd.service

mkdir payload

cp /etc/samba/smb.conf /etc/samba/smb.old


sudo -i
cat <<EOF > /etc/samba/smb.conf.d/sniper-share.conf
[share]
path = /home/michael/Documents/Projets/01HackTheBox/Sniper/payload
browseable = yes
read only = yes
guest ok = yes
EOF
exit

systemctl restart smbd.service 
```

> [!TIP]
> penser à modifier iptables si besoin

Si besoin d'ecrire sur le share depuis les machines victimes

```txt
[share]
path = /home/michael/Documents/Projets/01HackTheBox/Sniper/payload
browseable = yes
writeable = yes
guest ok = yes
force user = michael
```

---

*Dojo-101 — [🏠 Sommaire principal](../README.md) • [📂 Sommaire du thème](./README.md) • [💖 Soutenir ce projet sur GitHub Sponsors](https://github.com/sponsors/Aif4thah/)*
