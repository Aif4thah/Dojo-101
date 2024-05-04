The kernel is at the center of the OS and controls everything the OS does, including managing memory, controlling the CPU, and even controlling the what the user sees on the screen.
The second element of the OS is often referred to as *user land* and includes nearly everything else.

Kernel is designed to be a protected or privileged area that can only be accessed by root or other priveleged accounts.
Most OS only provide access to *user land.*
Access to the kernel allows the user to change how the OS works, looks and feels.

#### What is a kernel module?
The kernel is the central nervous system of your OS, controlling everything it does, including managing interactions between hardware components and starting the necessary services. The kernel operates between the user applications you see and the hardware that runs everything, like the CPU, memory, and hard drive.
Linux is a monolithic kernel that enables the addition of kernel modules. They can be added or removed. Sometimes it will need to update for device drivers, video cards, BLE Devices and USB devices, filesystem drivers and even system extensions.

`LKMs` = *Loadable Kernel Modules*

`LKMs` have access to the lowest levels of the kernel by necessity, making them an incredibly vulnerable target for hackers.

#### Checking the Kernel Version
To check what your system is running type: `uname -a`
![[Pasted image 20240225150634.png]]The kernel will tell us:
- The distribution of our OS (Linux Kali)
- The Kernel build (6.5.6 and the date of the build 2023-10-09)
- The Architecture it's built for (x86 and x64)
- It also tells us it has  Symmetric Multiprocessing (SMP) (It can run on machines with multiple cores)

We can also have this info using: `cat /proc/version`

#### Kernel Tuning with sysctl
We can tune our kernel, meaning we can change memory allocations, enable networking features and even harden the kernel against outside attacks.

We can use the command `sysctl` to tune kernel options.
All the changes made with `sysctl` will only remain until we reboot our system.
To make permanent changes we can edit the file: `/etc/sysctl.conf`
You can possibly break your system with `sysctl` !

In order to enable Packet Forwarding for MITM attacks we can type:
`sysctl -w net.ipv4.ip=forward=1` (Edit will be lost once your system rebooted unless you edit `/etc/sysctl.conf`)

![[Pasted image 20240225152626.png]]![[Pasted image 20240225152644.png]]

To harden your OS we could disable ICMP echo requests by adding the line:
`net.ipv4.icmp_echo_ignore_all=1 `to make it more difficult to be spotted.
After adding the line, you will need to run `sysctl -p`

#### Managing Kernel Modules
The old way to manage modules was to use a group of commands build around the *insmod* suite. *insmod* stands for insert module and is intended to deal with modules.

The second way is to use the `modprobe` command.
to list all the modules that are installed we can use the command: `lsmod`

`lsmod` will list all of the modules, their size and what other modules may use them.

We can insert a module with `insmod` and remove a module with `rmmod`. These commands are not perfect since they do not take into account dependencies which might leave your kernel unstable or unusable.

To be safer, while managing modules, it is recommanded to use `modprobe`, which will take into account dependencies and decrease the risk of breaking your Kernel.

#### Finding more info with modinfo
To learn info about any of the kernel modules, we can use the `modinfo` command:

![[Pasted image 20240225153935.png]]
It also lists it's dependencies at the line : `depends:` 

#### Adding and removing modules with modprobe
To add or a module use :
`modprobe -a <module name>`

To remove a module use :
`modprobe -r <module name>`

The advantage of using `modprobe` and not `insmod` is that `modprobe` understands dependencies, options and installations and removal procedures and takes all of these into account before making changes.

#### Inserting and removing kernel a module

We can for example, install an unexisting module by typing:
`modprobe -a HackerAriseNewVideo`

Then to check if the module was properly installed, we can type:
`dmesg | grep video`

if there are any kernel messages with the word "video" in them, they will displayed here.

We could also remove that module by typing :
`modprobe -r HackerAriseNewVideo`