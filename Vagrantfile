
Vagrant.configure('2') do |config|

   # box
   config.vm.box         = 'bento/ubuntu-16.04'
   config.vm.box_version = '202104.19.0'

   # provider
   config.vm.provider 'virtualbox' do |vb|
      vb.cpus   = 2
      vb.memory = "2048"
      vb.gui    = false
   end

   # DO NOT use cachier since it will screw with prestissimo tests
   # if Vagrant.has_plugin?('vagrant-cachier')
   #    config.cache.scope = :box
   # end

   # provision
   config.vm.provision 'shell', path: 'magento2-xenial-provision.sh'

   # vm-name
   config.vm.define "test-prestissimo" do |data|
   end
end
