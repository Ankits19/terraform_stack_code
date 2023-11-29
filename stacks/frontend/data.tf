data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "terraform-stack-dev-bucket" # Update with bucket name you created
    region  = "us-east-1" #Change region according to your requirement.
    encrypt = true
    key     = "network.tfstate"
  }
}