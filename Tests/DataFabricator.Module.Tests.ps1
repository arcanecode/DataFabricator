Describe -Tags ('Unit', 'Acceptance') "DataFabricator Module Tests"  {

  BeforeAll {
    $module = 'DataFabricator'
    $here = $PSScriptRoot

  } # BeforeAll

  Context 'Module Setup' {

    It "<module> has the root module <module>.psm1" {
      "$here\..\$module.psm1" | Should -Exist
    }

    It "<module> has the a manifest file of <module>.psd1" {
      "$here\..\$module.psd1" | Should -Exist
      "$here\..\$module.psd1" | Should -FileContentMatch "$module.psm1"
    }

    It "<module>\Code folder has Get functions" {
      "$here\..\Code\Get-*.ps1" | Should -Exist
    }

    It "<module>\Code folder has New functions" {
      "$here\..\Code\New-*.ps1" | Should -Exist
    }

    It "<module>\Code folder has Test functions" {
      "$here\..\Code\New-*.ps1" | Should -Exist
    }

    It "<module>.psm1 is valid PowerShell code" {
      $psFile = Get-Content -Path "$here\..\$module.psm1" `
                            -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
      $errors.Count | Should -Be 0
    }

  } # Context 'Module Setup'

}