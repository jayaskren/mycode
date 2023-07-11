terraform {
  cloud {
    organization = "Askren_Inc"

    workspaces {
      name = "my-example"
    }
  }
}
