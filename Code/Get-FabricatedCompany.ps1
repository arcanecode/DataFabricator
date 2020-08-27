function Get-FabricatedCompany()
{
  [CmdletBinding()]
  param ()

  $coFirst = $m_CompanyFirst | Get-Random
  $coIndustry = $m_CompanyIndustry | Get-Random
  $coLast = $m_CompanyLast | Get-Random 

  $retVal = "$coFirst $coIndustry $coLast"

  return $retVal 

}