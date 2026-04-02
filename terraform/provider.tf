provider "kubernetes" {
  host                   = data.aws_eks_cluster.devops.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.devops.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks", "get-token",
      "--cluster-name", "devops-eks"
    ]
  }
}

data "aws_eks_cluster" "devops" {
  name = aws_eks_cluster.eks.name
}

