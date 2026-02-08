terraform {
  cloud {
    organization = "Audlaywears"

    workspaces {
      name = "vpc-demo"
    }
  }
}
