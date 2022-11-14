# Authentication

1. Cleartext password
2. Weak hashs, Weak Algorithms

```regex
[A-Fa-f0-9]{5,64}
password
passwd
key
secret
token
algo
sha
md5
DES
xor
random
salt
authent
user
form
```

## spring security
1. check if Spring security is in pom.xml: `<groupId>org.springframework.security</groupId>`

```java
@EnableWebSecurity
PasswordEncoder
WebSecurityConfig //most likely in WebSecurityConfig.java or \config\SecurityConfiguration.java
configure(HttpSecurity
UserDetailsService
WebSecurityConfigurerAdapter
http.addFilterBefore
UsernamePasswordAuthenticationFilter
authenticationJwtTokenFilter
UsernamePasswordAuthenticationFilter
authenticationFilter 
passwordExpirationFilter
AuthTokenFilter;
@KafkaListener
```


# Session management

1. How sessions are handled

```
cookie
session
```

# Privilèges

1. least privilege policy

```shell
chmod
sudo
```

```powershell
runas
```


# SQL

1. prepared statement

```SQL
`(.*)FROM\b(.*)`
INSERT
DROP
select
update
delete
driver
data
sql
exec
@Query
```


# Inputs

1. Assume all imput is potentially malicious
2. Code Injection
3. Consider using the OWASP encoding library to sanitize input

## Concatenation

`(["'] ?[+.] )|([+.] ?["'])`

## XSS:


```js
document.write(),
document.writeln
```


```java
.contentSecurityPolicy
```


# TLS

## Spring

application.properties
```
 http
     .portMapper()              
        .http(8080).mapsTo(443);
```

### Spring sécurity

```java
WebSecurityConfig
configure(HttpSecurity
<webapp>\src\main\java\<..SNIP...>\config\SecurityConfiguration.java
.requiresSecure()
```


# Url:

1. Encryption
2. Servers/Clients is authenticated ?

```regex
(https?|ftp|file)://(.*)
url
URI
request
```


# Other Bad Practices:

1. Code injection

```
eval
toString
setInterval
system
exec
cmd
printf
strcpy
```

```java
@ToString.Exclude //reco: @JsonIgnore and @JsonIgnoreProperties
runtime
getId
```


# Process:

```regex
POST
request
response
param
stream
buffer
redirect //redirection vers url
location //redirection vers url
fwd //le parametre redirige vers une fonction
```


# Files io:

```regex
file
AbsolutePath (peut etre bypassé, utiliser CanonicalPath)
```


# Configurations:

```file
*.xml
*.yml
*.conf
*.properties
## Tomcat
server.xml
## IIS
web.config
## Apache
web.xml
## php
php.ini
```


# CSRF:

1. CSRF can be performed ?
Token (Anti-csrf dans les form)

## IIS

```c#
ViewState
```

## Spring

```java
WebSecurityConfig.java
http.csrf()
@EnableWebSecurity
```

# Log:

1. verbosity
2. injection
log
debug
console


# Deserialiation:

1. check how objects are send, recieved, re-serialized
stream
io


```java
Java.io
serialization
Serializable
readObject
Serialize.java //fichier
@RequestBody //maps the HttpRequest body to a transfer or domain object, enabling automatic deserialization
@ResponseBody //tells a controller that the object returned is automatically serialized into JSON and passed back into the HttpResponse object.
```


```php
unserialize()
```

```python
pickle.loads()
yaml.load()
```

```c#
JsonConvert
DeserializeObject
TypeNameHandling.All
```

```ruby
Marshall.load(),
yaml.load()
```


# Race Conditions:

```regex
Thread
Dispose
```



# Erreurs trop verbeuses:

```regex
try
```

```java
StackTrace
```

```c#
Diagnostic
```


# BOF (à completer si revue de code en C/C++,Objective C):

```regex
Buff
```


# Composant / librairies

## Dependancy check

```powershell
.\dependency-check.bat --scan "fichier.jar ou lib folder"
```


# Regex Bypass

1. find regex in code:

```regex
regex
pattern
compile
match
replace
```

2. char to encode (Hex, Unicode, B64 etc...)
3. logic errors
https://regex101.com/



# RCE


```php
eval()
assert()
system()
exec()
shell_exec()
passthru()
popen()
backticks(`CODE`)
include()
require()
```

```python
eval()
exec()
os.system()
```

```c#
Diagnostic
PSobject
```

```ruby
System()
exec()
%x()
backticks(`CODE`)
```


# API

## spring 

```java
`@\w{3,8}mapp\w*\(.*\)` // liste les endpoits, mais pas les paramètres
@PathVariables
@RequestParam
@RequestMapping
@GetMapping
@PostMapping
@ResponseBody
@Controller
@Configuration
@SpringBootApplication
@EnableAutoConfiguration
@ComponentScan
@ApiOperation
interface
ServletRegistrationBean
endpoint.publish(
addViewController(
  java.util.Map // attention a ne pas confondre map = key value class
*.properties // nom de fichiers
*Controller.java // nom de fichiers
context.xml //nom de fichier
```


# XML + XXE

1. Disable all features that allow XXE or DTD: find librairies options
2. Test injection

## XML

XML
XMLinputFactory


# Template injection

## AngularJS

1. Avoid mixing server-side and client-side templates. Instead, treat templates only within one application context: either the server-side or the client-side.

2. Reduce the scope of `ng-app` directive from an HTML’s document body to specific DOM element context within the page itself. Bind the data from the template to ng-bind or ng-bind-html to ensure user input is being properly handled with Angular’s support for output encoding and sanitization controls with these Angular directives.

3. Use `ng-non-bindable` to make sure the data is not being treated by Angular as an expression that needs to be evaluated and so mitigating the Angular code injection.

4. `ngCsp` directive that offers compatibility with CSP

# Open redirect

```js
document.location.href()
HttpClient
intercept
ng-bind-html-unsafe
$sce.trustAsHtml(value)
s angular.element()
```



# Compilation options:

## Java.Security.Policy - Java Security Manager

1. i.e custom policy: `java -Djava.security.manager -Djava.security.policy=jvm.policy -jar target/spring-petclinic-1.4.2.jar`
2. default JRE policy: `%JAVA_HOME%/lib/security/java.policy`
3. grant: specific permission
4. grant codeBase: code wich can be executed
6. exemple of permission to lunch tomcat: `permission java.net.SocketPermission "localhost:8080", "listen,resolve";`

## Java

1. Enable the Java security manager
2. Enable via JVM properties on startup:
```-Djava.security.manager```
3. Create a policy that you use for your applications:
```-Djava.security.policy==/my/custom.policy```