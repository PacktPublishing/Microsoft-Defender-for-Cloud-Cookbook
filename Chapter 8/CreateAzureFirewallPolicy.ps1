# Define Firewall policy resources

$RGName="Firewall"
$Location="West Europe"
$fwPolicyName="FW-policy"
$netCollName="NetworkCollectionGroup"
$netRuleName="AllowGoogleDNS"
$appCollName="AppCollectionGroup"
$appRuleName="Allow-Packt"

# Create a resource group

New-AzResourceGroup -Name $RGName -Location $Location

# Create a Firewall Policy

$FWpolicy = New-AzFirewallPolicy -Name $fwPolicyName -ResourceGroupName $RGName -Location $Location

# Create Network Rule Collection Group

$nrRCGroup = New-AzFirewallPolicyRuleCollectionGroup -Name $netCollName -Priority 1200 -FirewallPolicyObject $FWpolicy

# Configure a Firewall Policy Network Rule. The Network Rule allows outbound access to two Google DNS servers at port 53 (DNS)

$netRule01 = New-AzFirewallPolicyNetworkRule -name $netRuleName -protocol UDP -sourceaddress 172.17.0.0/24 -destinationaddress 8.8.8.8,8.8.4.4 -destinationport 53

# Configure Network Rule Collection

$netColl01 = New-AzFirewallPolicyFilterRuleCollection -Name Net-coll01 -Priority 1200 -Rule $netRule01 -ActionType "Allow"

# Associate Network Rule Collection Group and Network Rule Collection to a Firewall Policy

Set-AzFirewallPolicyRuleCollectionGroup -Name $nrRCGroup.Name -Priority 1200 -RuleCollection $netColl01 -FirewallPolicyObject $FWpolicy

# Create Application Rule Collection Group

$arRCGroup = New-AzFirewallPolicyRuleCollectionGroup -Name $appCollName -Priority 1300 -FirewallPolicyObject $FWpolicy

# Configure a Firewall Policy Application Rule. The Application Rule allows outbound access to www.packtpub.com

$appRule01 = New-AzFirewallPolicyApplicationRule -Name $appRuleName -SourceAddress 172.17.0.0/24 -Protocol "http:80","https:443" -TargetFqdn www.packtpub.com

# Configure Application Rule Collection

$appColl01 = New-AzFirewallPolicyFilterRuleCollection -Name App-coll01 -Priority 1300 -Rule $appRule01 -ActionType "Allow"

# Associate Application Rule Collection Group and Application Rule Collection to a Firewall Policy

Set-AzFirewallPolicyRuleCollectionGroup -Name $arRCGroup.Name -Priority 1300 -RuleCollection $appColl01 -FirewallPolicyObject $FWpolicy
