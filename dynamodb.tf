#Dynamo DB for state file locking
resource "aws_dynamodb_table" "brinabh_state_lock" {
  name         = "brinabh_state_lock_table"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}