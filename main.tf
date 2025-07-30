locals {
  prefix = "SankariEx" # change to your desired prefix
  subnetID_base = module.module_vpc.subnet_id
  SecurityGrpID_base = module.module_vpc.sg_id
}

module "module_vpc" {
  source      = "./modules/vpc" # Ensure this points to the correct module path
  name_prefix_base  = var.name_prefix_base
 }

/*
module "module_iam" {
  source      = "./modules/iam" # Ensure this points to the correct module path
  name_prefix_base  = var.name_prefix_base
 }
*/

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

/*
resource "aws_ecr_repository" "ecr" {
  name = "sankari-ecr"
  force_delete = true
}
*/
# subnetID_base and SecurityGrpID_base are now defined in the locals block above
/*

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.6.0"

  cluster_name = "${local.prefix}-ecs"
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  
  services = {
    SankariEx-TASKDEFINITION = {
      cpu    = 512
      memory = 1024
    # execution_role_arn   = module.module_vpc.execution_role_arn
     #task_role_arn        = module.module_vpc.task_role_arn
      
      container_definitions = {
        SankariEx-CONTAINER = {
          essential = true
          #image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-ecr:latest"
          image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.id}.amazonaws.com/sankari-ecr:latest"
          port_mappings = [
            {
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      subnet_ids                         = [subnetID_base]
      security_group_ids                 = [SecurityGrpID_base]    #Create a SG resource and pass it here
    }
  }
  
}
*/