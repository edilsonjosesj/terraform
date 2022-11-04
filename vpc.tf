#CREATE AWS VPC:

resource "aws_vpc" "this" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags             = local.vpc_common_tags
}

#CREATE AWS VPC DHCP OPTIONS:

resource "aws_vpc_dhcp_options" "this" {
  domain_name          = "service.consul"
  domain_name_servers  = ["127.0.0.1", "10.0.0.2"]
  ntp_servers          = ["127.0.0.1"]
  netbios_name_servers = ["127.0.0.1"]
  netbios_node_type    = 2

  tags = {
    Name = "foo-name"
  }

  depends_on = [
    aws_vpc.this
  ]
}

#CREATE VPC DHCP OPTIONS ASSOCIATION

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.this.id
  dhcp_options_id = aws_vpc_dhcp_options.this.id
}

#CREATE AWS SUBNETS:

resource "aws_subnet" "this" {
  vpc_id               = aws_vpc.this.id

  for_each = var.subnets_prefix
  availability_zone_id = each.value["az"]
  cidr_block           = each.value["cidr"]

  tags = {
    Name = "subnet-${var.vpc_name}-${each.value["az"]}"
  }
}

#CREATE VPC ACL AND ITS INBOUND AND OUTBOUND RULES:

resource "aws_network_acl" "this" {
  vpc_id      = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.vpc_acl_inbound_rules

    content {
      protocol = ingress.value.protocol
      rule_no   = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block    = ingress.value.cidr_block
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.vpc_acl_outbound_rules

    content {
      protocol = egress.value.protocol
      rule_no   = egress.value.rule_no
      action     = egress.value.action
      cidr_block    = egress.value.cidr_block
      from_port = egress.value.from_port
      to_port = egress.value.to_port
    }
  }

  tags = local.access_list_common_tags
  depends_on = [
    aws_vpc.this
  ]
}

#CREATE ASSOCIATION BETWEEN ACL AND VPC:

resource "aws_network_acl_association" "this" {
  depends_on = [aws_subnet.this]
  #for_each = data.aws_subnet_ids.get_subnet_ids.ids
  network_acl_id = aws_network_acl.this.id
  #subnet_id      = each.value
  subnet_id = flatten(data.aws_subnet_ids.get_subnet_ids.ids)[0]
}

#CREATE VPC ROUTE TABLE:

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  
  tags = local.route_table_common_tags
}

#CREATE ASSOCIATION BETWEEN ROUTE TABLE AND VPC:

resource "aws_route_table_association" "this" {
  depends_on = [aws_subnet.this]
  #for_each = data.aws_subnet_ids.get_subnet_ids.ids
  #subnet_id      = each.value
  subnet_id = flatten(data.aws_subnet_ids.get_subnet_ids.ids)[0]
  route_table_id = aws_route_table.this.id
}