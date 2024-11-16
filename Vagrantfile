# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provision "docker"

  config.vm.define "registry" do |registry|
    registry.vm.hostname = "container-training-registry"
    registry.vm.network "private_network", ip: "192.168.56.43"

    registry.vm.cloud_init :user_data do |cloud_init|
      cloud_init.content_type = "text/cloud-config"
      cloud_init.path = "cloud-init/user-data"
    end

    registry.vm.provider "virtualbox" do |vb|
      vb.name = "training-container-registry"
      vb.memory = "4096"
      vb.cpus = 2
    end

    registry.vm.provision "shell", path: "install_harbor.sh"
  end

  config.vm.define "node-1" do |node|
    node.vm.hostname = "training-container-node-1"
    node.vm.network "private_network", ip: "192.168.56.42"

    node.vm.cloud_init :user_data do |cloud_init|
      cloud_init.content_type = "text/cloud-config"
      cloud_init.path = "cloud-init/user-data"
    end

    node.vm.provider "virtualbox" do |vb|
      vb.name = "training-container-node-1"
      vb.memory = "1024"
      vb.cpus = 2
    end

    node.vm.provision "shell", inline: <<~SCRIPT
      #!/usr/bin/env bash
      set -euxo pipefail

      echo '{"insecure-registries":["192.168.56.43"]}' > /etc/docker/daemon.json
      systemctl restart docker
    SCRIPT
  end
end
