## SSH re-install VM
Ne pas garder les cléfs par défaut sur les serveur ssh (attaque man in the middle)

cd /etc/ssh/
mkdir default_kali_keys
mv ssh_host_* default_kali_keys/
 
dpkg-reconfigure openssh-server

md5sum ssh_host_*

cd default_kali_keys/
md5sum *

systemctl restart ssh


