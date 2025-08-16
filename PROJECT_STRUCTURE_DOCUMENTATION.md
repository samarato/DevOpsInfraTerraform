# Huawei Cloud Infrastructure Terraform Project Documentation
## For Junior DevOps Engineers

---

# 1. Project Overview

## What is this project?
This is an **Infrastructure as Code (IaC)** project using **Terraform** to manage cloud infrastructure on **Huawei Cloud**. It automates the creation and management of cloud resources like networks, containers, storage, and more.

## Key Technologies
- **Terraform**: Infrastructure automation tool
- **Huawei Cloud**: Cloud provider (similar to AWS/Azure)
- **Git/GitHub**: Version control
- **Go/Terratest**: Testing framework

---

# 2. Project Architecture

## Directory Structure Explained

```
DevOpsInfraTerraform/
│
├── 📁 envs/                    # Environment configurations
│   ├── dev/                    # Development environment
│   ├── infra/                  # Infrastructure testing
│   └── templates/              # Reusable templates
│
├── 📁 modules/                 # Reusable Terraform modules
│   ├── github_repo/            # GitHub repository management
│   ├── huawei/                 # Huawei Cloud resource modules
│   └── kubernetes/             # Kubernetes configurations
│
├── 📁 scripts/                 # Automation scripts
│   ├── push.ps1                # PowerShell script for Git
│   └── push_code.sh            # Bash script for Git
│
├── 📁 test/                    # Testing files
│   └── modules/                # Module tests (Go/Terratest)
│
├── 📁 github/                  # GitHub provider configs
│
├── README.md                   # Main documentation
└── Security.md                 # Security guidelines
```

---

# 3. Core Components Deep Dive

## 3.1 Environments (`/envs`)

### Purpose
Separate configurations for different deployment stages

### Structure of Each Environment
```
envs/dev/
├── backend.tf          # State storage configuration
├── datasource.tf       # Data lookups from cloud
├── local.tf            # Local variables
├── main.tf             # Main resource definitions
├── output.tf           # Output values
├── provider.tf         # Provider configuration
├── terraform.auto.tfvars # Auto-loaded variables
└── variables.tf        # Variable definitions
```

### Environment Types
- **dev**: Development (testing new features)
- **uat**: User Acceptance Testing
- **prod**: Production (live systems)
- **infra**: Infrastructure testing
- **pre-prod**: Pre-production staging

### IP Address Allocation
```
Base CIDR: 10.60.88.0/21 (2,041 IPs total)

Dev:      10.60.88.0/23  (510 IPs)
UAT:      10.60.90.0/23  (510 IPs)
Prod:     10.60.92.0/23  (510 IPs)
Infra:    10.60.94.0/24  (254 IPs)
Pre-Prod: 10.60.95.0/24  (254 IPs)
```

---

## 3.2 Modules (`/modules`)

### What are Modules?
Reusable building blocks for infrastructure - write once, use many times!

### Module Categories

#### A. GitHub Modules (`/modules/github_repo`)
- Manages GitHub repositories programmatically
- Creates repos, sets permissions, manages webhooks

#### B. Huawei Cloud Modules (`/modules/huawei/`)

**Core Infrastructure Modules:**

| Module | Full Name | Purpose |
|--------|-----------|---------|
| **vpc** | Virtual Private Cloud | Creates isolated networks |
| **eip** | Elastic IP | Public IP addresses |
| **nat** | Network Address Translation | Internet gateway for private resources |
| **elb** | Elastic Load Balancer | Distributes traffic across servers |
| **dns** | Domain Name System | Maps domain names to IPs |
| **dns_zone** | DNS Zone | Manages DNS records |

**Container & Kubernetes Modules:**

| Module | Full Name | Purpose |
|--------|-----------|---------|
| **cce_turbo** | Cloud Container Engine | Kubernetes cluster management |
| **cce_nodepool** | CCE Node Pool | Groups of worker nodes |
| **cce_node_add** | CCE Node Addition | Add nodes to cluster |
| **cce_pvc** | Persistent Volume Claim | Storage for containers |
| **swr** | Software Repository | Container image registry |

**Storage Modules:**

| Module | Full Name | Purpose |
|--------|-----------|---------|
| **obs** | Object Storage Service | S3-like storage |
| **obs_state** | OBS for Terraform State | Stores Terraform state files |
| **sfs_turbo** | Scalable File Service | Shared file storage |

**Security & Management:**

| Module | Full Name | Purpose |
|--------|-----------|---------|
| **eps** | Enterprise Project Service | Project organization |
| **dew** | Data Encryption Workshop | Key management & encryption |

### Module Structure Pattern
Every module follows this structure:
```
module_name/
├── main.tf         # Main resource definitions
├── variables.tf    # Input variables
├── output.tf       # Output values
├── provider.tf     # Provider requirements
├── data.tf         # Data sources
└── locals.tf       # Local variables
```

---

# 4. Infrastructure Deployment Flow

## Step-by-Step Process

```mermaid
graph TD
    A[1. EPS - Project Setup] --> B[2. OBS - State Storage]
    B --> C[3. VPC - Network]
    C --> D[4. ELB - Load Balancer]
    D --> E[5. DNS - Domain Setup]
    E --> F[6. NAT - Internet Gateway]
    F --> G[7. SWR - Container Registry]
    G --> H[8. CCE - Kubernetes Cluster]
    H --> I[8.1 SFS Turbo - File Storage]
    I --> J[8.2 Node Pools]
    J --> K[8.3 Namespaces]
    K --> L[8.4 ConfigMaps]
    L --> M[8.5 Workloads]
    M --> N[8.6 SCM]
    N --> O[8.7 Ingress]
    O --> P[9. LTS - Logging]
    P --> Q[10. Cloud Backup]
    Q --> R[11. WAF - Web Security]
    R --> S[12. O&M - Operations]
```

---

# 5. Working with the Project

## 5.1 Initial Setup

### Prerequisites
1. **Install Terraform** (v1.0+)
2. **Install Git**
3. **Huawei Cloud Account**
4. **GitHub Account** (for repo management)

### Environment Variables Setup
```bash
# Linux/Mac
export TF_VAR_github_token="your_token"
export TF_VAR_access_key="huawei_access_key"
export TF_VAR_secret_key="huawei_secret_key"

# Windows PowerShell
$env:TF_VAR_github_token="your_token"
$env:TF_VAR_access_key="huawei_access_key"
$env:TF_VAR_secret_key="huawei_secret_key"
```

## 5.2 Basic Terraform Commands

```bash
# 1. Navigate to environment
cd envs/dev

# 2. Initialize Terraform (download providers)
terraform init

# 3. Validate configuration syntax
terraform validate

# 4. Preview changes (dry run)
terraform plan

# 5. Apply changes (create resources)
terraform apply

# 6. Destroy resources (cleanup)
terraform destroy
```

## 5.3 Terraform State Management

### What is State?
- Terraform tracks what resources it created in a "state file"
- Critical for knowing what exists and what needs changing

### Remote State Storage
```hcl
# backend.tf - Stores state in OBS (cloud storage)
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "dev/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
```

---

# 6. Best Practices & Patterns

## 6.1 Code Organization

### Variable Management
```hcl
# variables.tf - Define inputs
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# terraform.auto.tfvars - Set values
environment = "development"
region = "ap-southeast-2"
```

### Output Values
```hcl
# output.tf - Export values for other modules
output "vpc_id" {
  value = module.vpc.id
  description = "VPC identifier"
}
```

## 6.2 Module Usage Pattern

```hcl
# Using a module in main.tf
module "vpc" {
  source = "../../modules/huawei/vpc"
  
  vpc = {
    environment    = var.environment
    cidr          = "10.60.88.0/23"
    eps_project_id = local.eps_current_id
  }
}
```

## 6.3 Resource Tagging Strategy

```hcl
# Consistent tagging for resource management
tags = {
  Environment = var.environment
  ManagedBy   = "Terraform"
  Project     = "Terraform"
  Team        = "DevOps"
}
```

---

# 7. Testing Infrastructure

## 7.1 Terratest (Go Testing)

### Test Structure
```go
// test/modules/hcs_obs_test.go
func TestOBSTerraform(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../../modules/huawei/obs",
    }
    
    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)
}
```

### Running Tests
```bash
# Run specific test
go test -v -run TestOBSTerraform -timeout 30m

# Run all tests
go test -v ./...
```

## 7.2 Validation Techniques

1. **Syntax Validation**: `terraform validate`
2. **Format Check**: `terraform fmt -check`
3. **Plan Review**: `terraform plan`
4. **Graph Visualization**: `terraform graph | dot -Tpng > graph.png`

---

# 8. CI/CD Integration

## 8.1 Git Workflow

### Scripts Provided
- **push.ps1**: Windows PowerShell automation
- **push_code.sh**: Linux/Mac bash automation

### Typical Workflow
```bash
# 1. Make changes
# 2. Test locally
terraform plan

# 3. Commit changes
git add .
git commit -m "Add new VPC module"

# 4. Push to repository
git push origin feature-branch

# 5. Create Pull Request
# 6. Automated tests run
# 7. Merge to main
```

---

# 9. Security Considerations

## 9.1 Secrets Management

### Never Commit Secrets!
❌ **BAD**: Hardcoding in files
```hcl
access_key = "AKIAIOSFODNN7EXAMPLE"  # NEVER DO THIS!
```

✅ **GOOD**: Using environment variables
```hcl
access_key = var.access_key  # Read from TF_VAR_access_key
```

## 9.2 Access Control

### Enterprise Project Service (EPS)
- Isolates resources by project
- Controls access permissions
- Enables cost tracking

### Network Security
- Private subnets for databases
- Public subnets only for load balancers
- Security groups as firewalls

---

# 10. Troubleshooting Guide

## Common Issues & Solutions

### Issue 1: Provider Authentication Failed
```
Error: Authentication failed
```
**Solution**: Check environment variables are set correctly

### Issue 2: Resource Already Exists
```
Error: Resource already exists
```
**Solution**: Import existing resource or use different name
```bash
terraform import module.vpc.huaweicloud_vpc.main vpc-id-123
```

### Issue 3: State Lock
```
Error: State locked
```
**Solution**: Remove lock if safe
```bash
terraform force-unlock lock-id-abc123
```

---

# 11. Learning Path for Junior DevOps

## Phase 1: Basics (Week 1-2)
1. Understand Terraform basics
2. Learn HCL syntax
3. Practice with simple resources (VPC, Subnet)
4. Understand state management

## Phase 2: Modules (Week 3-4)
1. Use existing modules
2. Modify module parameters
3. Create simple custom module
4. Understand module versioning

## Phase 3: Environments (Week 5-6)
1. Deploy to dev environment
2. Understand environment differences
3. Practice with terraform workspaces
4. Learn about remote state

## Phase 4: Advanced (Week 7-8)
1. Write Terratest tests
2. Implement CI/CD pipeline
3. Handle complex dependencies
4. Performance optimization

---

# 12. Quick Reference

## Essential Commands Cheatsheet

```bash
# Initialize
terraform init
terraform init -upgrade

# Planning
terraform plan
terraform plan -out=tfplan
terraform plan -target=module.vpc

# Applying
terraform apply
terraform apply -auto-approve
terraform apply tfplan

# State Management
terraform state list
terraform state show module.vpc
terraform refresh

# Debugging
terraform console
terraform output
terraform graph

# Cleanup
terraform destroy
terraform destroy -target=module.vpc
```

## Resource Naming Convention
```
{environment}-{region}-{service}-{component}-{index}

Examples:
dev-apse2-vpc-main-01
prod-apse2-cce-cluster-01
infra-apse2-obs-state-01
```

---

# 13. Additional Resources

## Documentation Links
- [Terraform Documentation](https://www.terraform.io/docs)
- [Huawei Cloud Provider](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs)
- [Terratest Framework](https://terratest.gruntwork.io)

## Project Specific
- Region: `ap-southeast-2` (Bangkok)
- Provider Version: `>= 1.68.1`
- Terraform Version: `>= 1.0`

---

# Summary for Slide Creation

When creating slides, focus on:

1. **Visual Architecture Diagram**: Show the infrastructure layers
2. **Module Relationships**: How modules connect
3. **Environment Progression**: Dev → UAT → Prod flow
4. **Security Layers**: Network isolation, encryption, access control
5. **Automation Benefits**: Time saved, consistency, reliability
6. **Team Collaboration**: Git workflow, code reviews, testing

Key Messages:
- Infrastructure as Code ensures consistency
- Modular design enables reusability
- Multi-environment support for safe deployments
- Automated testing reduces errors
- Version control tracks all changes

This documentation provides a complete understanding of the project structure, making it easy for junior DevOps engineers to navigate and contribute to the infrastructure codebase.