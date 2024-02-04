variable "repo_names" {
  default = ["my_db", "my_app"]
}

resource "aws_ecr_repository" "ecr_repos" {
  count = length(var.repo_names)
  name  = var.repo_names[count.index]

  image_scanning_configuration {
    scan_on_push = true
  }
}