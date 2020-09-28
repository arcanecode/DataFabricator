Describe "DataFabricator Get-FabricatedCity Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedCity'
    $here = $PSScriptRoot

    # Load US Cities
    $citiesUS = Get-Content .\Data\Data-CitiesUS.txt
    # Load UK Cities
    $citiesUK = Get-Content .\Data\Data-CitiesUK.txt

  }

  Context "<module> <function> Tests" {
    It "<function> is in the list of default cities" {
      $citiesUS | Should -Contain $(Get-FabricatedCity)
    }

    It "<function> is in the list of US cities" {
      $citiesUS | Should -Contain $(Get-FabricatedCity -CountryCode 'US')
    }

    It "<function> is in the list of UK cities" {
      $citiesUK | Should -Contain $(Get-FabricatedCity -CountryCode 'UK')
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests