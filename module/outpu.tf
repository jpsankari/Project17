output "output_sankari_vpc_id" {
  value = aws_vpc.Sankari_VPC.id
}

output "output_sankari_subnet_id" {
  value = aws_subnet.Sankari_Subnet.id
}

output "output_sankari_sg_id" {
  value = aws_security_group.Sankari_SG.id
}

output "output_sankari_task_role_arn" {
  value = aws_iam_role.ecs_xray_task_role.arn
}

output "output_sankari_execution_role_arn" {
  value = aws_iam_role.ecs_xray_execution_role.arn
}