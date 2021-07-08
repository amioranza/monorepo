provider "aws" {
  region = var.region
}

module "vpc" {
  source     = "git@github.com:amioranza/monorepo.git//modules/aws-vpc"
  cidr_block = "172.16.0.0/16"

  context = module.this.context
}

module "subnets" {
  source  = "git@github.com:amioranza/monorepo.git//modules/aws-dynamic-subnets"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false

  context = module.this.context
}
