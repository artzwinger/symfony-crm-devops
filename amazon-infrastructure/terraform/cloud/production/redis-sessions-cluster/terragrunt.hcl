terraform {
  source = "git::git@github.com:cloudposse/terraform-aws-elasticache-redis.git?ref=0.39.0"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    "../aws-data",
    "../webnode-securitygroup"
  ]
}

dependency "aws-data" {
  config_path = "../aws-data"
}

dependency "webnode-securitygroup" {
  config_path = "../webnode-securitygroup"
}

###########################################################
# View all available inputs for this module:
# https://registry.terraform.io/modules/cloudposse/elasticache-redis/aws/0.25.0?tab=inputs
###########################################################
inputs = {
  availability_zones = dependency.aws-data.outputs.available_aws_availability_zones_names
  name = "sessions"
  vpc_id = dependency.aws-data.outputs.vpc_id
  allowed_security_groups = [
    dependency.webnode-securitygroup.outputs.this_security_group_id
  ]
  subnets = dependency.aws-data.outputs.public_subnets
  cluster_mode_enabled = false
  instance_type = "cache.m5.large"
  apply_immediately = true
  automatic_failover_enabled = false
  engine_version = "6.x"
  family = "redis6.x"
  at_rest_encryption_enabled = false
  transit_encryption_enabled = false
}
