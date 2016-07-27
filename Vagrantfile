boxes = [
    {
        :node_name => "ceph1",
        :node_ip => "10.0.200.101",
        :node_mem => "1024",
        :node_cpu => "1",
        :ceph_role => "master",
    },
    {
        :node_name => "ceph2",
        :node_ip => "10.0.200.102",
        :node_mem => "1024",
        :node_cpu => "1",
        :ceph_role => "slave",
    },
    {
        :node_name => "ceph3",
        :node_ip => "10.0.200.103",
        :node_mem => "1024",
        :node_cpu => "1",
        :ceph_role => "slave",
    },

]


Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "tmp_deploying_stage/", "/tmp_deploying_stage",create:true


  boxes.each do |opts|
    config.vm.define opts[:node_name] do |config|
      config.vm.hostname = opts[:node_name]
      config.vm.provider "virtualbox" do |v|
        v.name = opts[:node_name]
        v.customize ["modifyvm", :id, "--memory", opts[:node_mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:node_cpu]]
      end

      # config.vm.network "public_network",
      # bridge: "wlan0" ,
      # use_dhcp_assigned_default_route: true

      config.vm.network "private_network",
      ip: opts[:node_ip],
      virtualbox__intnet: "CEPH"

      ## Host-Only Network
      #  config.vm.network "private_network",
      #  ip: opts[:node_hostonlyip], :netmask => "255.255.255.0",
      #  :name => 'vboxnet0',
      #  :adapter => 2


    #  if opts[:swarm_role] == "keyvalue"
    #	  config.vm.network "forwarded_port", guest: 8500, host: 8500, auto_correct: true
    #  end



      config.vm.provision "shell", inline: <<-SHELL
        apt-get update -qq && \
	apt-get install -qq chrony  wget && \
	update-rc.d chrony enable
	#wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
	wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
	#echo deb http://download.ceph.com/debian-{ceph-stable-release}/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
	echo deb http://download.ceph.com/debian-jewel/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
	apt-get update -qq && sudo apt-get install -qq ceph-deploy	
	useradd -d /home/ceph -m ceph
	echo "ceph ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
	sudo -u ceph mkdir /home/ceph/.ssh
	sudo -u ceph ssh-keygen -t rsa -N "" -f /home/ceph/.ssh/id_rsa

      SHELL


      # Delete default router for host-only-adapter
    #  config.vm.provision "shell",
    #    run: "always",
    #    inline: "route del default gw 192.168.56.1"


      ## INSTALL DOCKER ENGINE
      #config.vm.provision "shell", inline: <<-SHELL
      #  sudo apt-get install -qq curl
      #  curl -sSL https://get.docker.com/ | sh
      #  curl -fsSL https://get.docker.com/gpg | sudo apt-key add -
      #  usermod -aG docker vagrant
      #SHELL

      ## ADD HOSTS
      config.vm.provision "shell", inline: <<-SHELL
        echo "127.0.0.1 localhost" >/etc/hosts

        echo "10.0.200.101 ceph1 ceph1.lab.local" >>/etc/hosts

        echo "10.0.200.102 ceph2 ceph2.lab.local" >>/etc/hosts

        echo "10.0.200.103 ceph3 ceph3.lab.local" >>/etc/hosts

      SHELL


    end
  end
end
