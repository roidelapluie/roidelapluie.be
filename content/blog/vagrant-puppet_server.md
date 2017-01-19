+++
title = "Vagrant puppet_server tip"
lang = "en"
categories = ["Automation"]
tags = ["vagrant", "puppet", "planet-inuits"]
slug = "vagrant-puppet-agent"
date = "2014-09-17T10:08:31"
+++

This is a small tip for everyone using the [vagrant puppet_server provisioner](https://docs.vagrantup.com/v2/provisioning/puppet_agent.html), which allows you to run a puppet agent inside your vagrant box:

    Vagrant.configure("2") do |config|
      config.vm.box = "vStone/centos-6.x-puppet.3.x"
      config.vm.hostname = "puppet.vagrant.inuits.eu"
      config.vm.box_check_update = false
      config.vm.network "private_network", ip: "192.168.33.2"
      config.vm.provision "puppet_server" do |puppet|
        puppet.puppet_server = "puppetmaster.vagrant.inuits.eu"
        puppet.options = ["--environment", "devel", "--test"]
      end
    end

The tip is to add `puppet.options = ["--test"]` so you have the debug information, the diff of the files, ... If you want more you can also add `--debug`.

By default the provisioner uses the `--onetime` option which is not verbose at all.
