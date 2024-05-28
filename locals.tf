locals {
  name_prefix = "${var.env}-elasticache"
  tags = merge(var.tags , {tf-module-name = "elasticache"},{env = var.env})
}