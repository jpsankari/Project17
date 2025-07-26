//IAM Task role
resource "aws_iam_role" "task_role" {
  name = "Project17-ecs-xray-taskrole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "Project17_ecs-tasks.amazonaws.com" //ECS Service Name
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "xray_policy" {
  role       = aws_iam_role.task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

//IAM Task Execution Role
resource "aws_iam_role" "task_execution_role" {
  name = "Project-ecs-taskexecutionrole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "execution_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ])

  role       = aws_iam_role.task_execution_role.name
  policy_arn = each.value
}

// GitHub OIDC Role for CI/CD
resource "aws_iam_role" "github_oidc" {
  name = "GitHubActionsRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = "arn:aws:iam::AKIATXF4JQPH52H6D4ZJ:oidc-provider/token.actions.githubusercontent.com"
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:<your-org>/<your-repo>:*"
        }
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "github_oidc_policy" {
  name       = "attach-ci-perms"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # or scoped custom policy
  roles      = [aws_iam_role.github_oidc.name]
}