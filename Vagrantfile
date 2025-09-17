Vagrant.configure("2") do |config|
  config.vm.synced_folder "./website", "/home/vagrant/website"

  # Web server
  config.vm.define "web" do |web|
    web.vm.box = "spox/ubuntu-arm"
    web.vm.hostname = "web"
    # Try a different subnet
    web.vm.network "private_network", ip: "10.0.0.10", netmask: "255.255.255.0"
    web.vm.provider "vmware_desktop" do |vmw|
      vmw.memory = "1024"
      vmw.cpus = 1
    end
    web.vm.provision "shell", path: "scripts/provision-web-ubuntu.sh"
  end

  # Database server
  config.vm.define "db" do |db|
    db.vm.box = "bento/centos-stream-9"
    db.vm.hostname = "db"
    # Use same subnet
    db.vm.network "private_network", ip: "10.0.0.11", netmask: "255.255.255.0"
    db.vm.network "forwarded_port", guest: 3306, host: 3307
    db.vm.synced_folder "./database", "/home/vagrant/database"
    db.vm.provider "vmware_desktop" do |vmw|
      vmw.memory = "1024"
      vmw.cpus = 1
    end
    db.vm.provision "shell", path: "scripts/provision-db-centos.sh"
  end
end