## Erasing Log Files (No logs, no crimes)
To erase logs we can use a tool called `shred`.

`shred --help`
Shred will delete a file and overwrite it several times. When a file is deleted, it exists. If you overwrite it, it will make it even harder to find the original content. Shred does that for us several times.

The more times a file is overwritten, the harder it will be to recover.
By default `shred` overwrites 4 times.
Overwriting large files can take up time. Especially the more you overwrite it.

if we use the `-f` option it will change the permission of the file to overwrite it.
if we use `-n` it will let us choose the amount of times we want the file to be overwritten.

we can type:
`shred -f -n 10 /var/log/auth.log*` 
The wild card asterix * * to shred all of the files that have been creatred by logrotate.
![[Pasted image 20240126113238.png]]

Now we can check to see if it was properly shredded, by using the  command:
`cat /var/log/auth.log1`

![[Pasted image 20240126113346.png]]
Now we see that the content of the file has been corrupted.

## Disabling Logging (Requires root priveleges)

to manipulate services use the syntax below:
`service servicename start | stop | restart`

To stop the logging daemon use the command:
`service rsyslog stop`

Once that is done, Linux will stop generating log files until the service is restarted.


To harden your OS we could disable ICMP echo requests by adding the line:
net.ipv4.icmp_echo_ignore_all=1 to make it more difficult to be spotted.
After adding the line, you will need to run sysctl -p

##### Covermyass tool
a tool avaible on github
https://github.com/sundowndev/covermyass/tree/master