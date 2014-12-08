mina_maintenance <a href="http://badge.fury.io/rb/mina_maintenance"><img src="https://badge.fury.io/rb/mina_maintenance.svg" alt="Gem Version" height="18"></a>
============

Maintenance Page Support For [Mina](http://nadarei.co/mina). Heavily inspired by [Capistrano::Maintenance](https://github.com/capistrano/maintenance)

## Installation

    gem install mina_maintenance
    
And require mina_maintenance tasks in your `deploy.rb` file:

    require 'mina_maintenance/tasks'
    
## Usage

Before using the maintenance tasks, you need to configure your webserver. How you do this depends on how your server is configured, but the following examples should help you on your way.

Application servers such as [Passenger](https://www.phusionpassenger.com) and [unicorn](http://unicorn.bogomips.org) requires you to set your public web directory to `current/public`. Both examples below are compatible with this setup.

Here is an example config for **nginx**. Note that this is just a part of the complete config, and will probably require modifications.

```
error_page 503 @503;

# Return a 503 error if the maintenance page exists.
if (-f /var/www/domain.com/shared/public/system/maintenance.html) {
  return 503;
}

location @503 {
  # Serve static assets if found.
  if (-f $request_filename) {
    break;
  }

  # Set root to the shared directory.
  root /var/www/domain.com/shared/public;
  rewrite ^(.*)$ /system/maintenance.html break;
}
```

And here is an example config for **Apache**. This will also need to be modified.

```
# Create an alias to the maintenance page used as error document.
Alias "/error" "/var/www/domain.com/shared/public/system/"
ErrorDocument 503 /error/maintenance.html

# Return 503 error if the maintenance page exists.
RewriteCond /var/www/domain.com/shared/public/system/maintenance.html -f
RewriteRule !^/error/maintenance.html - [L,R=503]

# Redirect all non-static requests to unicorn (or similar).
# Will not redirect any requests if the maintenance page exists.
RewriteCond /var/www/domain.com/shared/public/system/maintenance.html !-f
RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f
RewriteRule ^/(.*)$ balancer://unicornserver%{REQUEST_URI} [P,QSA,L]
```

## Available Tasks

* `maintenance:on`
* `maintenance:off`

## Available Options

| Option                    | Description                                                                          |
| ------------------------- | ------------------------------------------------------------------------------------ |
| maintenance_template      | Sets a local file with maintenance page template. If it's not specified, the default one will be used.|
| maintenance_basename      | Sets the basename of server's file used to display maintenance message. <br> _default:_ `maintenance`|
| maintenance_path          | Sets a path to the server's mainenance file on server. <br> _default:_ `/public/system/`|        

## Todo

* Write some tests

## Copyright

Copyright (c) 2014 Mike Bajur http://github.com/mbajur

See LICENSE for further details.
