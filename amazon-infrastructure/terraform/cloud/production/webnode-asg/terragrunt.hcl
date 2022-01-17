terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-autoscaling.git?ref=v3.4.0"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../aws-data", "../webnode-securitygroup", "../webnode-loadbalancer"]
}

dependency "aws-data" {
  config_path = "../aws-data"
}

dependency "webnode-securitygroup" {
  config_path = "../webnode-securitygroup"
}

dependency "webnode-loadbalancer" {
  config_path = "../webnode-loadbalancer"
}

dependency "webnode-keypair" {
  config_path = "../webnode-keypair"
}

###########################################################
# View all available inputs for this module:
# https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/3.4.0?tab=inputs
###########################################################
inputs = {
  health_check_type = "EC2"
  image_id = dependency.aws-data.outputs.aws_ami_id
  instance_type = "c5.xlarge"
  max_size = "3"
  min_size = "0"
  desired_capacity = "1"
  name = "Production-node"
  security_groups = [
    dependency.webnode-securitygroup.outputs.this_security_group_id
  ]
  target_group_arns = dependency.webnode-loadbalancer.outputs.target_group_arns
  vpc_zone_identifier = dependency.aws-data.outputs.public_subnets_asg
  key_name = dependency.webnode-keypair.outputs.key_pair_key_name
  recreate_asg_when_lc_changes = true
  force_delete = true
  root_block_device = [
    {
        volume_size = "50"
        delete_on_termination = true
    }
  ]
  user_data = <<-EOF
  #!/bin/bash
  su - www-data /usr/bin/oroinit
  service supervisor restart
  EOF
}
