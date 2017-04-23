
~=~=~=~=~=~=~=~ test_scenario_1 ~=~=~=~=~=~=~=~=~=~

:::::: no-plugin run

»create magento 2.1.6 project inside vm«
vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install' &> .logs/create_magento_2.1.6_project_inside_vm
real    0m55.531s
user    0m1.918s
sys     0m0.338s

»install packages inside vm«
vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile' &> .logs/install_packages_inside_vm
real    1m43.844s
user    0m1.934s
sys     0m0.361s

:::::: with-prestissimo run

»prestissimo plugin inside vm«
vagrant ssh -c 'composer global require "hirak/prestissimo:^0.3"' &> .logs/prestissimo_plugin_inside_vm
real    0m18.208s
user    0m1.885s
sys     0m0.342s

»create magento 2.1.6 project inside vm«
vagrant ssh -c 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install' &> .logs/create_magento_2.1.6_project_inside_vm
real    0m47.719s
user    0m1.883s
sys     0m0.326s

»install packages inside vm«
vagrant ssh -c 'cd ./*2.1.6; composer install --no-interaction --no-suggest --prefer-dist --no-progress --profile' &> .logs/install_packages_inside_vm
real    0m9.205s
user    0m1.893s
sys     0m0.338s

~=~=~=~=~=~=~=~ test_scenario_2 ~=~=~=~=~=~=~=~=~=~

:::::: no-plugin run

»install magento 2.1.5 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.5 community2.1.5' &> .logs/install_magento_2.1.5_inside_vm
real    2m41.910s
user    0m1.918s
sys     0m0.339s

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6' &> .logs/install_magento_2.1.6_inside_vm
real    1m5.129s
user    0m1.904s
sys     0m0.349s

»install laravel 5.3 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile laravel/laravel:5.3.* laravel5.3' &> .logs/install_laravel_5.3_inside_vm
real    1m54.431s
user    0m1.905s
sys     0m0.333s

»install laravel 5.4 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile laravel/laravel:5.4.* laravel5.4' &> .logs/install_laravel_5.4_inside_vm
real    0m29.506s
user    0m1.865s
sys     0m0.328s

»install symfony 2 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile symfony/framework-standard-edition:2.* symfony2' &> .logs/install_symfony_2_inside_vm
real    0m47.271s
user    0m1.872s
sys     0m0.324s

»install symfony 3 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile symfony/framework-standard-edition:3.* symfony3' &> .logs/install_symfony_3_inside_vm
real    0m22.736s
user    0m1.904s
sys     0m0.336s

:::::: with-prestissimo run

»prestissimo plugin inside vm«
vagrant ssh -c 'composer global require "hirak/prestissimo:^0.3"' &> .logs/prestissimo_plugin_inside_vm
real    0m20.913s
user    0m1.869s
sys     0m0.325s

»install magento 2.1.5 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.5 community2.1.5' &> .logs/install_magento_2.1.5_inside_vm
real    0m55.682s
user    0m1.873s
sys     0m0.323s

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6' &> .logs/install_magento_2.1.6_inside_vm
real    0m53.151s
user    0m1.881s
sys     0m0.330s

»install laravel 5.3 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile laravel/laravel:5.3.* laravel5.3' &> .logs/install_laravel_5.3_inside_vm
real    0m48.737s
user    0m1.904s
sys     0m0.334s

»install laravel 5.4 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile laravel/laravel:5.4.* laravel5.4' &> .logs/install_laravel_5.4_inside_vm
real    0m16.867s
user    0m1.877s
sys     0m0.332s

»install symfony 2 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile symfony/framework-standard-edition:2.* symfony2' &> .logs/install_symfony_2_inside_vm
real    0m14.129s
user    0m1.872s
sys     0m0.330s

»install symfony 3 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile symfony/framework-standard-edition:3.* symfony3' &> .logs/install_symfony_3_inside_vm
real    0m13.836s
user    0m1.858s
sys     0m0.326s

~=~=~=~=~=~=~=~ test_scenario_3 ~=~=~=~=~=~=~=~=~=~

:::::: no-plugin run

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6-a' &> .logs/install_magento_2.1.6_inside_vm
real    2m36.796s
user    0m1.892s
sys     0m0.326s

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6-b' &> .logs/install_magento_2.1.6_inside_vm
real    0m41.479s
user    0m1.925s
sys     0m0.333s

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6-c' &> .logs/install_magento_2.1.6_inside_vm
real    0m38.687s
user    0m1.908s
sys     0m0.335s

:::::: with-prestissimo run

»prestissimo plugin inside vm«
vagrant ssh -c 'composer global require "hirak/prestissimo:^0.3"' &> .logs/prestissimo_plugin_inside_vm
real    0m17.965s
user    0m1.879s
sys     0m0.322s

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6-a' &> .logs/install_magento_2.1.6_inside_vm
real    0m53.840s
user    0m1.892s
sys     0m0.335s

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6-b' &> .logs/install_magento_2.1.6_inside_vm
real    0m42.389s
user    0m1.883s
sys     0m0.336s

»install magento 2.1.6 inside vm«
vagrant ssh -c 'composer create-project --no-interaction --prefer-dist --no-progress --profile magento/community-edition:2.1.6 community2.1.6-c' &> .logs/install_magento_2.1.6_inside_vm
real    0m41.153s
user    0m1.901s
sys     0m0.324s
