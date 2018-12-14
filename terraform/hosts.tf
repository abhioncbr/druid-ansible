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

resource "aws_instance" "druid-overlord" {
  count         = "${var.druid_overlord_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.adelaide-druid-access-tf.id}",
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
      "Name", "druid-overlord-${count.index}",
      "Druid-Overlord-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "druid-broker" {
  count         = "${var.druid_broker_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.adelaide-druid-access-tf.id}",
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
      "Name", "druid-broker-${count.index}",
      "Druid-Broker-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "druid-coordinator" {
  count         = "${var.druid_coordinator_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.adelaide-druid-access-tf.id}",
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
      "Name", "druid-coordinator-${count.index}",
      "Druid-Coordinator-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "druid-middlemanager" {
  count         = "${var.druid_middlemanager_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.adelaide-druid-access-tf.id}",
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
      "Name", "druid-middlemanager-${count.index}",
      "Druid-Middlemanager-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "druid-historical" {
  count         = "${var.druid_historical_node_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.adelaide-druid-access-tf.id}",
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
      "Name", "druid-historical-${count.index}",
      "Druid-Historical-Stack", "${var.stack}"
    )
  )}"
}

resource "aws_instance" "zookeeper" {
  count         = "${var.zookeeper_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.adelaide-druid-access-tf.id}",
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

resource "aws_instance" "postgres" {
  count         = "${var.postgres_count}"
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "${var.druid_default_instance_type}"
  subnet_id     = "${aws_subnet.druid-automation.id}"
  key_name      = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.druid.name}"

  vpc_security_group_ids = [
    "${aws_security_group.adelaide-druid-access-tf.id}",
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
      "Name", "druid-postgres-${count.index}",
      "Druid-Postgres-Stack", "${var.stack}"
      )
  )}"
}

