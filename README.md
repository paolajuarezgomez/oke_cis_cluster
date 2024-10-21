# OCI OKE Cluster 

To deploy a new OKE Cluster ( VCN-native pod networking for OKE CNI ) as a new Platform (on top of ONE-OE LZ), follow next steps:

1 Click the 'Next' button

[![Open in Code Editor](https://raw.githubusercontent.com/oracle-devrel/oci-code-editor-samples/main/images/open-in-code-editor.png)](https://cloud.oracle.com/?region=home&cs_repo_url=https://github.com/paolajuarezgomez/oke_cis_cluster.git&cs_branch=main&cs_readme_path=INIT.md&cs_open_ce=false)

2. Cloud shell will be open. Change the **KEYS values** for the respective **OCIDs** in oke_cluster/oke/oke.tf file 
Example for deploy the Preprod OKE cluster:
 
  * **compartment_id** = "\<CMP-LZP-PLATFORM-PREPROD-KEY>"

  * **vcn_id**="\<VCN-PREPROD-KEY>"

  * **network_compartment_id** = "\<CMP-LZP-PP-NETWORK-KEY>"

  * **subnets** = {
  cp       = { id = "\<SN-PP-CP-KEY>" }
  int_lb   = { id = "\<SN-PP-PRIV-LB-KEY>" }
  workers  = { id = "\<SN-PP-WORKERS-KEY>" }
  pods     = { id = "\<SN-PP-PODS-KEY>"}
  }

  * **nsgs** = {
  cp       = { id = "\<NSG-PREPROD-CP-KEY>" }
  int_lb   = { id = "\<NSG-PREPROD-PRIV-LB-KEY>" }
  workers  = { id = "\<NSG-PREPROD-WORKERS-KEY>" }
  pods     = { id = "\<NSG-PREPROD-PODS-KEY>" }
  }

> [!NOTE]
> Make any additional changes needed to customize your cluster. If you have any questions, please refer to the documentation.

3. run **chmod +x init.sh**
4. run **./init.sh -c compartment_ocid**


