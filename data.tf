data "aws_caller_identity" "account_id" {}

data "aws_subnet_ids" "get_subnet_ids" {
  vpc_id = "default"
  #vpc_id = data.aws_vpc.this.id

  depends_on = [
    aws_subnet.this, aws_vpc.this
  ]
}