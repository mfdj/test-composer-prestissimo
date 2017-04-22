
### switched from ubuntu to bento

Initially used:

```rb
config.vm.box = 'ubuntu/xenial64'
```

But switched to bento because it has guest additions

```rb
config.vm.box = 'bento/ubuntu-16.04'
```

### skipping guest editions

if `vagrant plugin list | grep vbguest` but you don't want guest additions you can add:

```rb
config.vbguest.auto_update = false
```

### virtual-box snapshots instead of vagrant-cachier

Some background.

To make sure that composer's cache wasn't influencing test cases I was rebuilding the box
from scratch. This takes awhile, especially with all of the lamp depdendncies needed to run 
magento 2.

To speed up testing I had the idea to use the vagrant-cachier plugin so apt-get wouldn't constnatly be hitting
the network during test runs. What I discovered was that cachier (is kindly) *also* aware of composer and caches it's
cache.

Rather than depend on cachier I've opted to use Virtual Box's snapshot capabilitiy to get the baseline state for running
the tests.

**xenial + cachier**

When I was using the some cachier I encounted some interesting (known) issues with Xenial.

see: https://github.com/fgrehm/vagrant-cachier/issues/175

This config seemed to work *only* for apt-get:

```rb
if Vagrant.has_plugin?('vagrant-cachier')
  config.cache.scope = :box
  config.cache.synced_folder_opts = {
    owner: "_apt",
    group: "_apt"
  }
end
```

Can't remember the difference between `:machine` and `:box` but I had better luck with `:box`. 

Composer ended up having a problem with this permissions because it was run as the vagrant user. I suspect that 
adding `_apt` user to the `vagrant` group might be a better overall solution to the issue, although I didn't test this 
approach.

### automating mysql install

Tips for setting mysql root pass: https://serversforhackers.com/video/installing-mysql-with-debconf

### mariadb + magento

decided to use mysql but was considering mariadb but once I discovered that magento doesn't officially support maria:

https://community.magento.com/t5/Installing-Magento-2/MySQL-5-6-or-MariaDB-10-1-3/td-p/34034

Also noticed ubuntu only uses 10.0 whereas 10.2 is more compatible with mysql 5.7:

https://mariadb.com/kb/en/mariadb/mariadb-vs-mysql-compatibility/#incompatibilities-between-mariadb-102-and-mysql-57
