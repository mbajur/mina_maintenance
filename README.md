mina_maintenance <a href="http://badge.fury.io/rb/mina_maintenance"><img src="https://badge.fury.io/rb/mina_maintenance.svg" alt="Gem Version" height="18"></a>
============

Maintenance Page Support For [Mina](http://nadarei.co/mina)

## Installation

    gem install mina_maintenance

## Usage example

    require 'mina_maintenance/tasks'

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
