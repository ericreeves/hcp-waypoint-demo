####################################################################
# AWS ECS
####################################################################

resource "aws_cloudwatch_log_group" "ecs" {
  name = "hcp-waypoint-demo-ecs"
}

resource "aws_ecs_cluster" "ecs" {
  name = "hcp-waypoint-demo"

  configuration {
    execute_command_configuration {
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs.name
      }
    }
  }
}