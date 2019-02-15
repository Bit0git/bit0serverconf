# bit0serverconf
# change root password
passwd
# (OK) update/upgrade distribution
    cloud-init
# deploy a container with sshguard 
sshguard
# (OK) add domain user
    cloud-init
# (OK) require public key authentication
    cloud-init
# sudo password
passwd deploy
visudo
    #Comment all existing user/group grant lines and add:
    root    ALL=(ALL) ALL
    bit0admin  ALL=(ALL) ALL  
# Lock Down SSH: Configure ssh to prevent password & root logins and lock ssh to particular IPs:
vim /etc/ssh/sshd_config
    # Add these lines to the file, inserting the ip address from where you will be connecting:
    PermitRootLogin no
    PasswordAuthentication no
    AllowUsers deploy@(your-ip) deploy@(another-ip-if-any)
    # Now restart ssh:
service ssh restart
# Set Up A Firewall: https://hub.docker.com/r/chaifeng/ufw-docker-agent/dockerfile
ufw allow from {your-ip} to any port 22
ufw allow 80
ufw allow 443
ufw enable
# Enable Automatic Security Updates
apt-get install unattended-upgrades
vim /etc/apt/apt.conf.d/10periodic
    # Update the file to look like this:
    APT::Periodic::Update-Package-Lists "1";
    APT::Periodic::Download-Upgradeable-Packages "1";
    APT::Periodic::AutocleanInterval "7";
    APT::Periodic::Unattended-Upgrade "1";
vim /etc/apt/apt.conf.d/50unattended-upgrades
    # Update the file to look like below. You should probably keep updates disabled and stick with security updates only:
    Unattended-Upgrade::Allowed-Origins {
            "Ubuntu lucid-security";
    //      "Ubuntu lucid-updates";
    };
