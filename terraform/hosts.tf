locals {
  common_tags = {
    Owner        = "${var.owner}"
    Stack        = "${var.stack}"
    Creator      = "${var.creator}"
    BusinessUnit = "${var.business_unit}"
    TechTeam     = "${var.tech_team}"
    Project      = "${var.project}"
  }
  druid_tags = {
    Cluster = "druid"
  }
  zookeeper_tags = {
    Cluster = "druid_zookeeper"
  }
  metadata_db_tags = {
    Cluster = "druid_metadata_db"
  }
}

resource "aws_instance" "druid-master" {
  count         = "${var.druid_master_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-subnet-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.druid-cluster-access-tf.id}",
    "${aws_security_group.druid-tf.id}",
    "${aws_security_group.all-internal-druid-cidr-tf.id}"
  ]

  root_block_device {
    volume_size = "${var.druid_default_root_disk_size}"
  }

  tags = "${merge(
    local.common_tags,
    local.druid_tags,
    map(
      "Name", "druid-master-${count.index}",
      "Druid-Master-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "druid-query" {
  count         = "${var.druid_query_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-subnet-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.druid-cluster-access-tf.id}",
    "${aws_security_group.druid-tf.id}",
    "${aws_security_group.all-internal-druid-cidr-tf.id}"
  ]

  root_block_device {
    volume_size = "${var.druid_default_root_disk_size}"
  }

  tags = "${merge(
    local.common_tags,
    local.druid_tags,
    map(
      "Name", "druid-query-${count.index}",
      "Druid-Query-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "druid-data" {
  count         = "${var.druid_data_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-subnet-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.druid-cluster-access-tf.id}",
    "${aws_security_group.druid-tf.id}",
    "${aws_security_group.all-internal-druid-cidr-tf.id}"
  ]

  root_block_device {
    volume_size = "${var.druid_default_root_disk_size}"
  }

  tags = "${merge(
    local.common_tags,
    local.druid_tags,
    map(
      "Name", "druid-data-${count.index}",
      "Druid-Data-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "zookeeper" {
  count         = "${var.zookeeper_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-subnet-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.druid-cluster-access-tf.id}",
    "${aws_security_group.druid-tf.id}",
    "${aws_security_group.all-internal-druid-cidr-tf.id}",
  ]

  root_block_device {
    volume_size           = "${var.druid_default_root_disk_size}"
    delete_on_termination = "true"
  }

  tags = "${merge(
    local.common_tags,
    local.zookeeper_tags,
    map(
      "Name", "druid-zookeeper-${count.index}",
      "Druid-Zookeeper-Stack", "${var.stack}"
      )
  )}"
}

resource "aws_instance" "metadata_db" {
  count         = "${var.metadata_db_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-subnet-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.druid-cluster-access-tf.id}",
    "${aws_security_group.druid-tf.id}",
    "${aws_security_group.all-internal-druid-cidr-tf.id}",
  ]

  root_block_device {
    volume_size           = "${var.druid_default_root_disk_size}"
    delete_on_termination = "true"
  }

  tags = "${merge(
    local.common_tags,
    local.metadata_db_tags,
    map(
      "Name", "druid-metadata-db-${count.index}",
      "Druid-Metadata-DB-Stack", "${var.stack}"
      )
  )}"
}

