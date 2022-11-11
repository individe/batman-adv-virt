# batman-adv-virt

[![individe.xyz](https://img.shields.io/badge/project-individe-black.svg?style=flat-square)](https://individe.xyz/)
[![endlesshorizons.xyz](https://img.shields.io/badge/powered%20by-endlesshorizons-blueviolet?style=flat-square)](https://endlesshorizons.xyz/)

> Tools and configurations to ease virtualization and containerization of batman-adv via Docker, Vagrant and Packer for tests, simulations and emulations. Included tools are also A.L.F.R.E.D and nvm (with node and npm installed).

## Table of contents

- [Requirements](#requirements)
- [Usage](#usage)
  - [`Docker`](#docker)
  - [`docker-compose`](#docker-compose)
  - [`Vagrant`](#vagrant)
  - [`Packer`](#packer)
- [Simulation example](#simulation-example)
- [License](#license)

## Requirements

## Usage

### Docker

__Note: This docker image can be ran only on Linux machines and batman-adv kernel module must be enabled.__

__Note: You may need to prefix Docker commands with sudo, if it is not added to non-sudo group beforehand.__

```bash
docker build -t batman-adv-virt . # Build the image
docker run --privileged -it \
    --cap-add=ALL \
    -v /dev:/dev \
    -v /lib/modules:/lib/modules \
    batman-adv-virt # Start the image
```

Optionally add *--name container_name* to name your container, *--rm* flag to delete the container after you're finished with it or replace *-it* with *-d* to start the container in detached mode instead of interactive.

To open up a bash for detached container, type:

```docker exec -it (container_name) /bin/bash```

To detach, press **Ctrl-D**.

### docker-compose

TBD

### Vagrant

To spin up vagrant box in virtualbox, run:

```vagrant up --provider virtualbox```

Or replace *virtualbox* with some other provider, just beware, that Vagrantfile considers one *eth0* interface already exists and creates another *eth1* for meshing.

To ssh into a box, run:

```vagrant ssh```

To detach from the shh, press **Ctrl-D**.

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

## Simulation example

TBD

## License

Licensed under MIT licence, Copyright (c) 2022 Aleksa Milošević.