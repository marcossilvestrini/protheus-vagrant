# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/8"
  config.vm.box_version = "1905.1"

  #VM Protheus
  config.vm.define "protheus" do |protheus|

    # HOSTNAME
    protheus.vm.hostname = "centos8-protheus"

    # Monkey patch for https://github.com/dotless-de/vagrant-vbguest/issues/367
    class Foo < VagrantVbguest::Installers::CentOS
      def has_rel_repo?
        unless instance_variable_defined?(:@has_rel_repo)
          rel = release_version
          @has_rel_repo = communicate.test("yum repolist")
        end
        @has_rel_repo
      end

      def install_kernel_devel(opts=nil, &block)
        cmd = "yum update kernel -y"
        communicate.sudo(cmd, opts, &block)

        cmd = "yum install -y kernel-devel"
        communicate.sudo(cmd, opts, &block)

        cmd = "shutdown -r now"
        communicate.sudo(cmd, opts, &block)

        begin
          sleep 5
        end until @vm.communicate.ready?
      end
    end

    protheus.vbguest.installer = Foo

    # NETWORK
    protheus.vm.network "forwarded_port", guest: 80, host: 8080

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine and only allow access
    # via 127.0.0.1 to disable public access
    # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

    protheus.vm.network "public_network" ,ip: "192.168.0.133"
    # protheus.vm.network "public_network" ,use_dhcp_assigned_default_route: true

    # MOUNTS
    protheus.vm.synced_folder ".", "/vagrant", disabled: true
    protheus.vm.synced_folder "./security", "/totvs/security"
    protheus.vm.synced_folder "./app/licenseserver", "/totvs/licenseserver"
    protheus.vm.synced_folder "./app/dbaccess", "/totvs/dbaccess"
    protheus.vm.synced_folder "./app/appserver", "/totvs/appserver"
    protheus.vm.synced_folder "./app/smartclient", "/totvs/smartclient"
    protheus.vm.synced_folder "./app/monitor", "/totvs/monitor"

    # PROVIDER

    protheus.vm.provider "virtualbox" do |vb|
      vb.name = "centos8-protheus"
      vb.memory = 2048
      vb.cpus = 1
    end

    # PROVISION

    # SSH,FIREWALLD AND SELINUX
    wordpress.vm.provision "shell", inline: <<-SHELL
      cat /totvs/security/id_rsa.pub >> .ssh/authorized_keys
      sudo systemctl stop firewalld
      sudo systemctl disable firewalld
      sudo setenforce Permissive
    SHELL

    protheus.vm.provision "shell",
      inline: "cat /totvs/security/id_rsa.pub >> .ssh/authorized_keys"

    # INSTALL UPDATES
    protheus.vm.provision "shell",
      inline: "sudo yum update -y"

    # INSTALL PACKAGES WITH ANSIBLE
    #protheus.vm.provision "ansible" do |ansible|
      #ansible.playbook = "ansible/protheus.yml"
    #end

  end

end