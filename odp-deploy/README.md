# ODP Deployment Utilities

This set of files is for creating vagrant machines with the latest ODP code.

## ODP Sandbox
The ODP sandbox is a single node cluster with hdfs and yarn. It also serves as a development testbed for Apache Bigtop's itest framework. 

### ODP Sandbox Quickstart
1. yum install vagrant ansible
2. vagrant box add puppetlabs/centos-7.0-64-nocm
3. git clone https://github.com/jctanner/odp-prototype.git
4. cd odp-deploy/vm/vagrant-ansible-sandbox
5. vagrant up
6. ansible-playbook provision-sandbox.yml

## ODP Cluster
This is still a work in progress but the roles are mostly complete. 
