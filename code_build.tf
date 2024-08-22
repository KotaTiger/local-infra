resource "aws_codebuild_project" "blue-green" {
  name = "blue-green-build"
  service_role = data.aws_iam_role.blue-green-build.arn

  build_timeout = 15

  artifacts {
    name = "blue-green-build"
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"
  }

  environment {
    type = "LINUX_CONTAINER"
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/amazonlinux2-x86_64-standard:5.0-24.05.15"
    image_pull_credentials_type = "CODEBUILD"
  }
}