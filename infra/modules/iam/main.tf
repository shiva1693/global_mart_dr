variable "name_prefix" { type = string }
variable "table_name" { type = string }
variable "tags" { type = map(string) }

resource "aws_iam_role" "lambda_assume_role" {
  name = "${var.name_prefix}-lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "${var.name_prefix}-lambda-execution-policy"
  path        = "/"
  description = ""

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:GetLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
            "dynamodb:PutItem",
            "dynamodb:GetItem",
            "dynamodb:UpdateItem",
            "dynamodb:DeleteItem",
            "dynamodb:Query",
            "dynamodb:Scan"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.lambda_assume_role.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}
output "lambda_role_arn" {
  value = aws_iam_role.lambda_assume_role.arn
}


