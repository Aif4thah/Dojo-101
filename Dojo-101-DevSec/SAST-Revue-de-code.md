# Topic
1. what we are looking for
keyword
file //comment
## subtopic
`regex`
```code``` 

----------

# Authentication

1. Cleartext password
2. Weak hashs, Weak Algorithms
`[A-Fa-f0-9]{5,64}`
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

## spring security
1. check if Spring security is in pom.xml: `<groupId>org.springframework.security</groupId>`

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


## spring kafka
@KafkaListener

----------

# Session management

1. How sessions are handled
cookie
session

----------

# Privilèges

1. least privilege policy
chmod
sudo
runas

----------

# SQL

1. prepared statement
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

----------

# Inputs

1. Assume all imput is potentially malicious
2. Code Injection
3. Consider using the OWASP encoding library to sanitize input


## Concatenation

`(["'] ?[+.] )|([+.] ?["'])`

## XSS:

1. Check Parameters or other data within the URL query string and message body.
2. Check The URL file path.
3. Check HTTP request headers that might not be exploitable in relation to reflected XSS.
4. Check Any out-of-band routes via which an attacker can deliver data into the application.
### How prevent XSS:

1. Filter input on arrival. At the point where user input is received, filter as strictly as possible based on what is expected or valid input.
2. Encode data on output. At the point where user-controllable data is output in HTTP responses, encode the output to prevent it from being interpreted as active content. Depending on the output context, this might require applying combinations of HTML, URL, JavaScript, and CSS encoding.
3. Use appropriate response headers. To prevent XSS in HTTP responses that aren't intended to contain any HTML or JavaScript, you can use the Content-Type and X-Content-Type-Options headers to ensure that browsers interpret the responses in the way you intend.
4. Content Security Policy. As a last line of defense, you can use Content Security Policy (CSP) to reduce the severity of any XSS vulnerabilities that still occur.

### Header:
Content-Type
X-Content-Type-Options



### php

- prevent: regex + htmlentities + ENT_QUOTES

## java

- prevent: Filter your inputs with a whitelist of allowed characters and use a library such as Google Guava to HTML-encode your output for HTML contexts, or use JavaScript Unicode escapes for JavaScript contexts.

### Spring:

.contentSecurityPolicy

Spring MVC allows to automatically bind user input into object. Identify the controllers that handle state-changing requests (e.g. find the occurences of @RequestMapping) then verify if controls are in place (both on the controller or on the involved models). Limitations on the exploitation of the mass assignment can be, for example, in the form of:
	• list of bindlable fields via setAllowedFields method of the DataBinder class (e.g. binder.setAllowedFields(["username","password","email"]))
	• list of non-bindlable fields via setDisallowedFields method of the DataBinder class (e.g. binder.setDisallowedFields(["isAdmin"]))
It is also advisable to pay attention to the use of the @ModelAttribute annotation that allows to specify a different name/key.


----------

# TLS
## Spring
application.properties
```
 http
     .portMapper()              
        .http(8080).mapsTo(443);
```

### Spring sécurity

WebSecurityConfig
configure(HttpSecurity
<webapp>\src\main\java\<..SNIP...>\config\SecurityConfiguration.java
.requiresSecure()


----------

# Url:

1. Encryption
2. Servers/Clients is authenticated ?
`(https?|ftp|file)://(.*)`
url
URI
request

----------

# Other Bad Practices:

1. Code injection
eval
toString
setInterval
system
exec
cmd
printf
strcpy

## java

@ToString.Exclude //reco: @JsonIgnore and @JsonIgnoreProperties
runtime
getId

----------

# Process:

POST
request
response
param
stream
buffer
redirect //redirection vers url
location //redirection vers url
fwd //le parametre redirige vers une fonction

----------

# Files io:
file
AbsolutePath (peut etre bypassé, utiliser CanonicalPath)

----------

# Configurations:
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

----------

# CSRF:

1. CSRF can be performed ?
Token (Anti-csrf dans les form)

## IIS

ViewState

## Spring

WebSecurityConfig.java
http.csrf()
@EnableWebSecurity

----------

# Log:

1. verbosity
2. injection
log
debug
console

----------

# Deserialiation:

1. check how objects are send, recieved, re-serialized
stream
io

## Java

Java.io
serialization
Serializable
readObject
Serialize.java //fichier
### Spring

@RequestBody //maps the HttpRequest body to a transfer or domain object, enabling automatic deserialization
@ResponseBody //tells a controller that the object returned is automatically serialized into JSON and passed back into the HttpResponse object.

----------

# Race Conditions:

Thread
Dispose

## Python

Pickle
## C#

Dispose

----------

# Erreurs trop verbeuses:

try

## Java

StackTrace

----------

# BOF (à completer si revue de code en C/C++,Objective C):
Buff

----------

# Composant / librairies

## Dependancy check

```.\dependency-check.bat --scan "fichier.jar ou lib folder"```

----------

# Regex Bypass

1. find regex in code:

regex
pattern
compile
match
replace
2. char to encode (Hex, Unicode, B64 etc...)
3. logic errors
https://regex101.com/

----------

# API

## Spring

### Rappel: 

1. les starters sont dans le pom.xml (spring-boot-starter-<nom du starter>)
2. pour une requete https://.../greeting.html on va avoir:
3. Une class: src/main/java/com/example/restservice/Greeting.java
4. Un controler : src/main/java/com/example/restservice/GreetingController.java
5. le tout buildé avec java ou maven (mvnw)
6. Parfois c'est fait differement, il faut chercher les entrypoints à la main
6. pour la Doc on peut chercher un swagger dans le pom.xml ex: <artifactId>springfox-swagger-ui</artifactId> -> http://.../swagger-ui.html

## touver les points d'entrées et les paramètre



### Spring

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

----------

# XML + XXE

1. Disable all features that allow XXE or DTD: find librairies options
2. Test injection

## XML

XML
XMLinputFactory

----------

# Template injection

## AngularJS

1. Avoid mixing server-side and client-side templates. Instead, treat
templates only within one application context: either the server-side
or the client-side.

2. Reduce the scope of `ng-app` directive from an HTML’s document
body to specific DOM element context within the page itself.
Bind the data from the template to ng-bind or ng-bind-html to
ensure user input is being properly handled with Angular’s support
for output encoding and sanitization controls with these Angular
directives.

3. Use `ng-non-bindable` to make sure the data is not being treated
by Angular as an expression that needs to be evaluated and so
mitigating the Angular code injection.

4. `ngCsp` directive that offers compatibility with CSP

### si OnePage
HttpClient

### spring security in TypeScript

intercept

### a proscrire:

ng-bind-html-unsafe
$sce.trustAsHtml(value)
s angular.element()

## redirection

location

### whitelister les template 
bonne pratique: $sceDelegateProvider.resourceUrlWhitelist()

----------

# Compilation options:

## Java.Security.Policy - Java Security Manager

1. i.e custom policy: `java -Djava.security.manager -Djava.security.policy=jvm.policy -jar target/spring-petclinic-1.4.2.jar`
2. default JRE policy: `%JAVA_HOME%/lib/security/java.policy`
3. grant: specific permission
4. grant codeBase: code wich can be executed
6. exemple of permission to lunch tomcat: `permission java.net.SocketPermission "localhost:8080", "listen,resolve";`

----------

# Misc

## Java

1. Enable the Java security manager
2. Enable via JVM properties on startup:
```-Djava.security.manager```
3. Create a policy that you use for your applications:
```-Djava.security.policy==/my/custom.policy```