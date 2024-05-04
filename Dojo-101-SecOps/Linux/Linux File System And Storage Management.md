`cd /dev`  (`/dev` = device) <--In here you will find everything that is related to your filesystem and storage management.

Linux commands to 
`fdisk -l `<-- Used to check partitions and see which one has free space.

`lsblck` (List block devices and info)<-- Used to check how devices communicate, either characters (keyboard, mice) or block
of data (HDD, SSD, Flashdrives....) 
The letters represent the two ways devices communicate in and out:
![[Pasted image 20240126093810.png]]

`c` means characters
`b` means blocks

`df` (Disk Free) <-- Used to check disk space and other  info:
![[Pasted image 20240126093923.png]]

By default `df` will list all of the mounted devices, but we could also check for `df sdb` or another file storage system.

To mount a Hard Drive or SSD type:
`mount /dev/sdb1 /mnt `   (`/mnt` is usually used for HDD, SSD etc...)

To mount a Flash Drive type:
`mount /dev/sdc1 /media`   (`/media` is usually used for Flashdrives)

To unmount a device type:
`umount /dev/sdb1`

`sda1` if we decompose it `sd` = SATA Hard Drive, `a `= First Hard Drive, `1` =First Partition on the drive

`fsck`  (file system check) checks for file system errors and repairs the damage if possible, or else puts the bad area into a `bad blocks` table

before you run `fsck` you need to unmount the device

You can run `fsck -p /dev/sdb1` to automically repair any problems with the device. 