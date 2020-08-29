class Product
{
  [int]    $ID
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
        $prod = [Product]::new()
        $prod.ID = $ID++
        $prod.Clothing = $clothing
        $prod.Color = $color
        $prod.Size = $size
        $products += $prod 
      }
    }
  }
  
  return $products 

}
