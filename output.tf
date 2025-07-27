/*
output "vpc_id" {
  value = aws_vpc.Sankari_VPC.id
}

output "subnet_id" {
  value = aws_subnet.project17_subnet.id
}

output "sg1_id" {
  value = aws_security_group.project17_sg.id
}
*/
//need to check
output "task_role_arn" {
  value = module.task_role_arn.arn
}

output "ecs_execution_role_arn" {
  value       = module.execution_role_arn.arn
  description = "ECS task execution role ARN"
}