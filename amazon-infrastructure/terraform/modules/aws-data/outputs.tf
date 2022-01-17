output "aws_region" {
  description = "Details about selected AWS region"
  value       = data.aws_region.selected
}

output "available_aws_availability_zones_names" {
  description = "A list of the Availability Zone names available to the account"
  value       = data.aws_availability_zones.available.names
}

output "available_aws_availability_zones_zone_ids" {
  description = "A list of the Availability Zone IDs available to the account"
  value       = data.aws_availability_zones.available.zone_ids
}

output "aws_ami_id" {
  description = "AMI"
  value       = data.aws_ami.ubuntu.id
}

output "public_subnets" {
  description = "VPC subnets"
  value = ["subnet-ad9724c6", "subnet-4500e938"]
}

output "public_subnets_asg" {
  description = "VPC subnets"
  value = ["subnet-ad9724c6"] # we need to place instances only in RDS availability zone
}

output "vpc_id" {
  description = "VPC ID"
  value = "vpc-a3810ac8"
}

