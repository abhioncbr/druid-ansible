#druid master node machine count. [Default value: 1]
variable "druid_master_node_count" {}

#druid broker node machine count. [Default value: 1]
variable "druid_broker_node_count" {}

#druid coordinator node machine count. [Default value: 1]
variable "druid_coordinator_node_count" {}

#druid middlemanager node machine count. [Default value: 1]
variable "druid_middlemanager_node_count" {}

#druid historical node machine count. [Default value: 4 + 1(middlemanager machine)]
variable "druid_historical_node_count" {}

#zookeeper  machine count. [Deafult Value: 1]
variable "zookeeper_count" {}

#Postgres  machine count. [Deafult Value: 1]
variable "postgres_count" {}

#default machine instance type.[Default value: 't2.2xlarge']
variable "druid_default_instance_type" {}

#default machine disk size.[Default value: '30G']
variable "druid_machine_disk_size" {}

#default machine disk size.[Default value: '30G']
variable "druid_default_root_disk_size" {}

#owner of the setup
variable "owner" {}

variable "stack" {}

variable "creator" {}

variable "business_unit" {}

variable "tech_team" {}

variable "project" {}

variable "vpc_name" {}

variable "vpc_cidr_block" {}

variable "subnet_name" {}

variable "subnet_cidr_block" {}

variable "key_name" {}

variable "public_key" {}

variable "region" {}