resource "aws_elasticache_subnet_group" "ec" {
  name       = "${local.name_prefix}-subnet-group"
  subnet_ids = [var.subnet_ids]
  tags = var.tags
}

resource "aws_elasticache_parameter_group" "ec" {
  name   =  "${local.name_prefix}-pg"
  family = var.family
  tags = var.tags

}

resource "aws_elasticache_cluster" "example" {
  cluster_id           = "${local.name_prefix}-cluster"
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port
}




resource "aws_security_group" "ec" {
  name        = "${local.name_prefix}-sg"
  description = "${local.name_prefix}-sg"
  vpc_id      = var.vpc_id
  tags = var.tags
}



resource "aws_security_group_rule" "ec" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.sg_ingress_cidr
  security_group_id = aws_security_group.ec.id
}


resource "aws_vpc_security_group_egress_rule" "ec" {
  security_group_id = aws_security_group.ec.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}