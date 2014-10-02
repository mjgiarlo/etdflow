# etdFlow

## Development Setup

Bundle

Create MySQL databases: etdflow\_development and etdflow\_test

```
rake db:schema:load
```

```
rake db:test:clone
```

Seed your development database:

```
rake db:seed
```

Jetty is a packaged development environment for Fedora and Solr. You can initialize and start it with the commands:

```
rake jetty:clean jetty:config jetty:start
```

## Deployment

Make sure you've symlinked `~/.ssh/id_deploy_rsa -> ~/.ssh/id_rsa` (and the public version too). ITS SAS depends on 
 this setup.
