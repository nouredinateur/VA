Vagrant.configure("2") do |config|

  config.vm.synced_folder "./website", "/home/vagrant/website"

  # Web server
  config.vm.define "web" do |web|
    web.vm.box = "spox/ubuntu-arm"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    web.vm.provider "vmware_desktop" do |vmw|
      vmw.memory = "1024"
     end
     web.vm.provision "shell", path: "scripts/provision-web-ubuntu.sh"
  end

  # Database server
  config.vm.define "db" do |db|
    db.vm.box = "bento/centos-stream-9"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.11"

    # redirige le port MySQL vers l’hôte
    db.vm.network "forwarded_port", guest: 3306, host: 3307

    # partage le dossier contenant vos scripts SQL
    db.vm.synced_folder "./database", "/home/vagrant/database"
    db.vm.provider "vmware_desktop" do |vmw|
      vmw.memory = "1024"
     end
     db.vm.provision "shell", path: "scripts/provision-db-centos.sh"
  end
end
