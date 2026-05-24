# Infrastructure Setup Guide

## Overview

This guide documents all the Azure infrastructure resources that have been provisioned for the Cloud-Edge Platform. The infrastructure is organized using modular Terraform configurations across multiple environments (dev, prod, qa, stage).

## Architecture Components

### 1. **Resource Group**
- **Purpose**: Container for all Azure resources
- **Module**: `modules/security/resource-group`
- **Key Attributes**:
  - Name: `rg-cloud-edge-platform-{environment}`
  - Location: Configurable (default: eastus)
  - Tags: Applied to all resources for cost tracking and organization

### 2. **Networking**

#### Virtual Network (VNet)
- **Module**: `modules/networking/vnet`
- **Purpose**: Primary network container for all compute and data resources
- **Configuration**:
  - Address space: 10.0.0.0/16 (default)
  - Location: Configurable

#### Subnets
- **Module**: `modules/networking/subnet`
- **Types**:
  - **AKS Subnet**: For Kubernetes cluster nodes (10.0.1.0/24)
  - **Container Apps Subnet**: For serverless container workloads (10.0.2.0/24)
  - **Additional subnets**: Can be added for other services

#### Network Security Groups (NSG)
- **Module**: `modules/networking/nsg`
- **Purpose**: Firewall rules for inbound/outbound traffic
- **Features**:
  - Default allow rules configured
  - Can be associated with subnets
  - Customizable security rules

### 3. **Security**

#### Key Vault
- **Module**: `modules/security/keyvault`
- **Purpose**: Centralized secrets management
- **Features**:
  - Purge protection enabled
  - Soft delete enabled (90 days)
  - RBAC access control
  - Stores credentials, API keys, connection strings

#### Managed Identities
- **Module**: `modules/security/managed-identity`
- **Purpose**: Service-to-service authentication without shared credentials
- **Identities Created**:
  - AKS Cluster Identity
  - Container Registry Identity
  - Additional identities as needed

### 4. **Storage**

#### Storage Account
- **Module**: `modules/data/storage-account`
- **Purpose**: General-purpose blob, queue, and file storage
- **Features**:
  - HTTPS-only enforcement
  - TLS 1.2 minimum
  - Network rules for security
  - Default: GRS replication

#### PostgreSQL Database
- **Module**: `modules/data/postgres`
- **Purpose**: Relational database for application data
- **Features**:
  - High availability backup (7 days)
  - SSL/TLS encryption enforced
  - Configurable scaling

#### CosmosDB
- **Module**: `modules/data/cosmosdb`
- **Purpose**: NoSQL database for scalable, distributed data
- **Features**:
  - Serverless mode enabled
  - Session-level consistency
  - Multi-region capable

#### Redis Cache
- **Module**: `modules/data/redis`
- **Purpose**: In-memory caching for performance
- **Features**:
  - SSL/TLS enabled
  - Basic tier for development
  - Configurable capacity

### 5. **Compute**

#### Azure Kubernetes Service (AKS)
- **Module**: `modules/compute/aks`
- **Purpose**: Managed Kubernetes cluster for containerized applications
- **Features**:
  - Network plugin: Azure CNI
  - Network policy: Azure
  - Load balancer: Standard SKU
  - Default node pool: 3 nodes (configurable)
  - VM Size: Standard_D2s_v3 (configurable)
  - Integrated with Log Analytics for monitoring

#### Container Registry (ACR)
- **Module**: `modules/compute/acr`
- **Purpose**: Private Docker image registry
- **Features**:
  - Standard SKU for production
  - Admin access disabled (use managed identities)
  - Public network access (configurable)

#### Container Apps Environment
- **Module**: `modules/compute/container-apps`
- **Purpose**: Serverless container execution platform
- **Features**:
  - Subnet-based deployment
  - Integrated with Log Analytics
  - Auto-scaling capabilities

### 6. **Observability & Monitoring**

#### Log Analytics Workspace
- **Module**: `modules/observability/log-analytics`
- **Purpose**: Centralized logging and analytics
- **Features**:
  - Default retention: 30 days
  - PerGB2018 SKU
  - Used by AKS and other services

#### Application Insights
- **Module**: `modules/observability/app-insights`
- **Purpose**: Application performance monitoring
- **Features**:
  - Linked to Log Analytics workspace
  - 90-day retention
  - Instrumentation key for SDK integration

#### Alerts & Action Groups
- **Module**: `modules/observability/alerts`
- **Purpose**: Proactive monitoring and alerting
- **Features**:
  - Email notifications
  - Configurable metric-based alerts
  - Integration with action groups

### 7. **API Management**

#### API Management Service
- **Module**: `modules/api/apim`
- **Purpose**: API gateway and management platform
- **Features**:
  - Developer SKU for non-production
  - API versioning and policies
  - Rate limiting and throttling
  - Developer portal

## Deployment Instructions

### Prerequisites

1. **Azure Subscription**: Active subscription with sufficient quota
2. **Terraform**: Version 1.0 or higher
3. **Azure CLI**: Installed and authenticated (`az login`)
4. **Permissions**: Owner or Contributor role on subscription

### Step 1: Initialize Terraform Backend

```bash
# Navigate to the environment directory
cd environments/dev

# Create or use existing storage account for Terraform state
# Example variables for backend config:
# RESOURCE_GROUP_NAME = "rg-terraform"
# STORAGE_ACCOUNT_NAME = "stterraform"
# CONTAINER_NAME = "tfstate"
# KEY = "dev.tfstate"

terraform init \
  -backend-config="resource_group_name=rg-terraform" \
  -backend-config="storage_account_name=stterraform" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=dev.tfstate"
```

### Step 2: Configure Variables

1. **Edit `terraform.tfvars`**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Update required variables**:
   ```bash
   # Get your Azure Tenant ID
   TENANT_ID=$(az account show --query tenantId -o tsv)
   
   # Get your object ID (for Key Vault access)
   OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)
   
   # Update terraform.tfvars with these values
   ```

### Step 3: Plan & Review

```bash
terraform plan -out=tfplan
```

Review the output to ensure all resources are correct.

### Step 4: Apply Configuration

```bash
terraform apply tfplan
```

This will provision all resources in Azure. Typical deployment time: 20-30 minutes.

### Step 5: Retrieve Outputs

```bash
terraform output

# Or get specific outputs:
terraform output aks_cluster_name
terraform output container_registry_login_server
terraform output key_vault_uri
```

## Resource Naming Convention

All resources follow a consistent naming pattern:

```
{resource-type}-{environment}-{location}
```

Examples:
- Resource Group: `rg-cloud-edge-platform-dev`
- AKS Cluster: `aks-dev`
- Key Vault: `kvdev`
- Storage Account: `stdevcloudedge`

## Cost Optimization Tips

1. **Development Environment**: Use smaller VM sizes (Standard_B2s)
2. **Storage Account**: Use Standard LRS for dev, GRS for prod
3. **API Management**: Use Consumption tier for dev/test
4. **Scale Down**: Reduce AKS node count for non-production
5. **Reserved Instances**: Purchase for production workloads

## Security Best Practices

1. **Key Vault**: Enable purge protection, soft delete
2. **Network**: Use NSGs to restrict traffic
3. **Storage**: Enable firewall, use private endpoints
4. **AKS**: Enable RBAC, pod security policies
5. **Monitoring**: Set up alerts for security events
6. **Secrets**: Rotate regularly, use managed identities

## Disaster Recovery

1. **Backup Strategy**:
   - PostgreSQL: Automated backups (7 days)
   - Storage Account: GRS replication
   - AKS: Regular cluster backups recommended

2. **Failover Plan**:
   - Multi-region deployment available
   - Front Door for traffic management

## Scaling

### Horizontal Scaling
```bash
# Update AKS node count in terraform.tfvars
aks_node_count = 5

terraform apply
```

### Vertical Scaling
```bash
# Update VM size in terraform.tfvars
aks_vm_size = "Standard_D4s_v3"

terraform apply
```

## Monitoring & Logging

1. **AKS Cluster Health**: Monitor via Log Analytics
2. **Application Performance**: Use Application Insights
3. **Billing & Cost**: Use Cost Management + Billing
4. **Alerts**: Configure via alerts module

## Troubleshooting

### Common Issues

1. **Terraform State Lock**:
   ```bash
   terraform force-unlock <LOCK_ID>
   ```

2. **Resource Already Exists**:
   ```bash
   terraform import azure_resource_type.name <resource_id>
   ```

3. **Quota Exceeded**:
   - Increase compute quota in Azure subscription
   - Contact support if limits persist

## Maintenance

### Regular Tasks

- [ ] Review and rotate secrets (monthly)
- [ ] Update Terraform modules (quarterly)
- [ ] Review security policies (quarterly)
- [ ] Cleanup unused resources (monthly)
- [ ] Test disaster recovery (semi-annually)

### Updates

```bash
# Update provider version
terraform init -upgrade

# Plan updates
terraform plan

# Apply updates
terraform apply
```

## Environment Management

The infrastructure supports multiple environments:

```
environments/
├── dev/      # Development
├── qa/       # Quality Assurance
├── stage/    # Staging
└── prod/     # Production
```

To deploy to a different environment:

```bash
cd environments/{environment}
terraform init -backend-config=...
terraform plan
terraform apply
```

## Additional Resources

- [Terraform Azure Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Architecture Center](https://docs.microsoft.com/azure/architecture)
- [AKS Best Practices](https://docs.microsoft.com/azure/aks/best-practices)
- [Azure Security Best Practices](https://docs.microsoft.com/azure/security/fundamentals/best-practices-and-patterns)

## Support

For issues or questions:
1. Check existing documentation
2. Review Terraform logs: `TF_LOG=DEBUG terraform plan`
3. Contact DevOps team
4. Reference GitHub issues
