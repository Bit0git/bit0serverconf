# bit0serverconf
# change root password
passwd
# update/upgrade distribution
apt-get update
apt-get upgrade
# deploy a container with sshguard 
sshguard
# add domain user
useradd bit0admin
mkdir /home/bit0admin
mkdir /home/bit0admin/.ssh
chmod 700 /home/bit0admin/.ssh
# Require public key authentication
vim /home/bit0admin/.ssh/authorized_keys
    #Add the contents of the id_rsa.pub on your local machine and any other public keys that you want to have access to this server to this file.
chmod 400 /home/bit0admin/.ssh/authorized_keys
chown bit0admin:bit0admin /home/bit0admin -R
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
