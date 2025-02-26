terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_elasticache_subnet_group" "example" {
  name       = "example-subnet-group"
  subnet_ids = ["subnet-96e89bda", "subnet-b16ce9ca"] # Replace with valid subnet IDs
}

resource "aws_elasticache_replication_group" "example" {
  replication_group_id       = "example-redis"
  description                = "Example Redis replication group"
  node_type                  = "cache.t3.micro"
  engine                     = "redis"
  engine_version             = "6.x"
  apply_immediately          = "true"
  port                       = 6379
  automatic_failover_enabled = true
  num_cache_clusters         = 2
  subnet_group_name          = aws_elasticache_subnet_group.example.name
}
