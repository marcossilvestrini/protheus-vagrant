#!/bin/bash
cd ~/vagrant-protheus/windows
vagrant status
vagrant up
vagrant ssh protheus_app
powershell
cd /totvs/scripts
