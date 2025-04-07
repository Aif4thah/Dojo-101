# python basics

## shebang linux

```python
#!/usr/bin/env python3
# -*- coding:utf-8 -*-
```

## Version

```python
import sys
sys.version
```


## install dependances from sh / pwsh

```bash
pip install <package>
pip list
```

## commentaires

```python
# commentaire
"""
commentaires
"""
```

## variable

```python
a = "chaine de chars"
type(a)
dir(a)
help(str)
a.__len__()
a.upper()

```

## saisies utilisateur et affichage

```python
var = input("saisie : ")
print(f"{var.__len__()} caractères saisis")
```

Il faut néanmoins rester prudents avec les saisies utilisateurs.


## Conditions

```python
"""
== : égal à
!= : différent de
< : inférieur à
> : supérieur à
<= : inférieur ou égal à
>= : supérieur ou égal à
"""

x = 5
if x > 2:
    print("x est plus grand que 2")
else:
    print("x est plus petit ou égal à 2")
```

## Conditions ternaires

```python
x = 5
y = "plus grand que 2" if x > 2 else "plus petit ou égal à 2"
```

## Boucles for

```python
for i in range(5):
    print(i)
```

## Boucles foreach

```python
fruits = ["pomme", "banane", "cerise"]
for fruit in fruits:
    print(fruit)
```

## Boucles oneline

```python
[print(i) for i in range(4)]
```

## Exception et gestion des erreurs

```python
try:
    1/0
except Exception as err:
    print(type(err).__name__)
```

## linux time:

```python
import time
time.ctime(152546)
#'Fri Jan  2 19:22:26 1970'
```

## base64:

```python
import base64
base64.b64encode(b'test')
#'dGVzdA=='
```

## Hexlify:

```python
import binascii
binascii.hexlify('A')
#'41'
binascii.unhexlify('41') 
#'A'
```

## file:

```python
with open("nomDuFichier", 'r') as f:
    line = f.readline()
    while line:
        print(line)
        line = f.readline() #ligne suivante
 ```               

## commands

```python
import os
os.system("dir")
```

## Process:

```python
import subprocess

scan = subprocess.Popen(["nmap","-sP","127.0.0.1","-oG", "test" ], stdout=subprocess.PIPE)
while scan.poll() is None: #on attend la fin du process
    if scan.returncode == 0:
        print("[*] scan arp terminé")
```

## mini serveur web:

```bash
python3 -m http.server
python -m SimpleHTTPServer
sudo python3 -m http.server 80
```

## binaire et char:

```python
import binascii
bin(int(binascii.hexlify(b'Dojo-101'), 16))[2:]
binascii.unhexlify('%x' % int('0b' + '100010001101111011010100110111100101101001100010011000000110001', 2))
```

## url decode:

```python
import urllib.parse
encodedStr = 'Hell%C3%B6%20W%C3%B6rld%40Python'
urllib.parse.unquote(encodedStr)
'Hellö Wörld@Python'
```

## socket

Connection sur la couche TCP/UDP

```python
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(('taisen.fr',443))
sock.send(b'test')
sock.recv(1024)
sock.close()
```


## url encode:

```python
import urllib.parse
urllib.parse.quote('&')
#'%26'
```

## http.client:

```python
import http.client
```

### GET

```python
connection = http.client.HTTPSConnection("www.google.com")
connection.request("GET", "/")
response = connection.getresponse()
print("Status: {} and reason: {}".format(response.status, response.reason))
response.read()

connection.close()
```

### POST

```python
conn = http.client.HTTPSConnection('enirdd6d0146.x.pipedream.net')
conn.request("POST", "/", '{ "name": "Princess Leia" }', {'Content-Type': 'application/json'})
```

## Request

### GET

```python
import requests

base_url = "https://localhost:3000"
url = f"{base_url}/?lang=english"
token = "ey...................."

headers = {
    "Authorization": f"Bearer {token}"
}

response = requests.get(url, headers=headers, verify=False)

# Vérification des conditions de correspondance
if response.status_code == 200 and ("success" in response.text or "16-bit" in response.text):
    print("Condition matched and status is 200")
else:
    print(f"Received status code: {response.status_code} with no matching content")
```


### POST

```python
import requests

url = "http://localhost:4000/Login"
payload = {
    "user": "user",
    "passwd": "password"
}
headers = {
    "Content-Type": "application/json"
}

response = requests.post(url, json=payload, headers=headers)

if response.status_code == 401:
    print("Unauthorized access - status code 401")
else:
    print(f"Received status code: {response.status_code}")
```


## request + BeautifulSoup

### POST

```python
import requests
url = "http://staging-order.mango.htb"
headers = {'Content-type': 'application/x-www-form-urlencoded'}
post_data = "username=admin&password=admin&login=login"
r = requests.post(url, data=post_data, headers=headers, allow_redirects=False)
```

### Parser le html

```python
import requests
from bs4 import BeautifulSoup

response = requests.get("http://taisen.fr")
soup = BeautifulSoup(response.text, 'html.parser')
print(soup.find('h1').text)
```

## conversion char / Unicode / ascci:

```python
ord('A')
65
chr(65)
'A'
```

## little indian:

```python
from struct import pack
pack('<I', 0x08048474)
```

## avoir un shell ou corriger un reverseshell foireux 

```bash
python -c "import pty;pty.spawn('/bin/bash')"
```

## strings

```python
import string
string.printable
#'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'
string.ascii_letters
#'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
string.digits
#'0123456789'
```

## fonction

```python
def multipar2(i):
    return i*2
multipar2(4)
```

## faire appel à une fonction si le script est lancé directement

```python
if __name__ == "__main__":
    pass
```

## multithreading

```python
import threading
threading.Thread( target = <fonction>, args = [ <argument> ] ).start()
```

## Fuzzing exemple

