class ProductTable
{
  [string] $ProductCode
  [string] $Clothing
  [string] $Color
  [string] $Size
}

function New-FabricatedProductTable 
{
  [CmdletBinding()]
  param (
  )

  $products = @()

  foreach($clothing in $m_Clothing)
  {
    foreach($color in $m_Colors)
    {
      foreach($size in $m_Sizes)
      {
        $productCode = ConvertTo-ProductCode -Clothing $clothing `
                                             -Color $color `
                                             -Size $size

        $prod = [ProductTable]::new()
        $prod.ProductCode = $productCode
        $prod.Clothing = $clothing
        $prod.Color = $color
        $prod.Size = $size

        $clothSp = ' ' * ($c_MaxClothingLength - $prod.Clothing.Length)
        $colorSp = ' ' * ($c_MaxColorLength - $prod.Color.Length)
        $prodData = "Product $($prod.ProductCode) $($prod.Clothing)$clothSp $($prod.Color)$colorSp $($prod.Size)"
        Write-Verbose "Fabricating $prodData"

        $products += $prod 
      }
    }
  }
  
  return $products 

}
