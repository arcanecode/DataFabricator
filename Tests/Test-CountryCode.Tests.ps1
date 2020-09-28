$countryCodes = @( 'Unspecified', 'US', 'UK' )

$scenarios = @()

foreach ($item in $countryCodes)
{
  $scenarios += @{ inputValue = $item }
}

#Describe "Test-CountryCode Tests" -ForEach $countryCodes {
Describe "Test-CountryCode Tests" {

  BeforeAll {
    $function = 'Test-CountryCode'
    $module = 'DataFabricator'

  }

  Context "<function> Tests" {
    It '<function> -CountryCode <inputValue> Should Return True' -TestCases $scenarios {
      $(Test-CountryCode -CountryCode $inputValue) | Should -BeTrue
    }

  } # Context "<function> Tests"

}


<#

# While the above is the preferred way, below is an alternate way of constructing
# the test. Keeping it for reference.

$countryCodes = @( 'Unspecified', 'US', 'UK' )

Describe "Test-CountryCode Tests" -ForEach $countryCodes {

  BeforeAll {
    $countryCode = $_
    $function = 'Test-CountryCode'
    $module = 'DataFabricator'
    $here = $PSScriptRoot

  }

  Context "<function> Tests" {
    It '<function> test of <countryCode> Should Return True' {
      $(Test-CountryCode -CountryCode $countryCode) | Should -BeTrue
    }

  } # Context "<function> Tests"

}
#>
