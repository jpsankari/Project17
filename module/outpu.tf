output "vpc_id" {
  value = aws_vpc.this_vpc.id
}

output "subnet_id" {
  value = aws_subnet.this_subnet.id
}

output "sg_id" {
  value = aws_security_group.this_sg.id
}

output "task_role_arn" {
  value = aws_iam_role.ecs_xray_task_role.arn
}

output "execution_role_arn" {
  value = aws_iam_role.ecs_xray_execution_role.arn
}