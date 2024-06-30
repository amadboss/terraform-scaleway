terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

resource "scaleway_rdb_instance" "this-db-instance" {
  for_each = { for db_instance in var.db_instances : db_instance.name => db_instance } 
  
  name           = each.value.name
  node_type      = each.value.node_type
  engine         = each.value.engine
  is_ha_cluster  = each.value.is_ha_cluster
  disable_backup = each.value.disable_backup
  user_name      = each.value.user_name
  password       = each.value.password
  region            = each.value.region
  volume_type       = each.value.volume_type
  volume_size_in_gb = each.value.volume_size_in_gb
}

resource "scaleway_rdb_database" "this-db" {
  for_each = { for db in var.dbs : db.name => db}

  instance_id   = scaleway_rdb_instance.this-db-instance[each.value.instance_name].id
  name          = each.value.name
}

resource "scaleway_rdb_user" "this-db-user" {
  for_each = { for user in var.db_users : user.name => user}
  instance_id = scaleway_rdb_instance.this-db-instance[each.value.instance_name].id
  name        = each.value.name
  password    = each.value.password
  is_admin    = each.value.is_admin
}



resource "scaleway_rdb_privilege" "this-db-perm" {
  for_each = {
    for permission in var.db_permission :
    "${permission.user_name}-${permission.database_name}" => permission
  }

  instance_id   = scaleway_rdb_instance.this-db-instance[each.value.instance_name].id
  user_name     = each.value.user_name
  database_name = each.value.database_name
  permission    = each.value.permission
  depends_on = [scaleway_rdb_user.this-db-user]
}

