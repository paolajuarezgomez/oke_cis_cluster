module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "5.1.8"
  compartment_id = "<CMP-PLATFORM-PREPROD-KEY>"
  # IAM - Policies
  create_iam_autoscaler_policy = "never"
  create_iam_kms_policy = "never"
  create_iam_operator_policy = "never"
  create_iam_worker_policy = "never"
  # Network module - VCN
  vcn_id="<CMP-PLATFORM-PP-KEY>"
  subnets = {
  cp       = { id = "<SN-PP-CP-KEY>" }
  int_lb   = { id = "<SN-PP-PRIV-LB-KEY>" }
  workers  = { id = "<SN-PP-WORKERS-KEY>" }
  pods     = { id = "<SN-PP-PODS-KEY>" }
  }
  nsgs = {
  cp       = { id = "<NSG-PP-CP-KEY>" }
  int_lb   = { id = "<NSG-PP-PRIV-LB-KEY>" }
  workers  = { id = "<NSG-PP-WORKERS-KEY>" }
  pods     = { id = "<NSG-PP-PODS-KEY>" }
  }
  network_compartment_id = "<CMP-LZP-PP-NETWORK-KEY>"
  assign_public_ip_to_control_plane = false
  assign_dns = true
  create_vcn = false
  vcn_dns_label = "oke"
  lockdown_default_seclist = true
  # Network module - security
  allow_node_port_access = true
  allow_pod_internet_access = true
  allow_worker_internet_access = true
  allow_worker_ssh_access = true
  control_plane_allowed_cidrs = ["0.0.0.0/0"]
  control_plane_is_public = false
  enable_waf = false
  load_balancers = "internal"
  preferred_load_balancer = "internal"
  worker_is_public = false
  # Network module - routing
  ig_route_table_id = null # Only include it if create_vcn = false
  nat_route_table_id = null # Only include it if create_vcn = false
  # Cluster module
  create_cluster = true
  cluster_kms_key_id = null
  cluster_name = "oke-quickstart"
  cluster_type = "enhanced"
  cni_type = var.cni_type
  image_signing_keys = []
  kubernetes_version = var.kubernetes_version
  pods_cidr          = "10.244.0.0/16"
  services_cidr      = "10.96.0.0/16"
  use_signed_images  = false
  use_defined_tags = false
  # Workers
  worker_pool_mode = "node-pool"
  worker_pool_size = 1
  worker_image_type = "custom"
  worker_image_id = local.oke_x86_image_id
  worker_cloud_init = [
    {
      content      = <<-EOT
    runcmd:
      - sudo /usr/libexec/oci-growfs -y
    EOT
      content_type = "text/cloud-config",
    }]
  freeform_tags = {
    workers = {
      "cluster" = "oke-pp-quickstart"
    }
  }
  worker_pools = {
    np1 = {
      shape = "VM.Standard.E4.Flex",
      ocpus = 1,
      memory = 8,
      boot_volume_size = 50,
      node_cycling_enabled = false,
      create = true
    }
  }

  # Bastion
  create_bastion = false

  # Operator
  create_operator = false

  providers = {
    oci.home = oci.home
  }
}

resource "oci_containerengine_addon" "oke_cert_manager" {
  addon_name                       = "CertManager"
  cluster_id                       = module.oke.cluster_id
  remove_addon_resources_on_delete = false
  depends_on = [module.oke]
}

resource "oci_containerengine_addon" "oke_metrics_server" {
  addon_name                       = "KubernetesMetricsServer"
  cluster_id                       = module.oke.cluster_id
  remove_addon_resources_on_delete = false
  depends_on = [module.oke, oci_containerengine_addon.oke_cert_manager]
}
