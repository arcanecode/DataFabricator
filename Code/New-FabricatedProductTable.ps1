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

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  $products = @()
  $i = 0

  foreach($clothing in $m_Clothing)
  {
    foreach($color in $m_Colors)
    {
      foreach($size in $m_Sizes)
      {
        $productCode = ConvertTo-ProductCode -Clothing $clothing `
                                             -Color $color `
                                             -Size $size `
                                             -Verbose:$false

        $prod = [ProductTable]::new()
        $prod.ProductCode = $productCode
        $prod.Clothing = $clothing
        $prod.Color = $color
        $prod.Size = $size

        $clothSp = ' ' * ($c_MaxClothingLength - $prod.Clothing.Length)
        $colorSp = ' ' * ($c_MaxColorLength - $prod.Color.Length)
        $prodData = "Product $($prod.ProductCode) $($prod.Clothing)$clothSp $($prod.Color)$colorSp $($prod.Size)"
        Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $prodData"
        
        $products += $prod 
        $i++
      }
    }
  }
  
 # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $products 

}
