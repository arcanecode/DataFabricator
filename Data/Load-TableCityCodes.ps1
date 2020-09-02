# Now load a hashtable of codes and cities
$m_CityCodes = @{}

foreach($c in $m_Cities)
{
  $m_CityCodes[$(ConvertTo-CityCode -City $c)] = $c
}
