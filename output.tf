output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr_ipv4" {
  value = aws_vpc.this.cidr_block
}

output "vpc_arn" {
  value = aws_vpc.this.arn
}