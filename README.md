# batman-adv-virt

[![individe.xyz](https://img.shields.io/badge/project-individe-black.svg?style=flat-square)](https://individe.xyz/)
[![individe.xyz](https://img.shields.io/badge/powered%20by-endlesshorizons-blueviolet?style=flat-square)](https://endlesshorizons.xyz/)

> Tools and configurations to ease virtualization and containerization of batman-adv via Docker, Vagrant and Packer for tests, simulations and emulations. Included tools are also A.L.F.R.E.D and nvm (with node and npm installed).

## Table of contents

- [Requirements](#requirements)
- [Usage](#usage)
  - [`Docker`](#docker)
  - [`docker-compose`](#docker-compose)
  - [`Vagrant`](#vagrant)
  - [`Packer`](#packer)
- [License](#license)

## Requirements

## Usage

### Docker

TBD

### docker-compose

TBD

### Vagrant

To spin up vagrant box in virtualbox, run:

```vagrant up --provider virtualbox```

Or replace *virtualbox* with some other provider, just beware, that Vagrantfile considers one *eth0* interface already exists and creates another one *eth1* for meshing.

To ssh into a box, run:

```vagrant ssh```

To detach from the shh, press:

```Ctrl-D```

After you're finished, destroy a box by running:

```vagrant destroy```

### Packer

To build a vagrant box with packer run:

```
packer build batman-adv.pkr.hcl
```

You can also change the builder, by replacing *vagrant* in **batman-adv.pkr.hcl** with some other builder. Available builders are:

```
qemu hyperv-iso azure-arm vsphere-clone amazon-ebsvolume
alicloud-ecs triton osc-bsuvolume docker googlecompute osc-chroot oracle-classic
parallels-iso oracle-oci openstack virtualbox-iso scaleway proxmox-iso
amazon-chroot vsphere-iso proxmox-clone virtualbox-ovf osc-bsu ncloud hcloud
hyperv-vmcx jdcloud parallels-pvm vmware-iso amazon-ebs ucloud-uhost lxd proxmox
vagrant file amazon-ebssurrogate vmware-vmx tencentcloud-cvm lxc oneandone
amazon-instance null virtualbox-vm yandex hyperone profitbricks azure-chroot
linode digitalocean azure-dtl osc-bsusurrogate cloudstack
```

## License

Licensed under MIT licence.