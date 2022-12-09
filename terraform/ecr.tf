####################################################################
# AWS ECR
####################################################################
resource "aws_ecr_repository" "waypoint-demo" {
  name                 = "hcp-waypoint-demo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:CreateRepository",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
    ]

    resources = ["arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }

}

## resource "aws_iam_policy" "this" {
##   name   = "waypoint-runner-ecr"
##   policy = "${data.aws_iam_policy_document.this.json}"
## }

## resource "aws_iam_role_policy_attachment" "this" {
##   role       = "waypoint-runner"
##   policy_arn = "${aws_iam_policy.this.arn}"
## }