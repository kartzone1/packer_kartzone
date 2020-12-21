# This is a basic Fedora cloud spin designed to work in OpenStack and other
# private cloud environments. It's configured with cloud-init so it will
# take advantage of ec2-compatible metadata services for provisioning ssh
# keys. Cloud-init creates a user account named "fedora" with passwordless
# sudo access. The root password is empty and locked by default.
#
# This kickstart file is designed to be used with ImageFactory (in Koji).
#
# To do a local build, you'll need to install ImageFactory.  See
# http://worknotes.readthedocs.org/en/latest/cloudimages.html for some notes.
#
# For a TDL file, I store one here:
# https://pagure.io/fedora-atomic/raw/master/f/fedora-atomic-rawhide.tdl
# (Koji generates one internally...what we really want is Koji to publish it statically)
#
# Once you have imagefactory and imagefactory-plugins installed, run:
#
#   curl -O https://pagure.io/fedora-atomic/raw/master/f/fedora-atomic-rawhide.tdl
#   tempfile=$(mktemp --suffix=.ks)
#   ksflatten -v F22 -c fedora-cloud-base.ks > ${tempfile}
#   imagefactory --debug base_image --file-parameter install_script ${tempfile} fedora-atomic-rawhide.tdl
#

text # don't use cmdline -- https://github.com/rhinstaller/anaconda/issues/931
lang en_US.UTF-8
keyboard fr
timezone --utc Etc/UTC

selinux --enforcing
rootpw --plaintext vagrant
user --name=vagrant --plaintext --password vagrant

firewall --disabled

# We pass net.ifnames=0 because we always want to use eth0 here on all the cloud images.
bootloader --timeout=1 --append="no_timer_check net.ifnames=0"

services --enabled=sshd,cloud-init,cloud-init-local,cloud-config,cloud-final

xconfig --startxonboot

zerombr
clearpart --all --initlabel
autopart

url --url="https://download.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/"
repo --name=updates

reboot

##### begin package list #############################################
%packages --instLangs=fr

# Include packages for the workstation-product-environment group
@^workstation-product-environment

# Install cloud-init
cloud-init

%end
##### end package list ###############################################

##### begin kickstart post ###########################################
%post --erroronfail

# linux-firmware is installed by default and is quite large. As of mid 2020:
#   Total download size: 97 M
#   Installed size: 268 M
# So far we've been fine shipping without it so let's continue.
# More discussion about this in #1234504.
echo "Removing linux-firmware package."
rpm -e linux-firmware

# See the systemd-random-seed.service man page that says:
#   " It is recommended to remove the random seed from OS images intended
#     for replication on multiple systems"
echo "Removing random-seed so it's not the same in every image."
rm -f /var/lib/systemd/random-seed

echo "Import RPM GPG key"
releasever=$(rpm --eval '%{fedora}')
basearch=$(uname -i)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

# When we build the image a networking config file gets left behind.
# Let's clean it up.
echo "Cleanup leftover networking configuration"
rm -f /etc/NetworkManager/system-connections/*.nmconnection

# Clear machine-id on pre generated images
truncate -s 0 /etc/machine-id

# sudo
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/vagrant
echo '%vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant

%end
##### end kickstart post ############################################
