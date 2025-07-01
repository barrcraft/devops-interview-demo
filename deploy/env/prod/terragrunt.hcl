include {
  # Fetches Terraform state data
  path = find_in_parent_folders("env.hcl")
}

terraform {
  # Git reference to the downstream Terraform project for the associated config
  source = "git::ssh://git@github.com/barrcraft/oshi-tf-projects.git//devops-interview-demo?ref=main"
}

inputs = {
  # User defined variables for the downstream Terraform project
  name = "devops-interview-demo"
}
