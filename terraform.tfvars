
#Provider variables
scaleway_secret_key = "<scaleway secret key>"
scaleway_project_id = "<project ID>"
scaleway_access_key = "scaleway access key"



vpc = [
{
  name = "pvn-name"
  region = "fr-par"
  vpc_id = "fr-par/<vpc id>"
},

]


clusters = [
{
    name = "TF-cluster-test"
    delete_additional_resources = false
    cluster_region = "fr-par"
    cni = "cilium"
    cluster_type = "kapsule"
    cluster_version = "1.28.2"
    pvn_name = "pvn-name"
    
    auto_upgrade = {
        enable                        = false
        maintenance_window_day        = "any"
        maintenance_window_start_hour = 0
    }

    autoscaler_config = {
        balance_similar_node_groups      = null
        disable_scale_down               = null
        estimator                        = null
        expander                         = null
        expendable_pods_priority_cutoff  = null
        ignore_daemonsets_utilization    = null
        max_graceful_termination_sec     = null
        scale_down_delay_after_add       = null
        scale_down_unneeded_time         = null
        scale_down_utilization_threshold = null
    }

},

]


pools = [
  {
    name = "TF-cluster-test-pool-1"
    cluster_name              = "TF-cluster-test"
    node_type                 = "PLAY2-NANO"
    pool_zone                 = "fr-par-1"
    autoscaling               = false
    autohealing               = false
    root_volume_size_in_gb    = 20
    size                      = 1
    max_size                  = 1
    min_size                  = 1
  },

]

instances = [

 {
 name = "TF-instance"
 type = "PLAY2-PICO"
 image = "8668cacd-51d6-43b5-88ed-abeda429cdb2"
 enable_ipv6 = true
 enable_dynamic_ip      = false
 replace_on_type_change = false
 routed_ip_enabled      = false
 
 root_volume = {
    boot                  = false
    delete_on_termination = true
    size_in_gb = 20
    type = "b_ssd"
 }
 
 additional_volume_ids = ["TF-add-volume-3", "TF-add-vol-4" ]

 },

]


volumes = [

{
  name = "TF-add-volume-1"
  size_in_gb = 20
  type = "b_ssd"
},
{
  name = "TF-add-vol-2"
  size_in_gb = 20
  type = "b_ssd"
},

]


db_instances = [

{
  name           = "test-db"
  node_type      = "DB-PLAY2-PICO"
  engine         = "PostgreSQL-15"
  is_ha_cluster  = false
  disable_backup = true
  user_name      = "test"
  password       = "test123TEST?"
  region            = "fr-par"
  volume_type       = "bssd"
  volume_size_in_gb = 20
},
]

dbs = [

{
  instance_name = "test-db"
  name = "test-db-db"
},

]

db_users = [
{
  instance_name = "test-db"
  name        = "devtools"
  password    = "user123USER?"
  is_admin    = false
},
]

db_permission = [
{
  instance_name   = "test-db"
  user_name     = "devtools"
  database_name = "test-db-db"
  permission    = "all"
}
]









