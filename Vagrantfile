#
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2020 Oracle and/or its affiliates. All rights reserved.
#
# Since: January, 2020
# Author: gerald.venzl@oracle.com
# Description: Creates an Oracle Linux virtual machine.
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Box metadata location and box name
BOX_URL = "https://oracle.github.io/vagrant-boxes/boxes"
BOX_NAME = "oraclelinux/8"

# INSTALL PLUGIN RELLOAD
unless Vagrant.has_plugin?("vagrant-reload")
  puts 'Installing vagrant-reload Plugin...'
  system('vagrant plugin install vagrant-reload')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = BOX_NAME
  config.vm.box_url = "#{BOX_URL}/#{BOX_NAME}.json"

  # VM PostgreSQL
  config.vm.define "postgresql" do |postgresql|

    # VARIABLE HOSTNAME
    DB_NAME= "ol8-postgresql"

    # HOSTNAME
    postgresql.vm.hostname = DB_NAME

    # NETWORK
    postgresql.vm.network "public_network" ,ip: "192.168.0.132"
    postgresql.vm.network "forwarded_port", guest: 5432, host: 5432, adapter: 1 , guest_ip: "192.168.0.132" ,host_ip: "192.168.0.33"

    # MOUNTS
    postgresql.vm.synced_folder ".", "/vagrant", disabled: true
    postgresql.vm.synced_folder "./security", "/security"

    # PROVIDER
    postgresql.vm.provider "virtualbox" do |vb|
      vb.name = DB_NAME
      vb.memory = 2048
      vb.cpus = 3
    end

    # PROVISION
    # SSH,FIREWALLD AND SELINUX
    postgresql.vm.provision "shell", inline: <<-SHELL
      cat /security/id_rsa.pub >> .ssh/authorized_keys
      sudo systemctl stop firewalld
      sudo systemctl disable firewalld
      sudo setenforce Permissive
    SHELL

    # INSTALL UPDATES
    postgresql.vm.provision "shell", path: "scripts/install.sh"
    postgresql.vm.provision :reload
    postgresql.vm.provision "shell", inline: "echo 'INSTALLER: Installation complete, Oracle Linux 8 ready to use!'"

    postgresql.vm.provision "shell",inline: <<-SHELL
      dnf install python3 -y
      SHELL

  end

  # VM Protheus
  config.vm.define "protheus"  do |protheus|

    # VARIABLE HOSTNAME
    APP_NAME= "ol8-protheus"

    # HOSTNAME
    protheus.vm.hostname = APP_NAME

    # NETWORK
    protheus.vm.network "public_network" ,ip: "192.168.0.133",mode: "bridge"
    protheus.vm.network "forwarded_port", guest: 80, host: 8080, adapter: 1, guest_ip: "192.168.0.133" ,host_ip: "192.168.0.33"

    # MOUNTS
    protheus.vm.synced_folder ".", "/vagrant", disabled: true
    protheus.vm.synced_folder "./security", "/security"
    # protheus.vm.synced_folder "./.vagrant/machines/protheus/virtualbox/", "/home/vagrant/.ssh/", type: "rsync",
    #   rsync__args: ["-r", "--include=private_key", "--exclude=*"]

    # PROVIDER
    protheus.vm.provider "virtualbox" do |vb|
      vb.name = APP_NAME
      vb.memory = 2048
      vb.cpus = 3
    end

    # PROVISION
    # SSH,FIREWALLD AND SELINUX
    protheus.vm.provision "shell", inline: <<-SHELL
      cat /security/id_rsa.pub >> .ssh/authorized_keys
      sudo systemctl stop firewalld
      sudo systemctl disable firewalld
      sudo setenforce Permissive
    SHELL

    # INSTALL UPDATES
    protheus.vm.provision "shell", path: "scripts/install.sh"
    protheus.vm.provision :reload
    protheus.vm.provision "shell", inline: "echo 'INSTALLER: Installation complete, Oracle Linux 8 ready to use!'"

    # PACKAGES FOR PROVISION
    protheus.vm.provision "shell", inline: <<-SHELL
      sudo dnf install python3 -y
    SHELL

    # PROVISIONING ANSIBLE
    protheus.vm.provision "ansible" do |ansible|
      ansible.limit = "all"
      ansible.inventory_path = "provisioning/hosts"
      ansible.playbook = "provisioning/app.yml"
    end

  end

end