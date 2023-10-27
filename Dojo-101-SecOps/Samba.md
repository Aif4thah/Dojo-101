# Samba

sudo apt install samba #installé par défaut sous kali

sudo systemctl start smbd.service 

michael@k:~/Documents/Projets/01HackTheBox/Sniper$ mkdir payload


sudo cp /etc/samba/smb.conf /etc/samba/smb.old


sudo -i
[share]
path = /home/michael/Documents/Projets/01HackTheBox/Sniper/payload
browseable = yes
read only = yes
guest ok = yes
EOF
exit

sudo systemctl restart smbd.service 

### penser à modifier iptables si besoin


## si besoin d'ecrire sur le share depuis les machines victimes:

[share]
path = /home/michael/Documents/Projets/01HackTheBox/Sniper/payload
browseable = yes
writeable = yes
guest ok = yes
force user = michael


