# OCI CIS OKE Cluster 

To deploy a new OKE Cluster ( VCN-native pod networking for OKE CNI ) as a new Platform (on top of ONE-OE LZ), follow next steps:

1 Click the 'Next' button

[![Open in Code Editor](https://raw.githubusercontent.com/oracle-devrel/oci-code-editor-samples/main/images/open-in-code-editor.png)](https://cloud.oracle.com/?region=home&cs_repo_url=https://github.com/paolajuarezgomez/oke_cis_cluster.git&cs_branch=main&cs_readme_path=INIT.md&cs_open_ce=false)

2. Cloud shell will be open. Change the **KEYS values** for the respective **OCIDs** in oke_cluster/oke/oke.tf file 
Example for deploy the Preprod OKE cluster:
 
  * **default_compartment_id** = "\<CMP-LZP-PLATFORM-PREPROD-KEY>"

  * **vcn_id**="\<VCN-PREPROD-KEY>"
  * **network_compartment_id** = "\<CMP-LZP-PP-NETWORK-KEY>"

  *   **default_ssh_public_key_path** = "Upload your public key and add here the path"

  * **api_endpoint_nsg_ids**="\<NSG-PREPROD-CP-KEY>"
  * **api_endpoint_subnet_id**="\<SN-PP-CP-KEY>"
  * **services_subnet_id**="\<SN-PP-PRIV-LB-KEY>"  
  * **workers_nsg_ids**= "\<NSG-PREPROD-WORKERS-KEY>"
  * **workers_subnet_id** = "\<SN-PP-WORKERS-KEY>"
  * **pods_subnet_id**= "\<SN-PP-PODS-KEY>"
  * **pods_nsg_ids**= "\<NSG-PREPROD-PODS-KEY>"
  
> [!NOTE]
> Make any additional changes needed to customize your cluster. If you have any questions, please refer to the [documentation](https://github.com/oci-landing-zones/terraform-oci-modules-workloads/tree/main/cis-oke).

3. run **chmod +x init.sh**
4. run **./init.sh -c compartment_ocid**

> [!NOTE]
>  To run the detroy operation:
> * run **chmod +x destroy.sh**
> * run **./destroy.sh -c compartment_ocid**


