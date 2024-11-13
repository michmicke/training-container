# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provision "docker"

  config.vm.define "registry" do |registry|
    registry.vm.hostname = "container-training-registry"
    registry.vm.network "private_network", ip: "192.168.56.43"

    registry.vm.provider "virtualbox" do |vb|
      vb.name = "docker-training-registry"
      vb.memory = "4096"
      vb.cpus = 2
    end

    registry.vm.provision "shell", path: "provision_registry.sh"
  end

  config.vm.define "node-1" do |node|
    node.vm.hostname = "container-training-node-1"
    node.vm.network "private_network", ip: "192.168.56.42"

    node.vm.provider "virtualbox" do |vb|
      vb.name = "docker-training-node-1"
      vb.memory = "1024"
      vb.cpus = 2
    end
  end
end
