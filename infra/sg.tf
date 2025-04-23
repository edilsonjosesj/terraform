resource "aws_security_group" "this" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.security_group_inbound_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = local.security_group_common_tags
  depends_on = [
    aws_vpc.this
  ]
}