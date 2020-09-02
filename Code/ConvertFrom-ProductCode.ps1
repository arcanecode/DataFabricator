class Product
{
  [string] $Clothing
  [string] $Color
  [string] $Size
}

function ConvertFrom-ProductCode()
{

  [CmdletBinding()]
  param(
         [string] $ProductCode
       )

  $clothingCode = $ProductCode.Substring(0, 3)
  $colorCode = $ProductCode.Substring(3, 3)  
  $sizeCode = $ProductCode.Substring(6, 3)

  $retVal = [Product]::new()

  $retVal.Clothing = $m_ClothingCodes[$clothingCode]
  $retVal.Color = $m_ColorCodes[$colorCode]
  $retVal.Size = $m_SizeCodes[$sizeCode]

  return $retVal 

}