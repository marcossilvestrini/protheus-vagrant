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

# VARIABLE HOSTNAME
NAME= "ol8-protheus"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = BOX_NAME
  config.vm.box_url = "#{BOX_URL}/#{BOX_NAME}.json"

  # VM Protheus
  config.vm.define "protheus"  do |protheus|
    # HOSTNAME
    protheus.vm.hostname = NAME

    # NETWORK
    protheus.vm.network "public_network" ,ip: "192.168.0.133"
    protheus.vm.network "forwarded_port", guest: 80, host: 8080, adapter: 1 , guest_ip: "192.168.0.133" ,host_ip: "192.168.0.33"

    # MOUNTS
    protheus.vm.synced_folder ".", "/vagrant", disabled: true
    protheus.vm.synced_folder "./app", "/totvs"

    # PROVIDER
    protheus.vm.provider "virtualbox" do |vb|
      vb.name = NAME
      vb.memory = 2048
      vb.cpus = 3
    end

    # PROVISION

    # SSH,FIREWALLD AND SELINUX
    protheus.vm.provision "shell", inline: <<-SHELL
      cat /totvs/security/id_rsa.pub >> .ssh/authorized_keys &&
      # chmod 600 .ssh/authorized_keys
      sudo systemctl stop firewalld
      sudo systemctl disable firewalld
      sudo setenforce Permissive
    SHELL

    # INSTALL UPDATES
    # Provision everything on the first run
    #config.vm.provision "shell", path: "scripts/install.sh"
    #config.vm.provision :reload
    #config.vm.provision "shell", inline: "echo 'INSTALLER: Installation complete, Oracle Linux 8 ready to use!'"

    # protheus.vm.provision "shell",
      # inline: "sudo yum update -y"


    # INSTALL PACKAGES WITH ANSIBLE
    #protheus.vm.provision "ansible" do |ansible|
      #ansible.playbook = "ansible/protheus.yml"
    #end

    protheus.vm.provision "shell", inline: <<-SHELL
      sudo yum install httpd -y
      sudo systemctl start httpd
    SHELL

  end

end
