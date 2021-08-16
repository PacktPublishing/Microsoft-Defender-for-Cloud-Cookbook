# Install the latest Az modules
Install-Module -Name Az -AllowClobber -Scope CurrentUser

# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy AllSigned

# Install Az.Security module
Install-Module -Name Az.Security -Force
