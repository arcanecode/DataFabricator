Describe "DataFabricator Get-FabricatedJobTitle Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedJobTitle'
    $here = $PSScriptRoot

    # Load Job Titles
    $jobTitle = Get-Content .\Data\Data-JobTitles.txt

  }

  Context "<module> <function> Tests" {
    It "<function> is in the list of Job Titles" {
      $jobTitle | Should -Contain $(Get-FabricatedJobTitle)
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests