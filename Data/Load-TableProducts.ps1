# Load-TableProducts Not sure this is still needed?

$m_ColorCodes = @{}
foreach($c in $m_Colors)
{
  $m_ColorCodes[$($c.Substring(0,3).ToUpper())] = $c
}

$m_ClothingCodes = @{}
foreach($c in $m_Clothing)
{
  $m_ClothingCodes[$($c.Substring(0,3).ToUpper())] = $c
}

$m_SizeCodes = @{}
foreach($s in $m_Sizes)
{
  $m_SizeCodes[$($s.Substring(0,3).ToUpper())] = $s
}
