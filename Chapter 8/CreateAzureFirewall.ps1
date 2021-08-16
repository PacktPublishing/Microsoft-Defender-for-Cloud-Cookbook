# Define resources: Resource group, location (region), virtual network, subnets, IP address and firewall names

$RGName="Firewall"
$Location="West Europe"
$VNetName="PacktPublishing"
$ProdSubnetName="Production"
$FWSubnetName="AzureFirewallSubnet"
$FWpipName="PacktFirewall-PIP"
$FWname="PackFirewall"

# Create a resource group

New-AzResourceGroup -Name $RGName -Location $Location

# Create subnets

$ProdSubnet=New-AzVirtualNetworkSubnetConfig -Name $ProdSubnetName -AddressPrefix 172.16.0.0/24
$FWSubnet=New-AzVirtualNetworkSubnetConfig -Name ‘ $FWSubnetName -AddressPrefix 172.16.1.0/26

# Create virtual network containing two subnets

$VNet=New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RGName -Location $Location -AddressPrefix 172.16.0.0/16 -Subnet $ProdSubnet,$FWSubnet

# Create Public IP address for a firewall

$FWpip = New-AzPublicIpAddress -Name $FWpipName -ResourceGroupName $RGName -Location $Location -AllocationMethod Static -Sku Standard

# Create firewall

$Azfw = New-AzFirewall -Name $FWname -ResourceGroupName $RGName -Location $Location -VirtualNetworkName $VNetName -PublicIpName $FWpipName
