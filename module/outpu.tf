output "vpc_id" {
  value = aws_vpc.Sankari_VPC.id
}

output "subnet_id" {
  value = aws_subnet.project17_subnet.id
}

output "sg1_id" {
  value = aws_security_group.project17_sg.id
}

output "task_role_arn" {
  value = aws_iam_role.ecs_xray_task_role.arn
}

output "execution_role_arn" {
  value       = aws_iam_role.ecs_xray_task_role.arn
  description = "ARN of the ECS task execution role"
}