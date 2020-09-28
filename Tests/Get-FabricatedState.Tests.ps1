Describe "DataFabricator Get-FabricatedState Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedState'
    $here = $PSScriptRoot
    $stateAbbrUS = Get-Content .\Data\Data-StateAbbrUS.txt
    $stateNameUS = Get-Content .\Data\Data-StateNameUS.txt
    $stateAbbrUK = Get-Content .\Data\Data-StateAbbrUK.txt
    $stateNameUK = Get-Content .\Data\Data-StateNameUK.txt

  }

  Context "<module> <function> Tests" {
    It "<function> Result should be in the US state abbreviation using default country code" {
      $stateAbbrUS | Should -Contain $(Get-FabricatedState)
    }

    It "<function> Result should be in the US state abbreviation using US country code" {
      $stateAbbrUS | Should -Contain $(Get-FabricatedState -CountryCode 'US')
    }

    It "<function> Result should be in the UK state abbreviation using UK country code" {
      $stateAbbrUK | Should -Contain $(Get-FabricatedState -CountryCode 'UK')
    }

    It "<function> Result should be in the US state name using default country code" {
      $stateNameUS | Should -Contain $(Get-FabricatedState -FullName)
    }

    It "<function> Result should be in the US state name using US country code" {
      $stateNameUS | Should -Contain $(Get-FabricatedState -CountryCode 'US' -FullName)
    }

    It "<function> Result should be in the UK state name using UK country code" {
      $stateNameUK | Should -Contain $(Get-FabricatedState -CountryCode 'UK' -FullName)
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests