
### switched from ubuntu to bento

Initially used:

```rb
config.vm.box = 'ubuntu/xenial64'
```

But switched to because it has guest additions

```rb
config.vm.box = 'bento/ubuntu-16.04'
```

### skipping guest editions

if vagrant plugin list | grep vbguest

But you don't want guest additions you can add:

```rb
config.vbguest.auto_update = false
```

### xenial + cachier

```rb
## cachier very-broken with xenial
## https://github.com/fgrehm/vagrant-cachier/issues/175
if Vagrant.has_plugin?('vagrant-cachier')
  config.cache.scope = :machine
  config.cache.synced_folder_opts = {
    owner: "_apt",
    group: "_apt"
  }
end
```

### automating mysql install

tips for setting mysql root pass:

https://serversforhackers.com/video/installing-mysql-with-debconf

### mariadb + magento

decided to use mysql but was considering mariadb but once I discovered that magento doesn't officially support maria:

https://community.magento.com/t5/Installing-Magento-2/MySQL-5-6-or-MariaDB-10-1-3/td-p/34034

Also noticed ubuntu only uses 10.0 whereas 10.2 is more compatible with mysql 5.7:

https://mariadb.com/kb/en/mariadb/mariadb-vs-mysql-compatibility/#incompatibilities-between-mariadb-102-and-mysql-57
