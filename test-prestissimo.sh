#!/usr/bin/env bash

mkdir -p .logs

# ~=~=~=~ HELPER FUNCTIONS ~=~=~=~

time_and_log() {
   (( $# == 2 )) || { echo expecting 2 arguments; return 1; }
   title=$1
   cmd=$2

   logfile=.logs/${title//\ /_}

   echo "running: »${title}« as »${2}« and logging to $logfile"
   time (bash -c "$cmd" &> "$logfile")
   return $?
}

time_and_log_vm() {
   (( $# == 2 )) || { echo expecting 2 arguments; return 1; }
   time_and_log "$1 inside vm" "vagrant ssh -c '$2'"
}

fresh_box() {
   time_and_log 'vagrant up' 'vagrant up' && \
     time_and_log_vm 'create magento-db' '/vagrant/create-magento-db.sh' && \
     time_and_log_vm 'create 2.1.2' 'composer create-project magento/community-edition:2.1.2 community2.1.2 --no-install' && \
     time_and_log_vm 'create 2.1.3' 'composer create-project magento/community-edition:2.1.3 community2.1.3 --no-install'

   return $?
}

vm_uuid() {
   VBoxManage list vms | grep 'xenial.*default' | awk '{print $2}' | tr -d '{}'
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

test_case() {
   local install_flags='--no-interaction --no-suggest --prefer-dist --no-progress --profile'

   time_and_log_vm 'install 2.1.2' "cd ./*2.1.2; composer install $install_flags"

   time_and_log_vm 'update 2.1.3' "cd ./*2.1.2; rm composer.json; cp ../*2.1.3/composer.json ./; composer update --lock $install_flags"

   time_and_log_vm 'install 2.1.3' "cd ./*2.1.3; composer install $install_flags"
}

# ~=~=~=~ PROGRAM ~=~=~=~

find_snapshot 'base-install' || {
   fresh_box && make_snapshot 'base-install'
}

find_snapshot 'base-install' || {
   echo base-install does not exist
   exit 1
}

echo && echo '~=~=~=~=~=~=~=~ normal run ~=~=~=~=~=~=~=~=~=~'
rollback_to_snapshot 'base-install'
test_case

echo && echo '~=~=~=~=~=~=~=~ prestissimo run ~=~=~=~=~=~=~=~=~=~'
rollback_to_snapshot 'base-install'
time_and_log_vm 'prestissimo plugin' 'composer global require "hirak/prestissimo:^0.3"'
test_case
