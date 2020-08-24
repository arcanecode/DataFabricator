# Demonstrates how to use the DataFabricator Module

# First, remove the module from memory if it's loaded. This is needed
# if you are making changes and want to test those changes.

# If the module is not in memory, then suppress the error and silently continue
Remove-Module DataFabricator -ErrorAction SilentlyContinue

Import-Module .\DataFabricator -Verbose

Get-FirstName
