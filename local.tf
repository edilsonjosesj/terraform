locals {
  vpc_common_tags = {
    Name         = var.vpc_name
    Squad        = var.squad_name
    Environment  = var.environment
    E-mail       = var.email_contact
    Leader       = var.squad_leader
    CreationDate = "${timestamp()}"
    AccountID    = data.aws_caller_identity.account_id.id
  }

  security_group_common_tags = {
    Name         = var.sg_name
    Squad        = var.squad_name
    Environment  = var.environment
    E-mail       = var.email_contact
    Leader       = var.squad_leader
    CreationDate = "${timestamp()}"
  }

  access_list_common_tags = {
    Name         = "acl-${var.vpc_name}"
    Squad        = var.squad_name
    Environment  = var.environment
    E-mail       = var.email_contact
    Leader       = var.squad_leader
    CreationDate = "${timestamp()}"
  }

  route_table_common_tags = {
    Name         = "rt-${var.vpc_name}"
    Squad        = var.squad_name
    Environment  = var.environment
    E-mail       = var.email_contact
    Leader       = var.squad_leader
    CreationDate = "${timestamp()}"
  }
}