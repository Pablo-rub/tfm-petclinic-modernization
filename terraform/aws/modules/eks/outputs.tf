output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "oidc_url" {
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "oidc_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}
