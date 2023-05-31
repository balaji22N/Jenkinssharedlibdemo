
aws_eks_cluster_config = {

      "demo-cluster" = {

        eks_cluster_name         = "demo-cluster1"
        eks_subnet_ids = ["subnet-0509c614519f7f17e","subnet-002bdc69a35cf2618","subnet-05a78b6df09f102df", "subnet-046d315bf6e1c40ea"]
        tags = {
             "Name" =  "demo-cluster"
         }  
      }
}

eks_node_group_config = {

  "node1" = {

        eks_cluster_name         = "demo-cluster"
        node_group_name          = "mynode"
        nodes_iam_role           = "eks-node-group-general1"
        node_subnet_ids          = ["subnet-0509c614519f7f17e","subnet-002bdc69a35cf2618","subnet-05a78b6df09f102df", "subnet-046d315bf6e1c40ea"]

        tags = {
             "Name" =  "node1"
         } 
  }
}
