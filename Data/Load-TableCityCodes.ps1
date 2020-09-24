# Now load a hashtable of codes and cities
$m_CityCodesUS = @{}

foreach($c in $m_CitiesUS)
{
  $m_CityCodesUS[$(ConvertTo-CityCode -City $c)] = $c
}

# Note since this is a hash table, we won't be calculating max length
# constants, instead you can use the ones for the
# source cities table $c_MaxCitiesLength

$m_CityCodesUK = @{}

foreach($c in $m_CitiesUK)
{
  $m_CityCodesUK[$(ConvertTo-CityCode -City $c)] = $c
}
