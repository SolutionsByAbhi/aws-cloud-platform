output "cluster_name"  {
    value =  module.ecs_cluster.cluster_name
}

output "service_name"  {
    value =  module.ecs_cluster.service_name
}

output "alb_dns_name"  {
    value =  module.ecs_cluster.alb_dns_name
}
