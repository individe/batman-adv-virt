source "vagrant" "batman-adv-virt" {
  communicator = "ssh"
  source_path = "debian/bullseye64"
  provider = "virtualbox"
  add_force = true
}

build {
  sources = ["source.vagrant.batman-adv-virt"]

  # install dependencies
  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y batctl net-tools alfred git cmake libjansson-dev zlib1g-dev curl pkg-config avahi-autoipd iproute2"
    ]
  }

  # install node and npm
  provisioner "shell" {
    inline = [
      "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash",
      "export NVM_DIR=\"$HOME/.nvm\"",
      "[ -s \"$NVM_DIR/nvm.sh\" ] && . \"$NVM_DIR/nvm.sh\"",
      "[ -s \"$NVM_DIR/bash_completion\" ] && . \"$NVM_DIR/bash_completion\"",
      "nvm install 16.16.0"
    ]
  }
  
  # install alfred
  provisioner "shell" {
    inline = [
      "git clone https://github.com/ffnord/alfred-json.git",
      "cd alfred-json",
      "mkdir build/",
      "cd build",
      "cmake ../",
      "make",
      "sudo make install",
      "cd ../..",
      "rm -rf alfred-json"
    ]
  }
  
  # copy interfaces
  provisioner "file" {
    source = "bat0"
    destination = "/tmp/bat0"
  }

  provisioner "file" {
    source = "eth1"
    destination = "/tmp/eth1"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/bat0 /etc/network/interfaces.d/bat0",
      "sudo mv /tmp/eth1 /etc/network/interfaces.d/eth1"
    ]
  }

  # batman config
  provisioner "shell" {
    inline = ["echo 'batman-adv' | sudo tee --append /etc/modules"]
  }

  # batman startup script
  provisioner "file" {
    source = "start-batman-adv.sh"
    destination = "/tmp/start-batman-adv.sh"
  }
  
  provisioner "file" {
    source = "batman-adv.service"
    destination = "/tmp/batman-adv.service"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/start-batman-adv.sh /etc/start-batman-adv.sh",
      "sudo chmod u+x /etc/start-batman-adv.sh",
      "sudo mv /tmp/batman-adv.service /etc/systemd/system/batman-adv.service",
      "sudo chmod u+x /etc/systemd/system/batman-adv.service",
      "sudo systemctl enable batman-adv.service"
    ]
  }

  # make checksum
  post-processor "checksum" {
    checksum_types = [ "md5", "sha512" ]
    keep_input_artifact = true
  }
}