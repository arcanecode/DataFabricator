class ProductTable
{
  [int]    $ID
  [string] $ProductCode
  [string] $Clothing
  [string] $Color
  [string] $Size
}

function New-FabricatedProductTable {
  param (
  )

  $products = @()
  $ID = 0

  foreach($clothing in $m_Clothing)
  {
    foreach($color in $m_Colors)
    {
      foreach($size in $m_Sizes)
      {
        $productCode = $clothing.Substring(0,3).ToUpper() `
                     + $color.Substring(0,3).ToUpper() `
                     + $size.Substring(0,3).ToUpper()

        $prod = [ProductTable]::new()
        $prod.ID = $ID++
        $prod.ProductCode = $productCode
        $prod.Clothing = $clothing
        $prod.Color = $color
        $prod.Size = $size
        $products += $prod 
      }
    }
  }
  
  return $products 

}
