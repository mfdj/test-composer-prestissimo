#!/usr/bin/env bash

mkdir -p .logs

# ~=~=~=~ HELPER FUNCTIONS ~=~=~=~

time_and_log() {
   local title
   local cmd
   local logfile
   local result

   (( $# == 2 )) || { echo expecting 2 arguments; return 1; }

   title=$1
   cmd=$2
   logfile=.logs/${title//\ /_}

   echo
   echo "»${title}«"
   echo "${cmd} &> $logfile"

   { time (bash -c "$cmd" &> "$logfile") } 2>&1 >/dev/null | tail +2
   result=$?

   return $result
}

time_and_log_vm() {
   time_and_log "$1 inside vm" "vagrant ssh -c '$2'"
}

fresh_box() {
   time_and_log 'boot vm' 'vagrant up' && \
     time_and_log_vm 'ensure db and users' '/vagrant/create-magento-db.sh'
}

vm_uuid() {
   VBoxManage list vms | grep 'xenial.*test-prestissimo' | awk '{print $2}' | tr -d '{}'
}

find_snapshot() {
   VBoxManage snapshot $(vm_uuid) showvminfo "$1" &> /dev/null
}

make_snapshot() {
   echo "Snapping $1"
   [[ $1 ]] || return 1
   VBoxManage snapshot $(vm_uuid) take "$1"
}

rollback_to_snapshot() {
   echo "Rolling back to $1"
   [[ $1 ]] || return 1
   vagrant suspend
   VBoxManage snapshot $(vm_uuid) restore "$1" && vagrant up &> /dev/null
}

test_scenario_0() {
   time_and_log 'say hi' 'echo hi'
   time_and_log 'say bye' 'echo bye'
}

test_scenario_1() {
   local install_flags='--no-interaction --no-suggest --prefer-dist --no-progress --profile'

   time_and_log_vm 'create magento 2.1.6 project' 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'
   time_and_log_vm 'install packages' "cd ./*2.1.6; composer install $install_flags"
}

test_scenario_2() {
   local create='composer create-project --no-interaction --prefer-dist --no-progress --profile'

   time_and_log_vm 'install magento 2.1.5' "$create magento/community-edition:2.1.5 community2.1.5"
   time_and_log_vm 'install magento 2.1.6' "$create magento/community-edition:2.1.6 community2.1.6"

   time_and_log_vm 'install laravel 5.3' "$create laravel/laravel:5.3.* laravel5.3"
   time_and_log_vm 'install laravel 5.4' "$create laravel/laravel:5.4.* laravel5.4"

   time_and_log_vm 'install symfony 2' "$create symfony/framework-standard-edition:2.* symfony2"
   time_and_log_vm 'install symfony 3' "$create symfony/framework-standard-edition:3.* symfony3"
}

test_scenario_3() {
   local create='composer create-project --no-interaction --prefer-dist --no-progress --profile'

   time_and_log_vm 'install magento 2.1.6' "$create magento/community-edition:2.1.6 community2.1.6-a"
   time_and_log_vm 'install magento 2.1.6' "$create magento/community-edition:2.1.6 community2.1.6-b"
   time_and_log_vm 'install magento 2.1.6' "$create magento/community-edition:2.1.6 community2.1.6-c"
}

run_scenario() {
   local run_scenario_n

   run_scenario_n=test_scenario_$1

   [[ $(type -t $run_scenario_n) != function ]] && {
      echo "No scenario defined: $run_scenario_n"
      return 1
   }

   echo && echo "~=~=~=~=~=~=~=~ $run_scenario_n ~=~=~=~=~=~=~=~=~=~"

   echo && echo ':::::: no-plugin run'
   echo
   rollback_to_snapshot 'base-install'
   $run_scenario_n

   echo && echo ':::::: with-prestissimo run'
   echo
   rollback_to_snapshot 'base-install'
   time_and_log_vm 'prestissimo plugin' 'composer global require "hirak/prestissimo:^0.3"'
   $run_scenario_n
}

# ~=~=~=~ PROGRAM ~=~=~=~

find_snapshot 'base-install' || {
   fresh_box && make_snapshot 'base-install'
}

find_snapshot 'base-install' || {
   echo 'base-install failed to build'
   exit 1
}

run_scenario 1
run_scenario 2
run_scenario 3
