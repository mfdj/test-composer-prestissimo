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
   time_and_log 'boot vm' 'vagrant up' && \
     time_and_log_vm 'ensure db and users' '/vagrant/create-magento-db.sh'

   return $?
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

test_case() {
   local install_flags='--no-interaction --no-suggest --prefer-dist --no-progress --profile'

   time_and_log_vm 'create magento 2.1.6 project' 'composer create-project magento/community-edition:2.1.6 community2.1.6 --no-install'
   time_and_log_vm 'install packages' "cd ./*2.1.6; composer install $install_flags"
}

# ~=~=~=~ PROGRAM ~=~=~=~

find_snapshot 'base-install' || {
   fresh_box && make_snapshot 'base-install'
}

find_snapshot 'base-install' || {
   echo 'base-install failed to build'
   exit 1
}

echo && echo '~=~=~=~=~=~=~=~ normal run ~=~=~=~=~=~=~=~=~=~'
rollback_to_snapshot 'base-install'
test_case

echo && echo '~=~=~=~=~=~=~=~ prestissimo run ~=~=~=~=~=~=~=~=~=~'
rollback_to_snapshot 'base-install'
time_and_log_vm 'prestissimo plugin' 'composer global require "hirak/prestissimo:^0.3"'
test_case
