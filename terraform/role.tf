resource "aws_iam_role" "druid-iam" {
  name = "druid-iam-role-tf"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


resource "aws_iam_policy" "druid-full-s3-policy" {
  name        = "Druid-FullS3-Policy-tf"
  description = "Allows full S3 access, managed by Terraform"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
EOF

}

resource "aws_iam_policy_attachment" "druid-full-s3" {
  name       = "druid-full-s3-tf"
  roles      = ["${aws_iam_role.druid-iam.name}"]
  policy_arn = "${aws_iam_policy.druid-full-s3-policy.arn}"
}

resource "aws_iam_instance_profile" "druid" {
  name  = "druid-profile-tf"
  role = "${aws_iam_role.druid-iam.name}"
}
