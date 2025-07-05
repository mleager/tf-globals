data "aws_caller_identity" "current" {}

locals {
  account_id     = data.aws_caller_identity.current.account_id
  oidc_url       = "token.actions.githubusercontent.com"
  bucket_name    = "tf-state-8864"
  oidc_role_name = "github-oidc-admin"
}

# Create OIDC Provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://${local.oidc_url}"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd",
  ]
}

# IAM Assume Role Policy Document for GitHub OIDC role
data "aws_iam_policy_document" "github_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_url}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "${local.oidc_url}:sub"
      values   = ["repo:mleager/*"]
    }
  }
}

# IAM Role for GitHub OIDC
resource "aws_iam_role" "github_oidc_role" {
  name               = local.oidc_role_name
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role_policy.json
  description        = "Role for GitHub Actions OIDC to assume"
}

# Attach AdministratorAccess
resource "aws_iam_role_policy_attachment" "attach_admin" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# # S3 Bucket Policy allowing the OIDC IAM Role access
# data "aws_iam_policy_document" "bucket_policy" {
#   statement {
#     effect = "Allow"
#     principals {
#       type        = "AWS"
#       identifiers = [aws_iam_role.github_oidc_role.arn]
#     }
#     actions = [
#       "s3:GetObject",
#       "s3:PutObject",
#       "s3:ListBucket"
#     ]
#     resources = [
#       "arn:aws:s3:::${local.bucket_name}",
#       "arn:aws:s3:::${local.bucket_name}/*"
#     ]
#   }
# }
#
# resource "aws_s3_bucket_policy" "terraform_state_bucket_policy" {
#   bucket = local.bucket_name
#   policy = data.aws_iam_policy_document.bucket_policy.json
# }

