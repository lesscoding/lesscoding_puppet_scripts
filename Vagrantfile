# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.ssh.max_tries = 50
  config.ssh.timeout = 300
  config.vm.customize ["modifyvm", :id, "--name", "newton", "--memory", "512"]
  # config.vm.boot_mode = :gui
  config.vm.box = "precise64_pre_puppet"
  config.vm.host_name = "newton"
  config.vm.forward_port 22, 2222, :auto => true
  config.vm.forward_port 80, 8080
  config.vm.forward_port 3000, 3000
  config.vm.network :hostonly, "33.33.101.12"
  config.vm.share_folder "provision", "/tmp/provision", "./"
end

