module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "eu-north-1a",
    "eu-north-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}
module "security_group" {

  source = "./modules/security-group"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.vpc.vpc_id

}
module "iam" {

  source = "./modules/iam"

  project_name = var.project_name

  environment = var.environment

}


module "backend" {

  source = "./modules/backend"

  project_name = var.project_name

  environment = var.environment

}
module "kms" {

  source = "./modules/kms"

  project_name = var.project_name

  environment = var.environment

}
module "eks" {

  source = "./modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn

  private_subnet_ids = module.vpc.private_subnet_ids

  eks_security_group_id = module.security_group.eks_sg_id

  kms_key_arn = module.kms.kms_key_arn
}
module "ecr" {

  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}
module "rds" {

  source = "./modules/rds"

  project_name = var.project_name
  environment  = var.environment

  private_subnet_ids    = module.vpc.private_subnet_ids
  rds_security_group_id = module.security_group.rds_sg_id

  db_password = var.db_password
}
