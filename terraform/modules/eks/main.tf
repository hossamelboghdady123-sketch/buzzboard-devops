resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/${local.cluster_name}/cluster"

  retention_in_days = 30

}
resource "aws_eks_cluster" "this" {

  name = local.cluster_name

  role_arn = var.cluster_role_arn

  version = var.cluster_version

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {

    subnet_ids = var.private_subnet_ids

    security_group_ids = [
      var.eks_security_group_id
    ]

    endpoint_private_access = true

    endpoint_public_access = true

  }

  depends_on = [
    aws_cloudwatch_log_group.eks
  ]
}

resource "aws_eks_node_group" "main" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "main-workers"

  node_role_arn = var.node_role_arn

  subnet_ids = var.private_subnet_ids

  instance_types = var.instance_types

  capacity_type = "ON_DEMAND"

  scaling_config {

    desired_size = 2

    min_size = 2

    max_size = 5

  }

  update_config {

    max_unavailable = 1

  }

  depends_on = [
    aws_eks_cluster.this
  ]
}
data "tls_certificate" "eks" {

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer

}

resource "aws_iam_openid_connect_provider" "eks" {

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint
  ]
}

