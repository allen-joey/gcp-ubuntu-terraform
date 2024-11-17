# main.tf

module "vpc" {
  source = "./modules/vpc"
}

module "vm-instance" {
  source     = "./modules/vm-instance"
  depends_on = [module.vpc.vpc_applied]
}