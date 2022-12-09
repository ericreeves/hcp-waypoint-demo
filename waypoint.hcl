project = "hcp-waypoint-demo"

runner {
  enabled = true

  data_source "git" {
    url = "https://github.com/ericreeves/hcp-waypoint-demo"
  }

  poll {
    enabled = true
  }
}

#######################################################
# Local (Docker)
#######################################################
app "local" {
  build {
    use "docker" {}
  }

  deploy {
    use "docker" {
      service_port = 3000
      static_environment = {
        PLATFORM = "docker (dev)"
      }
    }
  }
}

#######################################################
# Dev (ECS)
#######################################################
app "dev" {
  runner {
    profile = "ecs-ECS-RUNNER"
  }
  build {
    use "docker" {}
    registry {
      use "aws-ecr" {
        repository = var.ecr_registry
        region     = var.aws_region
        tag        = gitrefpretty()
      }
    }
  }

  deploy {
    use "aws-ecs" {
      static_environment = {
        PLATFORM = "AWS ECS (us-west-2)"
      }
      region = var.aws_region
      memory = 512
      log_group = var.log_group_ecs
      subnets = var.ecs_subnets
      cluster = var.ecs_cluster
      alb {
        subnets = var.ecs_subnets
      }
      logging {
        create_group = true
      }
    }
  }
}

#######################################################
# Prod (Kubernetes)
#######################################################
// app "prod" {
//   runner {
//     profile = "kubernetes-EKS-RUNNER"
//   }

//   build {
//     use "docker" {}
//     registry {
//       use "docker" {
//         image = "${var.REGISTRY_USERNAME}/${var.REGISTRY_IMAGENAME}"
//         tag = "prod"
//         local = false
//         auth {
//           username = var.REGISTRY_USERNAME
//           password = var.REGISTRY_PASSWORD
//         }
//       }
//     }
//   }

//   deploy {
//     use "kubernetes" {
//       static_environment = {
//         PLATFORM = "AWS EKS (us-west-2)"
//       }
//       probe_path = "/"
//       service_port = 3000
//       memory {
//         request = "64Mi"
//         limit   = "128Mi"
//       }

//       autoscale {
//         min_replicas = 1
//         max_replicas = 5
//         cpu_percent = 20
//       }
//     }
//   }

//   release {
//     use "kubernetes" {
//       load_balancer = true
//       port          = 3000
//     }
//   }
// }

variable "ecr_registry" {
  default = "hcp-waypoint-demo"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "log_group_ecs" {
  default = "hashicorp-game-ecs"
}

variable "ecs_cluster" {
  default = "hcp-waypoint-demo"
}
variable "ecs_subnets" {
  default = ["subnet-05486d7c329b7e22a","subnet-0f0279ddd54ce004a","subnet-0d263826e7400c8f9"]
}

variable "REGISTRY_USERNAME" {
  type = string
  default = ""
env = ["REGISTRY_USERNAME"]
}

variable "REGISTRY_PASSWORD" {
  type = string
  sensitive = true
  default = ""
  env = ["REGISTRY_PASSWORD"]
}

variable "REGISTRY_IMAGENAME" {
  type = string
  default = ""
  env = ["REGISTRY_IMAGENAME"]
}
