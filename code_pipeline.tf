resource "aws_codepipeline" "blue-green-deploy" {
  for_each = local.aws_codepipeline_map_list
  name = each.value.Name
  role_arn = data.aws_iam_role.blue-green-codepipeline.arn
  pipeline_type = "V2"
  execution_mode = "QUEUED"

  artifact_store {
    location = var.codepipeline_s3
    type = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeCommit"
      namespace = "SourceVariables"
      region = "ap-northeast-1"
      output_artifacts = [
        "SourceArtifact"
      ]
      configuration = {
        BranchName = "master"
        OutputArtifactFormat = "CODE_ZIP"
        PollForSourceChanges = "true"
        RepositoryName = "blue-green-deploy-artifact"
      }
      version = "1"
    }
  }

  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Test"
      owner = "AWS"
      provider = "CodeBuild"
      region = "ap-northeast-1"
      input_artifacts = [
        "SourceArtifact"
      ]
      output_artifacts = [
        "BuildArtifact"
      ]
      configuration = {
        ProjectName = "blue-green-build"
      }
      version = "1"
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "CodeDeployToECS"
      region = "ap-northeast-1"
      input_artifacts = [
        "BuildArtifact"
      ]
      namespace = "DeployVariables"
      configuration = {
        AppSpecTemplateArtifact = "BuildArtifact"
        ApplicationName = aws_codedeploy_app.blue-green.name
        DeploymentGroupName = each.value.DeploymentGroupName
        TaskDefinitionTemplateArtifact = "BuildArtifact"
      }
      version = "1"
    }
  }
}