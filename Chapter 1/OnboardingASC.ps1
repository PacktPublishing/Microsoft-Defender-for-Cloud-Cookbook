# Register your subscriptions to the Security Center Resource Provider
Set-AzContext -Subscription "subscription_ID"
Register-AzResourceProvider -ProviderNamespace 'Microsoft.Security'

# Define Log Analytics workspace
Set-AzSecurityWorkspaceSetting -Name "default" -Scope "/subscriptions/<subscription_ID>" -WorkspaceId "/subscriptions/<subscription_ID>/resourceGroups/<ResourceGroupName>/providers/Microsoft.OperationalInsights/workspaces/<WorkspaceName>"

#	Auto-provision Log Analytics agent
Set-AzContext -Subscription "<subscription_ID>"
Set-AzSecurityAutoProvisioningSetting -Name "default" -EnableAutoProvision

#	Assign the default Security Center policy initiative
# Replace "subscription_ID" with an ID of an Azure Subscription and "WorkspaceID" with the Log Analytics Workspace ID.
Register-AzResourceProvider -ProviderNamespace 'Microsoft.PolicyInsights'
$Policy = Get-AzPolicySetDefinition | where {$_.Properties.displayName -EQ 'Azure Security Benchmark'} New-AzPolicyAssignment -Name 'ASC Default <subscription_ID>' -DisplayName 'Security Center Default <subscription ID>' -PolicySetDefinition $Policy -Scope '/subscriptions/<subscription_ID>'
