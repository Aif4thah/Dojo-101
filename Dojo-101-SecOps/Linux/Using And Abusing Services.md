
### Web Server
`apt-get install apache2` will install a web server running on our machine apache2:

To start a service we can  run:
service servicename start | stop | restart

`service apache2 start` will start a web server
`service apache2 stop` will stop a web server
`service apache2 restart` will restart a web server

We could edit the default apache2 page by typing:
![[Pasted image 20240126134119.png]]

![[Pasted image 20240126134149.png]]

On this default web page we could add a BEEF hook.js to get our target hooked.


### MariaDB / MySQL

We can start MySQL with: `systemctl start mysql`:

![[Pasted image 20240126134829.png]]

Next to access it, we need to authenticate using: `mysql -u root -p`
By default, mysql when installed for the root user does not have any password:
![[Pasted image 20240126135027.png]]
So let's change it:

type:
`select user, host, password from mysql.user;`
It should return:
![[Pasted image 20240126135240.png]]
Root has no password. To change that, type:
![[Pasted image 20240126135325.png]]
MySQL has three default databases:
- `information_schema` (Administrative DB)
- `performance_schema` (Administrative DB)
- `mysql` (Non Administrative DB)

Next, type: `use mysql;`
![[Pasted image 20240126135512.png]]

Now we can change the default password of root, type:
`update user set password = PASSWORD("thePasswordYouWant") where user = 'root';`

### Connecting / Accessing to a DB

To connect to a DB we can type: 
`mysql -u root -p` If we dont give it any IP Address, it will start our Local DB.

We could also connect to a DB with:
`mysql -u root -p 192.168.1.101`
This will make a connection to the DB that is stored on this address.

==Keep in mind that by default, there is no password for root unless one is set. <-- Vulnerability==

We can check the structure of the table using `describe` followed by the name of the table
`describe user` :
![[Pasted image 20240126141635.png]]



### SQL Cheet Sheat

- `show tables` <--Will show the different tables of the DB
- `select * from user` <-- Will show everything about the table user
- `select address from user` <-- Will only show address details about every user
- `select address from user where user='root'` <-- Will only show the address of the root user
- `show databases` will show the different databases that are stored on the server
- `describe` will show the database structure with the columns and rows


### PostgreSQL with Metasploit

We can start the postgreSQL with the syntax: `service postgresql start`
Then we can start metasploit with: `msfconsole`

Next, now that metasploit is running, we can setup PostgreSQL so that it stores data from any Metasploit activity on your system:

`msfdb init` will start the msfdatabase
next make sure you're root, otherwise this will not work.
type: `su postgres`
next, once logged in, we will create a user and password with:
`createuser msf_user -P`
After, you can create a DB and give it a owner with:
`createdb --owner=msf_user my_db_name` 

When you exit, it will bring us back to the prompt.
Next we can connect to our DB with:
`db_connect msf_user:password@127.0.0.1/my_db_name`

The db is running on our localhost, but we could also connect to an external DB if you know the name and IP of it.

to verify the connection we can type:
`db_status`
