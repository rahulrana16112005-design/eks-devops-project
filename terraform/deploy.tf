resource "null_resource" "k8s_apply" {

  triggers = {
    cluster_name = aws_eks_cluster.eks.name
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Updating kubeconfig..."
      aws eks update-kubeconfig --region ap-south-1 --name ${self.triggers.cluster_name}

      echo "Applying Kubernetes resources..."

      echo "Applying Deployment..."
      kubectl apply -f ../k8s/deployment.yaml

      echo "Applying Service..."
      kubectl apply -f ../k8s/service.yaml

      echo "Applying Ingress..."
      kubectl apply -f ../k8s/ingress.yaml

    EOT
  }

  depends_on = [
    aws_eks_cluster.eks,
    aws_eks_node_group.node_group
  ]
}


# 🔥 CLEANUP (SAFE + CONTROLLED)
resource "null_resource" "k8s_cleanup" {

  triggers = {
    cluster_name = aws_eks_cluster.eks.name
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      echo "Cleaning Kubernetes resources FIRST..."

      aws eks update-kubeconfig --region ap-south-1 --name ${self.triggers.cluster_name}

      echo "Deleting Ingress..."
      kubectl delete -f ../k8s/ingress.yaml || true

      echo "Deleting Service..."
      kubectl delete -f ../k8s/service.yaml || true

      echo "Deleting Deployment..."
      kubectl delete -f ../k8s/deployment.yaml || true

      echo "Waiting for ALB cleanup..."
      sleep 60
    EOT
  }

  depends_on = [
    null_resource.k8s_apply
  ]
}
