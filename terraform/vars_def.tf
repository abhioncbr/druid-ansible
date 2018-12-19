#druid master machines count. [Default value: 2]
variable "druid_master_node_count" {}

#druid query machines count. [Default value: 2]
variable "druid_query_node_count" {}

#druid data machines count. [Default value: 2]
variable "druid_data_node_count" {}

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