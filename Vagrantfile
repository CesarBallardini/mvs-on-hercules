# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

HOSTNAME = "herc"

$msg = <<MSG
------------------------------------------------------
MVS 3.8j Tur(n)key 4 on Hercules Simulator
------------------------------------------------------
MSG


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    # uso cachier con NFS solamente si el hostmanager gestiona los nombres en /etc/hosts del host
    if Vagrant.has_plugin?("vagrant-cachier")

      config.cache.auto_detect = false
      # W: Download is performed unsandboxed as root as file '/var/cache/apt/archives/partial/xyz' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)
      config.cache.synced_folder_opts = {
        owner: "_apt"
      }

      # Configure cached packages to be shared between instances of the same base box.
      # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
      config.cache.scope = :box
   end

  end

 config.vm.post_up_message = $msg

 config.vm.define HOSTNAME do |srv|

    srv.vm.box = "ubuntu/focal64"

    srv.vm.network "private_network", ip: "192.168.56.11", name: 'vboxnet1', adapter: 2

    srv.vm.box_check_update = false
    srv.ssh.forward_agent = true
    srv.ssh.forward_x11 = true
    srv.vm.hostname = HOSTNAME

    if Vagrant.has_plugin?("vagrant-hostmanager")
      srv.hostmanager.aliases = %W(#{HOSTNAME+".virtual.ballardini.com.ar"} #{HOSTNAME} )
    end

    srv.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = "2048"

      # https://github.com/hashicorp/vagrant/issues/9524#issuecomment-385990711
      # Cuando el nombre de dirctorio mas nombre de machine tiene largo mayor a 64 caracteres
      vb.customize ["modifyvm", :id, "--audio", "none"]

      # set timesync parameters to keep the clocks better in sync
      # sync time every 10 seconds
      vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-interval", 10000 ]
      # adjustments if drift > 100 ms
      vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-min-adjust", 100 ]
      # sync time on restore
      vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-on-restore", 1 ]
      # sync time on start
      vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-start", 1 ]
      # at 1 second drift, the time will be set and not "smoothly" adjusted
      vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]

      vb.customize ["modifyvm", :id, "--hostonlyadapter2", "vboxnet1"]  # eth1
      vb.customize ["modifyvm", :id, "--hostonlyadapter3", "vboxnet2"]  # eth2

      vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
      vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]

      # https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm mas parametros para personalizar en VB
    end
  end

    ##
    # Aprovisionamiento
    #
    config.vm.provision "fix-no-tty", type: "shell" do |s|  # http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
    end
    config.vm.provision "ssh_pub_key", type: :shell do |s|
      begin
          ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
          s.inline = <<-SHELL
            mkdir -p /root/.ssh/
            touch /root/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
          SHELL
      rescue
          puts "No hay claves publicas en el HOME de su pc"
          s.inline = "echo OK sin claves publicas"
      end
    end

    config.vm.provision "actualiza", type: "shell" do |s|
        s.privileged = false
        s.inline = <<-SHELL
          export DEBIAN_FRONTEND=noninteractive
          export APT_LISTCHANGES_FRONTEND=none
          export APT_OPTIONS=' -y --allow-downgrades --allow-remove-essential --allow-change-held-packages -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold '

          sudo -E apt-get --purge remove apt-listchanges -y > /dev/null 2>&1
          sudo -E apt-get update -y -qq > /dev/null 2>&1
          sudo dpkg-reconfigure --frontend=noninteractive libc6 > /dev/null 2>&1
          [ $( lsb_release -is ) != "Debian" ] && sudo -E apt-get install linux-image-generic ${APT_OPTIONS}
          sudo -E apt-get upgrade ${APT_OPTIONS} > /dev/null 2>&1
          sudo -E apt-get dist-upgrade ${APT_OPTIONS} > /dev/null 2>&1
          sudo -E apt-get autoremove -y > /dev/null 2>&1
          sudo -E apt-get autoclean -y > /dev/null 2>&1
          sudo -E apt-get clean > /dev/null 2>&1

          sudo timedatectl set-ntp on
          sudo systemd-resolve --interface enp0s3 --set-dns 8.8.8.8 --set-domain casa.ballardini.com.ar
          sudo service systemd-resolved restart

        SHELL
    end

    config.vm.provision :reload

    config.vm.provision "instala_turnkey_mvs", type: "shell", privileged: false, path: "provision/instala-turnkey-mvs.sh"

end

