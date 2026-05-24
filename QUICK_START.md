# Quick Start Guide - Infrastructure Deployment

## 5-Minute Setup

### Prerequisites
```bash
# 1. Ensure tools are installed
terraform --version      # v1.0+
az --version             # Latest
git --version           # Latest

# 2. Authenticate to Azure
az login
az account show
```

### Quick Deploy
```bash
# 1. Navigate to dev environment
cd environments/dev

# 2. Initialize (first time only)
terraform init \
  -backend-config="resource_group_name=rg-terraform" \
  -backend-config="storage_account_name=stterraform" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=dev.tfstate"

# 3. Get your Azure IDs
TENANT_ID=$(az account show --query tenantId -o tsv)
OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)

# 4. Update terraform.tfvars with your IDs
# Edit: tenant_id and current_user_object_id

# 5. Plan and apply
terraform plan -out=tfplan
terraform apply tfplan
```

## Essential Commands

```bash
# List all resources
terraform state list

# Show specific output
terraform output aks_cluster_name

# Refresh state
terraform refresh

# Destroy all (dev only!)
terraform destroy

# Target specific resource
terraform apply -target=module.aks
```

## Important Outputs After Deployment

```bash
# Get AKS credentials
az aks get-credentials \
  --resource-group rg-cloud-edge-platform-dev \
  --name $(terraform output -raw aks_cluster_name)

# Access Container Registry
az acr login --name $(terraform output -raw container_registry_name)

# Get Key Vault URI
terraform output key_vault_uri

# List all outputs
terraform output
```

## Common Issues

### Issue: Backend config failed
**Solution**: Ensure storage account exists or update backend values

### Issue: Azure quota exceeded
**Solution**: Request quota increase via Azure Portal

### Issue: Terraform state locked
**Solution**: 
```bash
terraform force-unlock <LOCK_ID>
```

## Resource Sizes

```yaml
Development:
  AKS Nodes: 3 x Standard_D2s_v3
  Storage: Standard GRS
  Database: Basic tier
  Total Est. Monthly Cost: ~$500-700

Production:
  AKS Nodes: 5+ x Standard_D4s_v3
  Storage: Premium GRS
  Database: Standard tier
  Total Est. Monthly Cost: ~$1500-2000+
```

## Scaling Resources

```bash
# Increase AKS nodes
sed -i 's/aks_node_count = 3/aks_node_count = 5/' terraform.tfvars
terraform apply

# Change node size
sed -i 's/aks_vm_size = "Standard_D2s_v3"/aks_vm_size = "Standard_D4s_v3"/' terraform.tfvars
terraform apply
```

## Post-Deployment Steps

1. **Configure kubectl**
```bash
az aks get-credentials --resource-group rg-cloud-edge-platform-dev --name aks-dev
kubectl get nodes
```

2. **Test Container Registry**
```bash
az acr login --name acrdev
docker pull mcr.microsoft.com/hello-world
docker tag mcr.microsoft.com/hello-world:latest acrdev.azurecr.io/hello-world:latest
docker push acrdev.azurecr.io/hello-world:latest
```

3. **Setup Key Vault Access**
```bash
KEYVAULT_URL=$(terraform output -raw key_vault_uri)
az keyvault secret set --vault-name kvdev --name test-secret --value "test-value"
```

## Environment Variables

```bash
# Set for quick access
export RG_NAME="rg-cloud-edge-platform-dev"
export AKS_CLUSTER=$(terraform output -raw aks_cluster_name)
export ACR_NAME=$(terraform output -raw container_registry_name)
export KEYVAULT=$(terraform output -raw key_vault_id)
```

## Monitoring

```bash
# View AKS logs
az aks show-diagnostics --resource-group $RG_NAME --name $AKS_CLUSTER

# Check pod logs
kubectl logs <pod-name> -n <namespace>

# View resource usage
kubectl top nodes
kubectl top pods
```

## Documentation Links

- **Full Setup Guide**: [INFRASTRUCTURE_SETUP.md](./INFRASTRUCTURE_SETUP.md)
- **Resource Checklist**: [RESOURCE_CHECKLIST.md](./RESOURCE_CHECKLIST.md)
- **Terraform Docs**: https://registry.terraform.io/providers/hashicorp/azurerm/latest
- **AKS Docs**: https://docs.microsoft.com/azure/aks/
- **Azure Docs**: https://docs.microsoft.com/azure/

## Support

- Check Terraform logs: `export TF_LOG=DEBUG`
- Run plan first: `terraform plan` before `terraform apply`
- Always use version control: `git commit` before changes
- Read error messages carefully - they're usually helpful!

---

**Remember**: Always run `terraform plan` before `terraform apply`!
