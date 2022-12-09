output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "eks_cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = resource.aws_ecs_cluster.ecs.name
}

output "public_subnets" {
  description = "Public Subnets"
  value       = module.vpc.public_subnets
}
