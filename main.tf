locals {
  prefix = "SankariEx" # change to your desired prefix
}

module "module_project" {
  source      = "./module/"
  name_prefix_base  = var.name_prefix_base
}


data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


resource "aws_ecr_repository" "ecr" {
 name         = "${local.prefix}-ecr"
  force_delete = true  
}

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
      container_definitions = {
        SankariEx-CONTAINER = {
          essential = true
          #image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-ecr:latest"
          image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.id}.amazonaws.com/${local.prefix}-ecr:latest"
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
      subnet_ids                         = [module.output_sankari_subnet_id.ids] #List of subnet IDs to use for your tasks
      security_group_ids                 = [module.output_sankari_sg_id.id]     #Create a SG resource and pass it here
    }
  }
  
}