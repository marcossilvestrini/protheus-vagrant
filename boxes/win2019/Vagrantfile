# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# INSTALL PLUGINS
unless Vagrant.has_plugin?("vagrant-reload")
  puts 'Installing vagrant-reload Plugin...'
  system('vagrant plugin install vagrant-reload')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Box Windows Server 2019 Standart
  config.vm.box = "gusztavvargadr/windows-server-standard-core"
  config.vbguest.auto_update = true

  # VM AD
  config.vm.define "srvdc01" do |srvdc01|

    # VARIABLE HOSTNAME
    VM_DC_NAME= "srvdc01"

    # Set Others parameters for windows vm
    srvdc01.vm.guest = :windows
    srvdc01.vm.communicator = "winrm"
    srvdc01.vm.boot_timeout = 1200
    srvdc01.vm.graceful_halt_timeout = 600
    srvdc01.winrm.timeout = 1800
    srvdc01.winrm.retry_limit = 200
    srvdc01.winrm.retry_delay = 10
    srvdc01.winrm.max_tries = 20
    srvdc01.winrm.transport = :plaintext
    srvdc01.winrm.basic_auth_only = true

    # HOSTNAME
    srvdc01.vm.hostname = VM_DC_NAME

    # NETWORK
    srvdc01.vm.network "public_network" ,ip: "192.168.0.132"

    # MOUNTS
    srvdc01.vm.synced_folder ".", "/vagrant", disabled: true
    srvdc01.vm.synced_folder "./scripts", "/scripts"

    # PROVIDER
    srvdc01.vm.provider "virtualbox" do |vb|
      vb.linked_clone = true
      vb.name = VM_DC_NAME
      vb.memory = 2048
      vb.cpus = 3
    end

    # PROVISION

    # SETUP ANSIBLE
    srvdc01.vm.provision "shell", path: "scripts/setup_ansible.ps1"

    # SETUP AD SERVER
    srvdc01.vm.provision "ansible" do |ansible|
      ansible.limit = "all"
      ansible.inventory_path = "provisioning/hosts"
      ansible.playbook = "provisioning/domain_controler.yml"
    end

    # REBOOT SERVER
    srvdc01.vm.provision :reload

    #  CREATE GROUPS AND USERS
    srvdc01.vm.provision "ansible" do |ansible|
      ansible.limit = "all"
      ansible.inventory_path = "provisioning/hosts"
      ansible.playbook = "provisioning/groups_users.yml"
    end

    # SETUP DNS
    srvdc01.vm.provision "ansible" do |ansible|
      ansible.limit = "all"
      ansible.inventory_path = "provisioning/hosts"
      ansible.playbook = "provisioning/dns.yml"
    end

  end

  # VM CLIENT
  config.vm.define "srv01" do |srv01|

    # VARIABLE HOSTNAME
    VM_CLIENT_NAME= "srv01"

    # HOSTNAME
    srv01.vm.hostname = VM_CLIENT_NAME

    # NETWORK
    srv01.vm.network "public_network" ,ip: "192.168.0.133"

    # MOUNTS
    srv01.vm.synced_folder ".", "/vagrant", disabled: true
    srv01.vm.synced_folder "./scripts", "/scripts"

    # PROVIDER
    srv01.vm.provider "virtualbox" do |vb|
      vb.name = VM_CLIENT_NAME
      vb.memory = 2048
      vb.cpus = 3
    end

    # PROVISION

    # SETUP ANSIBLE
    srv01.vm.provision "shell", path: "scripts/setup_ansible.ps1"

    # SETUP AD SERVER
    srv01.vm.provision "ansible" do |ansible|
      ansible.limit = "all"
      ansible.inventory_path = "provisioning/hosts"
      ansible.playbook = "provisioning/client_server.yml"
    end

     # # REBOOT SERVER
    srv01.vm.provision :reload

  end

end