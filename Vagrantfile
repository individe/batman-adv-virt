Vagrant.configure("2") do |config|
    config.vm.box = "debian/bullseye64"

    # add one more interface, for meshing
    config.vm.network "private_network", ip: "192.168.56.101"
    
    # install apt dependencies
    config.vm.provision "shell", privileged: true, inline: "sudo apt-get update -y \
        && sudo apt-get install -y batctl net-tools alfred git cmake libjansson-dev zlib1g-dev curl pkg-config avahi-autoipd iproute2"
    
    # install node and npm
    config.vm.provision "shell", privileged: false, inline: 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
        && export NVM_DIR="$HOME/.nvm" \
        && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
        && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
        && nvm install 16.16.0'
    
    # install alfred
    config.vm.provision "shell", privileged: true, inline: "git clone https://github.com/ffnord/alfred-json.git /home/vagrant/alfred-json/ \
        && mkdir /home/vagrant/alfred-json/build/ \
        && cd /home/vagrant/alfred-json/build \
        && cmake ../ \
        && make \
        && sudo make install"
    
    # copy interfaces
    config.vm.provision "file", source: "bat0", destination: "/tmp/bat0"
    config.vm.provision "shell", inline: "mv /tmp/bat0 /etc/network/interfaces.d/bat0"
    config.vm.provision "file", source: "eth1", destination: "/tmp/eth1"
    config.vm.provision "shell", inline: "mv /tmp/eth1 /etc/network/interfaces.d/eth1"

    # batman config
    config.vm.provision "shell", privileged: true, inline: "echo 'batman-adv' | sudo tee --append /etc/modules"
    
    # batman startup script
    config.vm.provision "shell", path: "start-batman-adv.sh", privileged: true, run: 'always'
end