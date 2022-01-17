terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-alb.git"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../aws-data", "../loadbalancer-internal-securitygroup"]
}

dependency "aws-data" {
  config_path = "../aws-data"
}

dependency "loadbalancer-internal-securitygroup" {
  config_path = "../loadbalancer-internal-securitygroup"
}

###########################################################
# View all available inputs for this module:
# https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/5.1.0?tab=inputs
###########################################################
inputs = {
  name = "Production-balancer"

  logging_enabled = true

  security_groups = [
    dependency.loadbalancer-internal-securitygroup.outputs.this_security_group_id
  ]

  subnets = dependency.aws-data.outputs.public_subnets

  vpc_id = dependency.aws-data.outputs.vpc_id

  https_listeners = [
    {
        certificate_arn = "arn:aws:acm:us-east-2:239589202594:certificate/9c29a381-4617-4afd-b3ad-73f1fb501f3d"
        port = "443"
    },
    {
      port = "8080"
      target_group_index = "1"
      certificate_arn = "arn:aws:acm:us-east-2:239589202594:certificate/9c29a381-4617-4afd-b3ad-73f1fb501f3d"
    }
  ]
  http_tcp_listeners = [
    {
      port = 80
      protocol = "HTTP"
      action_type = "redirect"
      redirect = {
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  target_groups = [
    {
        name = "production-app"
        backend_protocol = "HTTP"
        backend_port = "80"
        health_check = {
          enabled = true
          interval = 30
          path = "/alb_health"
          port = "80"
          healthy_threshold = 3
          unhealthy_threshold = 3
          timeout = 5
          protocol = "HTTP"
          matcher = "200,302,403"
        }
    },
    {
        name = "production-websocket"
        backend_protocol = "HTTP"
        backend_port = "8080"
        health_check = {
          enabled = true
          interval = 30
          path = "/alb_health"
          port = "80"
          healthy_threshold = 3
          unhealthy_threshold = 3
          timeout = 5
          protocol = "HTTP"
          matcher = "200,302,403"
        }
        stickiness = {
          enabled = true
          type = "lb_cookie"
        }
    }
  ]
}
