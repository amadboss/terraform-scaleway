terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  access_key  = var.scaleway_access_key
  secret_key  = var.scaleway_secret_key
  project_id  = var.scaleway_project_id
}

module "k8s-pvn-creation" {
  source = "./modules/k8s-pvn-creation"
  vpcs = var.vpc
  project_id  = var.scaleway_project_id
}

module "k8s-cluster-creation" {
  source = "./modules/k8s-cluster-creation"

  for_each = { for cluster in var.clusters : cluster.name => cluster }
  name                                 = each.value.name
  cluster_region                       = each.value.cluster_region
  cni                                  = each.value.cni
  cluster_version                     = each.value.cluster_version
  project_id  = var.scaleway_project_id
  delete_additional_resources = each.value.delete_additional_resources
  cluster_type = each.value.cluster_type
  auto_upgrade = each.value.auto_upgrade
  autoscaler_config                 = each.value.autoscaler_config
  pvn_name = each.value.pvn_name
  pvn_ids_map  = module.k8s-pvn-creation.pvn_ids
}


module "k8s-pool-creation" {
  source = "./modules/k8s-pool-creation"
  for_each = { for pool in var.pools : pool.name => pool }
  name = each.value.name
  node_type              = each.value.node_type
  pool_zone              = each.value.pool_zone
  autoscaling            = each.value.autoscaling
  autohealing            = each.value.autohealing
  root_volume_size_in_gb = each.value.root_volume_size_in_gb
  size                   = each.value.size
  max_size                  = each.value.max_size
  min_size                  = each.value.min_size
  cluster_id = module.k8s-cluster-creation[each.value.cluster_name].cluster_id
}

module "k8s-instance-creation" {
  source = "./modules/k8s-instance-creation"
  for_each = { for instance in var.instances : instance.name => instance }
  name = each.value.name
  type              = each.value.type
  image              =  each.value.image
  enable_ipv6 = each.value.enable_ipv6
  enable_dynamic_ip      = each.value.enable_dynamic_ip
  replace_on_type_change = each.value.replace_on_type_change
  routed_ip_enabled      = each.value.routed_ip_enabled
  root_volume_size_in_gb = each.value.root_volume.size_in_gb
  root_volume_type              = each.value.root_volume.type
  boot                  = each.value.root_volume.boot
  delete_on_termination = each.value.root_volume.delete_on_termination
  additional_volume_ids = [for volume_name in each.value.additional_volume_ids : module.k8s-volume-creation.volume_ids[volume_name]]
}


module "k8s-volume-creation" {
  source = "./modules/k8s-volume-creation"
  volumes  = var.volumes
}


module "k8s-db-creation" {
  source = "./modules/k8s-db-creation"
  db_instances = var.db_instances
  dbs = var.dbs
  db_users = var.db_users
  db_permission = var.db_permission
}

