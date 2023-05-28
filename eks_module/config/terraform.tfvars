
aws_eks_cluster_config = {

      "demo-cluster" = {

        eks_cluster_name         = "demo-cluster1"
        eks_subnet_ids = ["subnet-05cb97150234c1af9","subnet-02ddd61a18be0ee0a","subnet-0d6b2ba7569376342", "subnet-00096fd5639c3a83f"]
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
        node_subnet_ids          = ["subnet-05cb97150234c1af9","subnet-02ddd61a18be0ee0a","subnet-0d6b2ba7569376342", "subnet-00096fd5639c3a83f"]

        tags = {
             "Name" =  "node1"
         } 
  }
}
