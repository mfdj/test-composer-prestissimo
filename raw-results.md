
```sh
composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install
composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile
```

#### run 1

- create-project: 0m59.074s － 0m48.644s = 10.43s (1.214×) faster
- install: 1m43.359s － 0m9.190s = 94.169s (11.24×) faster

```sh
→ ./test-prestissimo.sh 
running: »boot vm« as »vagrant up« and logging to .logs/boot_vm

real  0m4.479s
user  0m2.574s
sys   0m0.580s
running: »ensure db and users inside vm« as »vagrant ssh -c '/vagrant/create-magento-db.sh'« and logging to .logs/ensure_db_and_users_inside_vm

real  0m2.918s
user  0m2.017s
sys   0m0.344s
Snapping base-install
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Snapshot taken. UUID: 7e5cd901-5a66-4e70-8baf-2be5577d364a

~=~=~=~=~=~=~=~ normal run ~=~=~=~=~=~=~=~=~=~
Rolling back to base-install
==> test-prestissimo: Saving VM state and suspending execution...
Restoring snapshot 7e5cd901-5a66-4e70-8baf-2be5577d364a
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
running: »create magento 2.1.6 project inside vm« as »vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'« and logging to .logs/create_magento_2.1.6_project_inside_vm

real  0m59.074s
user  0m1.941s
sys   0m0.330s
running: »install packages inside vm« as »vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile'« and logging to .logs/install_packages_inside_vm

real  1m43.359s
user  0m1.974s
sys   0m0.351s

~=~=~=~=~=~=~=~ prestissimo run ~=~=~=~=~=~=~=~=~=~
Rolling back to base-install
==> test-prestissimo: Saving VM state and suspending execution...
Restoring snapshot 7e5cd901-5a66-4e70-8baf-2be5577d364a
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
running: »prestissimo plugin inside vm« as »vagrant ssh -c 'composer global require "hirak/prestissimo:^0.3"'« and logging to .logs/prestissimo_plugin_inside_vm

real  0m22.774s
user  0m2.033s
sys   0m0.352s
running: »create magento 2.1.6 project inside vm« as »vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'« and logging to .logs/create_magento_2.1.6_project_inside_vm

real  0m48.644s
user  0m1.989s
sys   0m0.339s
running: »install packages inside vm« as »vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile'« and logging to .logs/install_packages_inside_vm

real  0m9.190s
user  0m2.005s
sys   0m0.354s

```

#### run 2

- create-project: 1m0.027s － 0m49.537s = 10.49s (1.211×) faster
- install: 1m45.100s － 0m10.131s = 94.969s (10.374×) faster


```sh
→ ./test-prestissimo.sh 

~=~=~=~=~=~=~=~ normal run ~=~=~=~=~=~=~=~=~=~
Rolling back to base-install
==> test-prestissimo: Saving VM state and suspending execution...
Restoring snapshot 7e5cd901-5a66-4e70-8baf-2be5577d364a
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
running: »create magento 2.1.6 project inside vm« as »vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'« and logging to .logs/create_magento_2.1.6_project_inside_vm

real  1m0.027s
user  0m1.973s
sys   0m0.329s
running: »install packages inside vm« as »vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile'« and logging to .logs/install_packages_inside_vm

real  1m45.100s
user  0m1.952s
sys   0m0.355s

~=~=~=~=~=~=~=~ prestissimo run ~=~=~=~=~=~=~=~=~=~
Rolling back to base-install
==> test-prestissimo: Saving VM state and suspending execution...
Restoring snapshot 7e5cd901-5a66-4e70-8baf-2be5577d364a
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
running: »prestissimo plugin inside vm« as »vagrant ssh -c 'composer global require "hirak/prestissimo:^0.3"'« and logging to .logs/prestissimo_plugin_inside_vm

real  0m20.682s
user  0m1.958s
sys   0m0.334s
running: »create magento 2.1.6 project inside vm« as »vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'« and logging to .logs/create_magento_2.1.6_project_inside_vm

real  0m49.537s
user  0m1.967s
sys   0m0.345s
running: »install packages inside vm« as »vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile'« and logging to .logs/install_packages_inside_vm

real  0m10.131s
user  0m1.957s
sys   0m0.368s

```

#### run 3

- create-project: 1m0.079s － 0m46.966s = 13.113s (1.279×) faster
- install: 1m44.807s － 0m9.511s = 95.296s (11.02×) faster

```sh
→ ./test-prestissimo.sh 

~=~=~=~=~=~=~=~ normal run ~=~=~=~=~=~=~=~=~=~
Rolling back to base-install
==> test-prestissimo: Saving VM state and suspending execution...
Restoring snapshot 7e5cd901-5a66-4e70-8baf-2be5577d364a
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
running: »create magento 2.1.6 project inside vm« as »vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'« and logging to .logs/create_magento_2.1.6_project_inside_vm

real  1m0.079s
user  0m1.995s
sys   0m0.334s
running: »install packages inside vm« as »vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile'« and logging to .logs/install_packages_inside_vm

real  1m44.807s
user  0m1.953s
sys   0m0.354s

~=~=~=~=~=~=~=~ prestissimo run ~=~=~=~=~=~=~=~=~=~
Rolling back to base-install
==> test-prestissimo: Saving VM state and suspending execution...
Restoring snapshot 7e5cd901-5a66-4e70-8baf-2be5577d364a
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
running: »prestissimo plugin inside vm« as »vagrant ssh -c 'composer global require "hirak/prestissimo:^0.3"'« and logging to .logs/prestissimo_plugin_inside_vm

real  0m20.596s
user  0m2.096s
sys   0m0.351s
running: »create magento 2.1.6 project inside vm« as »vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'« and logging to .logs/create_magento_2.1.6_project_inside_vm

real  0m46.966s
user  0m1.894s
sys   0m0.338s
running: »install packages inside vm« as »vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile'« and logging to .logs/install_packages_inside_vm

real  0m9.511s
user  0m2.091s
sys   0m0.402s
```
