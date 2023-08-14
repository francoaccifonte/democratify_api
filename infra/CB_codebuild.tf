resource "aws_iam_role" "codebuild" {
  name               = "codebuild_asume_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "codebuild" {
  name       = "Codebuild"
  policy_arn = aws_iam_policy.codebuild.arn
  roles      = [aws_iam_role.codebuild.name]
}

resource "aws_iam_policy" "codebuild" {
  name        = "MyPolicy"
  description = "My custom IAM policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "ecr:BatchCheckLayerAvailability",
            "ecr:CompleteLayerUpload",
            "ecr:GetAuthorizationToken",
            "ecr:InitiateLayerUpload",
            "ecr:PutImage",
            "ecr:UploadLayerPart"
          ],
          "Resource" : "*",
          "Effect" : "Allow"
        },
        {
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:logs:us-east-2:480062172841:log-group:/aws/codebuild/Rockolify",
            "arn:aws:logs:us-east-2:480062172841:log-group:/aws/codebuild/Rockolify:*"
          ],
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
        },
        {
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:s3:::codepipeline-us-east-2-*"
          ],
          "Action" : [
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketAcl",
            "s3:GetBucketLocation"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "codebuild:CreateReportGroup",
            "codebuild:CreateReport",
            "codebuild:UpdateReport",
            "codebuild:BatchPutTestCases",
            "codebuild:BatchPutCodeCoverages"
          ],
          "Resource" : [
            "arn:aws:codebuild:us-east-2:480062172841:report-group/Rockolify-*"
          ]
        }
      ]
  })
}


resource "aws_codebuild_project" "Rockolify" {
  badge_enabled      = false
  build_timeout      = 60
  encryption_key     = "arn:aws:kms:us-east-2:480062172841:alias/aws/s3"
  name               = "Rockolify"
  project_visibility = "PRIVATE"
  queued_timeout     = 480
  service_role       = aws_iam_role.codebuild.arn
  tags               = {}
  tags_all           = {}

  artifacts {
    encryption_disabled    = false
    override_artifact_name = false
    type                   = "NO_ARTIFACTS"
  }

  cache {
    modes = []
    type  = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"

    environment_variable {
      name  = "AWS_ACCOUNT"
      value = local.account_id
    }
    environment_variable {
      name  = "REGION"
      value = local.region
    }
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }

  source {
    git_clone_depth     = 1
    insecure_ssl        = false
    location            = "https://github.com/francoaccifonte/democratify_api.git"
    report_build_status = false
    type                = "GITHUB"

    git_submodules_config {
      fetch_submodules = false
    }
  }
}

resource "aws_codebuild_webhook" "on_merge_or_message" {
  project_name = aws_codebuild_project.Rockolify.name

  filter_group {
    filter {
      pattern = "PULL_REQUEST_MERGED"
      type    = "EVENT"
    }
  }
  filter_group {
    filter {
      pattern = "\\[CodeBuild\\]"
      type    = "COMMIT_MESSAGE"
    }
    filter {
      pattern = "PUSH"
      type    = "EVENT"
    }
  }
}
