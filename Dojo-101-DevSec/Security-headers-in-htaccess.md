# headers in htaccess

# exemple contenu du fichier .htaccess:

```xml
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.html$ - [L]
RewriteCond %{SERVER_PORT} 80
RewriteRule .* https://%{HTTP_HOST}%{REQUEST_URI} [R=301,L]
</IfModule>
<IfModule mod_headers.c>
    Header set Content-Security-Policy "default-src 'self'; child-src 'none'; object-src 'none'; frame-ancestors 'self'; form-action 'self'"
	Header set X-XSS-Protection "1; mode=block"
    Header set X-Frame-Options "SAMEORIGIN"
    Header set X-Content-Type-Options "nosniff"
    Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
    Header set Referrer-Policy "same-origin"
    Header set Feature-Policy "geolocation 'self'; vibrate 'none'"
</IfModule>
```