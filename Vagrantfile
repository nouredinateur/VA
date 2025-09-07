Vagrant.configure("2") do |config|
  # Web server
  config.vm.define "web" do |web|
    web.vm.box = "spox/ubuntu-arm"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.provider "vmware_desktop" do |vmw|
      vmw.memory = "1024"
     end
  end

  # Database server
  config.vm.define "db" do |db|
    db.vm.box = "bento/centos-stream-9"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.11"
    db.vm.provider "vmware_desktop" do |vmw|
      vmw.memory = "1024"
     end
  end
end
