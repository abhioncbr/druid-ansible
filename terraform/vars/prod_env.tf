## machines count
zookeeper_count = "3"
metadat_db_count = "1"
druid_data_node_count = "3"
druid_query_node_count = "2"
druid_master_node_count = "2"

## machines configuration
druid_machine_disk_size = "100"
druid_default_root_disk_size = "30"
druid_default_instance_type = "t2.2xlarge"

## machines static configuration
owner = "druid"
stack = "prod"
creator = "druid_creator"
tech_team = "druid_tech_team"
business_unit = "druid_business_unit"

region = "ca-central-1"
project = "druid-automation"

## vpc of druid-automation
vpc_cidr_block = "" ## for-eg. 10.0.0.0/16
vpc_name = "druid-vpc-automation"

## subnet of druid-automation
subnet_cidr_block = "" ## for-eg. 10.0.0.0/24
subnet_name = "druid-subnet-automation"

## pem file for machines.
key_name = "druid-tf (same as druid.pem)"
public_key = ""