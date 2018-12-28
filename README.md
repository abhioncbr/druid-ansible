Druid Ansible
===============

This project can setup a druid cluster on AWS and is forked from project [druid-ansible](https://github
.com/godatadriven/druid-ansible)

Features
----------------
* [Terraform](https://www.terraform.io/) based cluster instances creation.
* [Ansible](https://www.ansible.com/) playbook for [Druid](http://druid.io/) setup.
* Druid [custom resources and extensions](resources).
* Example [Json scripts](example-jsons) for data ingestion and query.
* Sample [wikipedia data](data) in Json & Parquet format.

Infra Details
----------------
* AWS region: [provider.tf](terraform/provider.tf). Variable based.
* Variable definitions: [vars_def](terraform/vars_def.tf). Two Implementations([stg, prod](terraform/vars)) based on environment.
* EC2 ami: [ami](terraform/ami.tf). Centos 7 based.
* SSH key: [key](terraform/key.tf). Variable based. Create `druid.pem` key on [AWS console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair) and paste the key content in variable files.
* IAM role: [role](terraform/role.tf). Create IAM role with S3 access policy.
* Network: [network](terraform/network.tf). Following below are details -
  * Create AWS VPC. Provide [CIDR](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html#vpc-resize) block details in variable file.
  * Create Subnet in VPC and 3 security groups. Change it as per requirements.
* Instances: [hosts](terraform/hosts.tf). Variable Based. Instances are tagged wit various params.
* Local and S3 based [Terraform state](https://www.terraform.io/docs/state/) backends.
* For Initialization for terraform, follow
`` cd terraform && terraform init -var-file=vars/<env-file>.tf ``
* For cluster creation, follow
`` cd terraform && terraform apply -var-file=vars/<env-file>.tf``


Druid Cluster Details
-------------------------
* 1 Metadata DB Node. Postgres as metadata db along with Grafana based Druid cluster metrics.
* 3 Zookeeper Nodes. Apart from hosting as zookeeper processes, Druid data processes([historical](http://druid.io/docs/latest/design/historical.html)) also runs on the machine. 
* 2 Druid Master Nodes. Hosts Druid [overlord](http://druid.io/docs/latest/design/overlord.html) and [coordinator](http://druid.io/docs/latest/design/coordinator.html) processes. 2 Nodes for HA.
* 2 Druid Query Nodes. Hosts Druid [broker](http://druid.io/docs/latest/design/broker.html) and [middlemanager](http://druid.io/docs/latest/design/middlemanager.html) processes/ 2 Nodes for HA.
* 3 Druid Data Nodes. Hosts Druid [historical](http://druid.io/docs/latest/design/historical.html) process.

Ansible roles Details
-------------------------

Ansible command for initializing Druid cluster
-------------------------------------------------
* After terraform apply, follow below command
``cd .. && ./run.sh "--user centos playbook.yml" ``

