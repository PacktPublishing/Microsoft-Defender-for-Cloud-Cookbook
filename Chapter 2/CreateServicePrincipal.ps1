# NOTE: This script is generated in Azure Security Center, during the process of Connecting AWS Account
# STEP 2: Azure Arc Configuration - Create Service Principal client ID and secret
# NOTE: Substitute <Subscription_ID> in the script with the Azure Subscriuption ID
# Azure Cloud Shell

# Choose the subscription
Set-AzContext -SubscriptionId  "<Subscription_ID>"

# Register Azure resource providers
# - Microsoft.HybridCompute
# - Microsoft.GuestConfiguration
Register-AzResourceProvider -ProviderNamespace Microsoft.HybridCompute
Register-AzResourceProvider -ProviderNamespace Microsoft.GuestConfiguration

# Create a service principal
$sp = New-AzADServicePrincipal -DisplayName "ASC-Arc-for-servers" -Role "Azure Connected Machine Onboarding"

# Create a secret
$sp.ApplicationId

# Copy the Guid of the application Id
$credential = New-Object pscredential -ArgumentList "temp", $sp.Secret
$credential.GetNetworkCredential().password
