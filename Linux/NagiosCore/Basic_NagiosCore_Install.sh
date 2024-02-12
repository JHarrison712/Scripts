# Author: John Harrison
# Creation Date: 2/12/2024
# Last Modified Date:
# File Name:Basic_NagiosCore_Install.sh
# Description: Basic installation of NagiosCore installation script


# NagiosCore Install script
# NOTE: Script wil update and upgrade currently installed packages.
#!/bin/bash
echo "This will install NagiosCore. Developed on Ubuntu 22.04 lts"
echo "###########################################################"
echo "Updating the repo cache and installing needed repos"
echo "###########################################################"
# Set the system timezone
echo "Have you set the system time zone?: [yes/no]"
read ANS
if [ "$ANS" = "N" ] || [ "$ANS" = "No" ] || [ "$ASN" = "NO'" ] || [ "$ANS" = "no" ] || [ "$ANS" = "n" ]; then
  echo "We will list the timezones"
  echo "Use q to quite the list"
  echo "-----------------------------"
  sleep 5
  echo " "
  timedatectl list-timezones
  echo "Enter system time zone:"
  read TZ
  timedatectl set-timezone $TZ
  else 
   TZ="$(cat /etc/timezone)"
fi
apt update
# Security-Enhanced Linux
sudo dpkg -l selinux*
# Prerequisites
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.4 libgd-dev
sudo apt-get install openssl libssl-dev
# Downloading the Source
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.14.tar.gz
tar xzf nagioscore.tar.gz
# Compile
cd /tmp/nagioscore-nagios-4.4.14/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
# Create User and Group
# This creates the nagios user and group. The www-data user is also added to the nagios group.
sudo make install-groups-users
sudo usermod -a -G nagios www-data
# Install Binaries
# This step installs the binary files, CGIs, and HTML files.
sudo make install
# Install Service & Daemon
sudo make install-daemoninit
# Install Command Mode
sudo make install-commandmode
# Install Configuration Files
sudo make install-config
# Install Apache Config Files
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi
# Create nagiosadmin User Account
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
# Start Apache Web Server
sudo systemctl restart apache2.service
# Start Service / Daemon
sudo systemctl start nagios.service
# Test Nagios
echo "Test Nagios"
echo "Nagios is now running, to confirm this you need to log into the Nagios Web Interface.

Point your web browser to the ip address or FQDN of your Nagios Core server, for example:

http://10.25.5.143/nagios

http://core-013.domain.local/nagios

You will be prompted for a username and password. The username is nagiosadmin (you created it in a previous step) and the password is what you provided earlier.

Once you have logged in you are presented with the Nagios interface. Congratulations you have installed Nagios Core."

# BUT WAIT ...
echo "BUT WAIT ...
Currently you have only installed the Nagios Core engine. You'll notice some errors under the hosts and services along the lines of:

(No output on stdout) stderr: execvp(/usr/local/nagios/libexec/check_load, ...) failed. errno is 2: No such file or directory 
These errors will be resolved once you install the Nagios Plugins, which is covered in the next step."


# Installing The Nagios Plugins
echo "Installing The Nagios Plugins"
# Prerequisites
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext
# Downloading The Source
cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.6.tar.gz
tar zxf nagios-plugins.tar.gz
# Compile + Install
cd /tmp/nagios-plugins-release-2.4.6/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
# Test Plugins
echo "Test Plugins"
echo "Point your web browser to the ip address or FQDN of your Nagios Core server, for example:

http://10.25.5.143/nagios

http://core-013.domain.local/nagios

Go to a host or service object and "Re-schedule the next check" under the Commands menu. The error you previously saw should now disappear and the correct output will be shown on the screen."

# Service / Daemon Commands
sudo systemctl start nagios.service
sudo systemctl stop nagios.service
sudo systemctl restart nagios.service
sudo systemctl status nagios.service


