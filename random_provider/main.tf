terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_id" "rand_id" {
  byte_length = 8
}

output "name" {
  value = random_id.rand_id.hex
}