resource "aws_vpc" "druid-vpc-automation" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "druid-subnet-automation" {
  vpc_id     = "${aws_vpc.druid-vpc-automation.id}"
  cidr_block = "${var.subnet_cidr_block}"

  tags {
    Name = "${var.subnet_name}"
  }
}

## for druid-cluster ssh enablemenet.
resource "aws_security_group" "druid-cluster-access-tf" {
  name   = "druid-cluster-access-tf"
  vpc_id = "${aws_vpc.druid-vpc-automation.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [""] ## for-eg. "182.20.0.0/22"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] ## for-eg. "0.0.0.0/0"
  }

  tags {
    Name = "adelaide-druid-access-tf"
  }
}

## for druid self-cluster self reference
resource "aws_security_group" "druid-tf" {
  name   = "druid-tf"
  vpc_id = "${aws_vpc.druid-vpc-automation.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = "true"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] ## for-eg. "0.0.0.0/0"
  }

  tags {
    Name = "druid-tf"
  }
}

## for druid-cluster interaction
resource "aws_security_group" "all-internal-druid-cidr-tf" {
  name   = "all-internal-druid-cidr-tf"
  vpc_id = "${aws_vpc.druid-vpc-automation.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [""] ## for-eg. "182.16.0.0/12", "20.0.0.0/8"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] ## for-eg. "0.0.0.0/0"
  }

  tags {
    Name = "all-internal-druid-cidr-tf"
  }
}
