# Provision ERP Protheus With Vagrant and Ansible


[![N|Solid](http://i.imgur.com/RnlvjUO.png)](https://www.vagrantup.com)

Project for provisioning box Protheus development environment for code, build and test.
>This projetc use provider Virtual Box for create VM's  
>This project use box Oracle Linux 8 for provisioning environment   
>This project user Jinja Templates for configure environment   
>Pay attention to **download the artifacts** to not have problems in provisioning

# Getting Started

- Fork the project and enjoy.
- Atention for pre requisites and License!!!

# Prerequisites

- [Git](https://git-scm.com/doc)
- [Virtual Box](https://www.virtualbox.org/wiki/Documentation)
- [Vagrant](https://www.vagrantup.com/docs/index.html)
- [Ansible](https://docs.ansible.com/ansible/latest/index.html)
- [Python]()

# Authors

- Marcos Silvestrini
- marcos.silvestrini@gmail.com

# License

- This project is licensed under the MIT License - see the LICENSE.md file for details

# References

- [Git](https://git-scm.com/doc)
- [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)
- [Vagrant](https://www.vagrantup.com/docs/index.html)
- [Oracle Boxes](https://yum.oracle.com/boxes/)
- [Ansible](https://docs.ansible.com/ansible/2.5/modules/list_of_all_modules.html)
- [Postgresql](https://www.postgresql.org/download/linux/redhat/)
- [Protheus Linux](https://tdn.totvs.com/pages/releaseview.action?pageId=515672176)
- [Bog Siga0984](https://siga0984.wordpress.com/2016/07/12/protheus-no-linux-parte-02)

# Install Vagrant

## Download

```linux
sudo wget https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.rpm
```
## Install
```linux
sudo yum localinstall vagrant_2.2.7_x86_64.rpm -y
vagrant ––version
```
# Create Box

1. clone this reposotory
2. Generate your ssh pub key and **copy to security/ folder**
3. Download artefacts of ERP(license,rpo,appserver,etc)
4. Copy artefacts for relative folders(license,rpo,appserver,etc)
5. cd vagrant-protheus
6. vagrant validate
7. vagrant up
8. vagrant status
9. vagrant ssh

# Vagrantfile Tasks

- Set Hostname
- Set ressources memory and cpu
- Configure Network and forwarded port
- Configure Mounts
- Configure ssh
- Configure Firewall (firewalld or iptables)
- Configure Selinux
- Install Updates

# Fix Error SSH in Vagrant Windows

- Run this command in powershell:
```powershell
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0
```

# Provisioning Database Tasks

- Install and configure database
- Create database for app
- Create user and pass

# Provisioning App Tasks

- Instal and configure lockserver
- Instal and configure licenserver
- Install and configure dbaccess
- Install and configure appserver_boker
- Install and configure appserver_slaves
- Install and configure appserver_rest
- Install and configure appserver_soap
