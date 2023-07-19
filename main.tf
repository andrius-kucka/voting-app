resource "aws_eks_cluster" "aws_eks" {
  name     = "eks_cluster_voting_app"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.default_vpc_subnets
    security_group_ids      = [aws_security_group.vote.id]
  }

  tags = {
    Name = "Example Voting App"
  }
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "node-group-1"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = var.default_vpc_subnets

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_security_group" "vote" {
  name        = "vote_and_result"
  description = "Allow inbound traffic"

  ingress {
    description = "Ingress for Vote"
    from_port   = 31000
    to_port     = 31001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 0
      to_port   = 0
      protocol  = -1
      self      = true
  }

  tags = {
    Name = "vote"
  }
}