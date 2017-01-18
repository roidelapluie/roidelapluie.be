+++
title = "Easily extract files from qemu-kvm guests"
lang = "en"
categories = ["Linux"]
tags = ["kvm", "qemu", "virtualization", "planet-inuits"]
slug = "virt-copy-out"
date = "2015-04-28T09:08:34"
+++

`qemu-kvm libvirt` users, here is a trick to get or put a file on a guest. It
allows you to access easily files stored on the guests disks. Useful when the guest
has no network connectivity or is just offline.

Here is it:

    virt-copy-out -d myvm.example.com /root/myfile.txt /tmp/extract/

The file you want is `/root/myfile.txt` and you want it in `/tmp/extract/`. It works
even with `lvm-based` disks and is a lot more easy to use than working with `kpartx` or other
voodoo as often seen on the web.

`virt-copy-in` also exists. In EL6 they are part of the `libguestfs-tools-c` package.

More details: `man virt-copy-out` and `man guestfish`.
