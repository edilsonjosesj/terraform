variable "region" {
  default     = "us-east-1"
  description = "Define AWS Region"
}

variable "profile" {
  default     = "zup-zenity-sandbox"
  description = "Define AWS Profile to apply Terraform Configuration"
}

variable "environment" {
  default     = "sdx"
  description = "Define the Environment dev | hml | prd | sdx"
  validation {
    condition     = endswith(var.environment, "prd") || endswith(var.environment, "hml") || endswith(var.environment, "dev") || endswith(var.environment, "sdx")
    error_message = "Environment Variable MUST Ends With: prd or dev or hml or sdx"
  }
}

variable "email_contact" {
  default     = "teste@teste.com.br"
  description = "Contact E-mail for Questions"
  sensitive   = true
}

variable "squad_leader" {
  default     = "Fulano"
  description = "Contact Squad Leader for Questions"
}

variable "squad_name" {
  default     = "SquadX"
  description = "Identify Which Squad That Resource is From"
}

variable "sg_name" {
  default     = "vpc-projetox-sdx-sg"
  description = "Define Security Group Name. Format of name: resource-projectname-env"
}

variable "security_group_inbound_rules" {
  description = "Define Security Group Inbound Rules"
  default = [
    {
      description = "Inbound Rule 1"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_blocks = ["0.0.0.0/0"]
    },

    {
      description = "Inbound Rule 2"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "cidr_block" {
  default     = "172.23.199.0/24"
  description = "CIDR defined for VPC"
}

variable "vpc_name" {
  default = "vpc-teste-projetox-sdx"
  
}

variable "instance_tenancy" {
  default     = "default"
  description = "Define the Instace Tenancy Type"
}

variable "sg_description" {
  default     = "Security Group for VPC vpc-projetox-sdx"
  description = "Define the Instace Tenancy Type"
}

variable "domain_name" {
  default     = "teste.com.br"
  description = "Set Domain Name of VPC"
  type        = string
}

variable "domain_name_servers" {
  type        = list(any)
  description = "Set the DNS Name Servers"
  default     = ["172.23.199.253", "172.23.199.254"]
}

variable "aws_vpc_dhcp_options_name" {
  type        = string
  description = "AWS Vpc DHCP Options Name"
  default     = ""
}

variable "subnets_prefix" {
  type        = map(any)
  description = "VPC Subnets with prefix /26"
  default = {
    subnet1 = {
      az   = "sa-east-1a"
      cidr = "172.23.199.0/26"
    }

    subnet2 = {
      az   = "sa-east-1b"
      cidr = "172.23.199.64/26"
    }

    subnet3 = {
      az   = "sa-east-1c"
      cidr = "172.23.199.128/26"
    }
  }
}

variable "vpc_acl_inbound_rules" {
  description = "Define VPC Access List Inbound Rules"
  default = [
    {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    }
  ]
}

variable "vpc_acl_outbound_rules" {
  description = "Define VPC Access List Outbound Rules"
  default = [
    {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    }
  ]
}