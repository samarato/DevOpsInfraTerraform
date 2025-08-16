# Step-by-Step Implementation on Huawei Cloud

## Region and Availability Zones
- **Region:** `ap-southeast-2` (AP-Bangkok)
- **Availability Zones:**
  - `ap-southeast-2a` = AC1
  - `ap-southeast-2b` = AC2
  - `ap-southeast-2c` = AZ3 **(preferred)**

### Implementation Steps
```markdown
1. Create EPS (Elastic Public Service)
2. Create OBS (Object Storage Service) for Terraform State Management
3. Create VPC (Virtual Private Cloud)
4. Create ELB (Elastic Load Balancer)
5. Create DNS. 
6. Create NAT (Network Address Tranation)
7. Create SWR (Software Repository). 
8. Create CCE (Cloud Container Engine)
   8.1 Create CCE Cluster
   8.2 Create SFS Turbo (Server File System)
   8.3 Create Node Pools
   8.4 Create Namespaces
   8.5 Create ConfigMaps
   8.6 Create Workloads
   8.7 Create SCM (Source Code Management)
   8.8 Create Ingress
9. Create LTS (Log Tank Service)
10. Create Cloud Backup
11. For Production: Create WAF (Web Application Firewall)
12. Create O&M (Operations & Maintenance)
```

---
## Generate Graph with Terraform and Dot

### Generate Graph with Terraform
To visualize your infrastructure, use the following command to generate a graph:

```bash
terraform graph > graph.dot
```

### Visualize the Graph
#### Install Graphviz
- **For Ubuntu:**
  ```bash
  sudo apt-get install graphviz
  ```
- **For macOS:**
  ```bash
  brew install graphviz
  ```

#### Convert DOT File to PNG
Run the following command to convert the generated `graph.dot` file to a PNG image:

```bash
dot -Tpng graph.dot -o graph.png
```

![Infrastructure Graph](./envs/infra/graph.png)

---

## Using Terraform with Huawei Cloud Provider

### Required Provider Configuration
```hcl
terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.68.1"
    }
  }
}
```

### IPv4 CIDR Block
- **CIDR Block:** `10.60.88.0/21` (Total: 2,041 IPs)
- For each environment, use:
```
  - **Dev:**      `10.60.88.1 - 10.60.89.254` (Total: 510) CIDR 10.60.88.0/23
  - **UAT:**      `10.60.90.1 - 10.60.91.254` (Total: 510) CIDR 10.60.90.0/23
  - **Prod:**     `10.60.92.1 - 10.60.93.254` (Total: 510) CIDR 10.60.92.0/23
  - **Infra:**    `10.60.94.1 - 10.60.94.254` (Total: 254) CIDR 10.60.94.0/24
  - **Pre-Prod:** `10.60.95.1 - 10.60.95.254` (Total: 254) CIDR 10.60.95.0/24
```
<span style="color: red;">
### Note
This version of the Huawei Cloud provider does not support running Terraform on Windows OS.
</span>

---

# Setting Up Environment Variables

To manage your GitHub Personal Access Token (PAT) securely, set it as an environment variable. Follow the steps below:

1. Go to: `https://github.com/settings/tokens` and "Generate new token (classic)"

### Steps to Set Environment Variables
Environment variables should follow the format `TF_VAR_<name>`. Use a `.env` file or set them directly in your terminal.

#### Example of Setting Variables
```bash
# Set your environment variables
export TF_VAR_github_token="your_github_token"
export TF_VAR_access_key="your_huawei_access_key"
export TF_VAR_secret_key="your_huawei_secret_key"
export AWS_ACCESS_KEY_ID="your_huawei_access_key"
export AWS_SECRET_ACCESS_KEY="your_huawei_secret_key"
```

#### Windows
To set environment variables persistently:
```cmd
setx TF_VAR_github_token "your_github_token"
setx TF_VAR_access_key "your_huawei_access_key"
setx TF_VAR_secret_key "your_huawei_secret_key"
```

For PowerShell:
```powershell
[System.Environment]::SetEnvironmentVariable("TF_VAR_github_token", "your_github_token", "User")
[System.Environment]::SetEnvironmentVariable("TF_VAR_access_key", "your_huawei_access_key", "User")
[System.Environment]::SetEnvironmentVariable("TF_VAR_secret_key", "your_huawei_secret_key", "User")
```

#### Linux & macOS
Add the following to your `.bashrc` or `.bash_profile`:
```bash
echo 'export TF_VAR_github_token="your_github_token"' >> ~/.bashrc
echo 'export TF_VAR_access_key="your_huawei_access_key"' >> ~/.bashrc
echo 'export TF_VAR_secret_key="your_huawei_secret_key"' >> ~/.bashrc
source ~/.bashrc
```

### Verify Environment Variables
- **For bash:**
  ```bash
  echo $TF_VAR_github_token
  ```
- **For PowerShell:**
  ```powershell
  $env:TF_VAR_github_token
  ```

---

## Setting Up Provider

### Huawei Cloud Documentation
- [Huawei Cloud Terraform Provider](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs)
- [Examples](https://github.com/huaweicloud/terraform-provider-huaweicloud/tree/master/examples)

### Provider Configuration
```hcl
provider "huaweicloud" {
  region       = var.cloud_region_name
  project_name = var.cloud_project_name
  access_key   = var.access_key
  secret_key   = var.secret_key
}
```

---

## Directory Structure Breakdown

- **`DevOpsInfraTerraform/`**
- **`envs/`**: Environment-specific folders (e.g., dev, uat, prd).
  - **`infra/`**: Infrastructure for testing
    - **`main.tf`**: Main Terraform configuration file
  - **`dev/`**: Development environment
  - **`uat/`**: UAT environment
  - **`prd/`**: Production environment

- **`modules/`**: Contains reusable Terraform modules.
  - **`github_repo/`**: Module for managing GitHub repositories.
  - **`huawei/`**: Module for managing Huawei Cloud resources.
    - **`eip/`**: Elastic IP Address
    - **`elb/`**: Elastic Load Balancer
    - **`obs/`**: Object Storage Service
    - **`vpc/`**: Virtual Private Cloud

- **`script/`**: Contains scripts (.ps1, .sh).
- **`test/`**: Contains test scripts.
- **`readme.md`**: This README file.

---

## How to Use

1. **Clone the Repository**
   ```bash
   git clone https://github.com/samarato/DevOpsInfraTerraform.git
   ```

2. **Navigate to the Environment Directory**
   ```bash
   cd DevOpsInfraTerraform/envs/dev
   ```

3. **Terraform Commands**
   ```bash
   # Initialize Terraform
   terraform init

   # Validate the configuration
   terraform validate

   # Generate an execution plan
   terraform plan

   # Apply the plan to create resources
   terraform apply

   # Destroy resources when no longer needed
   terraform destroy
   ```

---

## Use Terratest for Automated Testing

### Installation & Documentation
- [Terratest Quick Start](https://terratest.gruntwork.io/docs/getting-started/quick-start/)

#### Install Terratest Package
```bash
go get github.com/gruntwork-io/terratest/modules/terraform
```

#### Verify Installation
```bash
# Check if Terratest is installed correctly
```

#### Run Tests
To execute your tests:
```bash
go test -v -run ../../modules/huawei/obs -timeout 30m
```

To run tests in all subdirectories:
```bash
go test -v ./...
```

#### Expected Test Output
```log
--- PASS: TestOBSTerraform (0.42s)
--- PASS: TestTerraformHelloWorldExample (0.42s)
PASS
ok      modules/modules 2.078s
```

---
