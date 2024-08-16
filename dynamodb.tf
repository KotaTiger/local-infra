/*
resource "aws_dynamodb_table" "terraform_locks" {
  name                        = "terraform-up-and-runnning-locks"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "LockID"
  deletion_protection_enabled = true

  attribute {
    name = "LockID"
    type = "S"
  }
}
*/