class Product
{
  [string] $Clothing
  [string] $Color
  [string] $Size
}

function Get-FabricatedProduct {
  param (
  )

  $retVal = [Product]::new()
  $retVal.Clothing = $m_Clothing | Get-Random
  $retVal.Color = $m_Colors | Get-Random
  $retVal.Size = $m_Sizes | Get-Random
  
  return $retVal 

}
