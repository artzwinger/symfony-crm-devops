terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-key-pair.git?ref=v1.0.0"
}

include {
  path = find_in_parent_folders()
}

###########################################################
# View all available inputs for this module:
# https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/3.4.0?tab=inputs
###########################################################
inputs = {
  key_name   = "production-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtvRc/+/qD69t8njaZxD+Ftu/Fu+m91MLAqqP0vcgBOn6TQCh2f3Fv9AUHXPKT82XPIP9k0eY6dTMAP6NhmSOf2e5jtiE0l0VEdo1kUOxnOdsT1XbIVeKeEWRD1zCotsxcdRer5AKLA203jg6DgJb6SNWRXxGAW2Q+OPC5Onrwpd0ld7pXHDtOb6p0mTuSXS21WQWg3kENMjHmbblwU1y03XVCJcNG8boLXcn2/feu0Odt399zZyuiPnM/NMcYyri63YEzaxB6OAl2jZ9PL8+lrVXoN4ngkkQPX6MxErRR/q8cbLTU+Y85WY3Q9hO7FzYetfpn233XapgmQiL3loLS1PD/e/DKCx17KhHEa8dhn+jQCQGgs8GoQVb9KyFMbjlVfE1WMoFLPi7ce5OzJUMrfytz8hhEoODOy8Jv1Rp7CDdT0bkS5MehdVFmTi/6qQJLDIv20ZxMsKkl9UH9O0v3QC96TTwtslBMKn3UpcUBRqmmOauflgivocs/ZkgbpXk= art@art-desk"
}
