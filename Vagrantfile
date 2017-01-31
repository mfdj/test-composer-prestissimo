
Vagrant.configure('2') do |config|
   config.vm.box = 'bento/ubuntu-16.04'

   if Vagrant.has_plugin?('vagrant-cachier')
      config.cache.scope = :box
      config.cache.synced_folder_opts = {
         owner: '_apt',
         group: '_apt'
      }
   end

   config.vm.provision 'shell', path: 'xenial-provision.sh'
end
