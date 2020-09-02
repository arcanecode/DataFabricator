class Product
{
  [string] $ProductCode
  [string] $Clothing
  [string] $Color
  [string] $Size
}

function New-FabricatedProductRecord {
  param (
          [int] $RecordCount = 1
        )

  $retVal = @()

  for($i = 0; $i -lt $RecordCount; $i++)
  {
    $product = [Product]::new()
    $product.Clothing = $m_Clothing | Get-Random
    $product.Color = $m_Colors | Get-Random
    $product.Size = $m_Sizes | Get-Random
    
    $product.ProductCode = $product.Clothing.Substring(0,3).ToUpper() `
                        + $product.Color.Substring(0,3).ToUpper() `
                        + $product.Size.Substring(0,3).ToUpper()
    $retVal += $product
  }
  return $retVal 

}
