Describe "ConvertFrom-CityStateCode Tests" {

  BeforeAll{
    $module = 'DataFabricator'
    $function = 'ConvertFrom-CityStateCode'
    $here = $PSScriptRoot

  }

  Context "<module> <function> Tests" {
    It "<function> Default CityCode of ALAARONSBURGCDP" {
      $(ConvertFrom-CityStateCode -CityStateCode "ALAARONSBURGCDP").State | Should -Be 'AL'
      $(ConvertFrom-CityStateCode -CityStateCode "ALAARONSBURGCDP").City  | Should -Be 'Aaronsburg CDP'
    }

    It "<function> US CityCode of ALAARONSBURGCDP" {
      $(ConvertFrom-CityStateCode -CountryCode US -CityStateCode "ALAARONSBURGCDP").State | Should -Be 'AL'
      $(ConvertFrom-CityStateCode -CountryCode US -CityStateCode "ALAARONSBURGCDP").City  | Should -Be 'Aaronsburg CDP'
    }

    It "<function> UK CityCode of ALSTDAVIDS" {
      $(ConvertFrom-CityStateCode -CountryCode UK -CityStateCode "ALSTDAVIDS").State | Should -Be 'AL'
      $(ConvertFrom-CityStateCode -CountryCode UK -CityStateCode "ALSTDAVIDS").City  | Should -Be 'St Davids'
    }
  }

}