class Product
{
  [string] $ProductCode
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
  
  $retVal.ProductCode = $retVal.Clothing.Substring(0,3).ToUpper() `
                      + $retVal.Color.Substring(0,3).ToUpper() `
                      + $retVal.Size.Substring(0,3).ToUpper()

  return $retVal 

}
