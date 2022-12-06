### Collecte preuves

## outil dc3dd: 

fork de dd mais qui tolère les clusters défectueux

`$ dc3dd if=/dev/sdb hof=/mnt/extdrive/WKS042.dd log=/mnt/extdrive/dd_WKS042.log`

Pour le montage il faut determiner  le secteur du début de partition (NTFS)

`$ mmls WKS042.dd`

