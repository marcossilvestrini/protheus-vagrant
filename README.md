# Provision VM ERP Protheus

## Getting Started

- Fork the project and enjoy.
- Atention for pre requisites and License!!!

## Prerequisites

- Git
- Virtual Box
- Vagrant
- Ansible

## Authors

- Marcos Silvestrini

## License

- This project is licensed under the MIT License - see the LICENSE.md file for details

## References

- Git: <https://git-scm.com/doc>
- VirtualBox: <https://www.virtualbox.org/wiki/Documentation>
- Vagrant: <https://www.vagrantup.com/docs/index.html>
- Ansible: <https://docs.ansible.com/ansible/latest/index.html>
- Postgresql:
- <https://www.postgresql.org/download/linux/redhat/>
- <https://help.interfaceware.com/v6/connect-to-postgresql-from-linux-or-mac-with-odbc>
- Protheus: <>

## Install Vagrant in Rhel Centos 7\8

### Download

- <https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.rpm>
- sudo wget <https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.rpm>

### Install

- sudo yum localinstall vagrant_2.2.7_x86_64.rpm -y
- vagrant ––version

## Create Box

- clone this reposotory
- Generate your ssh pub key and copy to security folder
- Download artefacts of ERP(license,rpo,appserver,etc)
- Copy artefacts for relative folders(license,rpo,appserver,etc)
- cd vagrant-protheus
- vagrant up
- vagrant status
- vagrant ssh

## Base Vagrantfile

- Install plugins vagrant
- Set Hostname
- Set ressources memory and cpu
- Configure Network and forwarded port
- Configure Mounts
- Configure ssh
- Configure Firewall (firewalld or iptables)
- Configure Selinux
- Install Updates

## Fix Error SSH in Vagrant Windows

- Run this command in powershell:
- $Env:VAGRANT_PREFER_SYSTEM_BIN += 0

## Provisioning VM Database

- Install and configure database
- Create database for app
- Create user and pass

## Provisioning VM App

- Instal and configure licenserver
- Install and configure dbaccess
- Install and configure appserver
