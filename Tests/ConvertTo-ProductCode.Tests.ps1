Describe "DataFabricator ConvertTo-ProductCode Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'ConvertTo-ProductCode'
    $here = $PSScriptRoot
    $testClothing = 'Aaaaaaaa'
    $testColor = 'Bbbbbbb'
    $testSize = 'Cccccc'
    $expectedResult = 'AAABBBCCC'
  }

  Context "<module> <function> Tests" {
    It "<function> returns value of <expectedResult>" {
      $(ConvertTo-ProductCode -Clothing $testClothing `
                              -Color $testColor `
                              -Size $testSize) |
      Should -Be $expectedResult
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests