Debian uses ***The rsyslog Logging Daemon***
It is used to automatically log events on your computer
The name of the Daemon is called: *syslogd*

There are also a couple of variations of of syslog including:
- *rsyslog*
- *syslog-ng*

Kali linux is based on Daemon, so by default it uses *rsyslog*

We can use the `locate` command to find all files related to *rsyslog*
![[Pasted image 20240126104135.png]]

we can open the *rsyslog.conf* (config file). 
We can use any editor to open it such as *vim* or *nano*.
The interesting part of the file is the rule section. Which will determine what events will be logged:
![[Pasted image 20240126105730.png]]
*Facility.priority           Action*

The *facility* references the program such as mail, kernel or lpr whose messages are being logged. 
The *priority* will determine what kind of messages to log for that program.

auth,authpriv.* = Security / Authorization Messages
*cron* = Clock Daemons
*Daemon* = Other Daemons
*Kern* = Kernel Messages
*lpr* = Printing System
*Mail* = Mail System
*User* = Generic user-level messages

==Add Priorities==

*Automatically Cleaning Up Logs With Logrotate*
Logrotate is used to determine the balance between deleting log files and keeping them.
`nano /etc/logrotate.conf` 

![[Pasted image 20240126110705.png]]

Check [[Remaining Stealthy]] to camouflage your traces with log files

