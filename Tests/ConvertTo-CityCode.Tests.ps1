Describe "DataFabricator ConvertTo-CityCode Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'ConvertTo-CityCode'
    $here = $PSScriptRoot
    $testValue = "Aa -,'bB123cc"
    $expectedValue = 'AABB123CC'

  }

  Context "<module> <function> Tests" {
    It "<function> passes in a value of <testValue> and returns <expectedValue>" {
      $(ConvertTo-CityCode -City $testValue) | Should -Be $expectedValue
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests