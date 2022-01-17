data "aws_region" "selected" {}

data "aws_availability_zones" "available" {
  filter {
    name = "zone-name"
    values = ["*a"] // this needs to be changed to correspond RDS instance's zone
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["Production node*"]
  }
}
