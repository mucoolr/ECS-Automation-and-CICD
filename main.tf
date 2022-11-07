module "ECS" {
  source           = "./ECS"
  subnets          = module.vpc.public_subnets
  ecsClusterName   = var.ecsClusterName
  name_ecs_service = var.name_ecs_service
  taskDesiredCount = var.taskDesiredCount
  imageURI         = var.imageURI
  cpu              = var.cpu
  memory           = var.memory
  container_name   = var.container_name
  containerPort    = var.containerPort
  tags             = var.tags
  vpc_id           = module.vpc.vpc_id

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "metamundo-staging"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
}

module "web_server_sg" {
  source              = "terraform-aws-modules/security-group/aws"
  name                = "web-server"
  description         = "Security group for assingment"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
}

