module "github-oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "~> 1"

  create_oidc_provider = true
  create_oidc_role     = true

  repositories              = ["Rafael-Souza98/treinamento-terraform"]
  oidc_role_attach_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

output "github-oidc-role-arn" {
  value = module.github-oidc.oidc_role
}