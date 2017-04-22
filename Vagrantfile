
Vagrant.configure('2') do |config|
   config.vm.box = 'bento/ubuntu-16.04'

   # DO NOT use cachier since it will screw with prestissimo tests
   # if Vagrant.has_plugin?('vagrant-cachier')
   #    config.cache.scope = :box
   # end

   config.vm.provision 'shell', path: 'magento2-xenial-provision.sh'
end
