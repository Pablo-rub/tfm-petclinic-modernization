data "aws_caller_identity" "current" {}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-petclinic"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:Pablo-rub/tfm-petclinic-modernization:*"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "github_ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.github_actions.name
}

resource "aws_iam_policy" "github_eks" {
  name = "github-actions-eks-deploy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "eks:DescribeCluster",
        "eks:ListClusters"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "github_eks" {
  policy_arn = aws_iam_policy.github_eks.arn
  role       = aws_iam_role.github_actions.name
}
