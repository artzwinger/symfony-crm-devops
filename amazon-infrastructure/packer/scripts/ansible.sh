#!/usr/bin/env bash

set -eux

apt-get -y install software-properties-common
add-apt-repository -y multiverse

# Disable daily apt unattended updates
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# Install Ansible repository.
apt-get -y install software-properties-common
apt-add-repository --yes ppa:ansible/ansible

# Install Ansible.
apt-get -y update
apt-get -y install ansible

# Create directories to host Ansible files
mkdir -p $ANSIBLE_STAGING_DIRECTORY/{group_vars,templates,vars,roles}
chown -R $ANSIBLE_STAGING_DIRECTORY_USER:$ANSIBLE_STAGING_DIRECTORY_GROUP $ANSIBLE_STAGING_DIRECTORY
chmod -R $ANSIBLE_STAGING_DIRECTORY_PERMISSIONS $ANSIBLE_STAGING_DIRECTORY
