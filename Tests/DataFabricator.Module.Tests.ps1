$here = "$pwd\Tests"

$module = 'DataFabricator'

Describe -Tags ('Unit', 'Acceptance') "$module Module Tests"  {

  Context 'Module Setup' {
    It "has the root module $module.psm1" {
      "$here\..\$module.psm1" | Should -Exist
    }

    It "has the a manifest file of $module.psd1" {
      "$here\..\$module.psd1" | Should -Exist
      "$here\..\$module.psd1" | Should -FileContentMatch "$module.psm1"
    }
    
    It "$module folder has Get functions" {
      "$here\..\Code\Get-*.ps1" | Should -Exist
    }

    It "$module folder has New functions" {
      "$here\..\Code\New-*.ps1" | Should -Exist
    }

    It "$module folder has Test functions" {
      "$here\..\Code\New-*.ps1" | Should -Exist
    }

    It "$module is valid PowerShell code" {
      $psFile = Get-Content -Path "$here\..\$module.psm1" `
                            -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
      $errors.Count | Should -Be 0
    }

  } # Context 'Module Setup'

<#
  $functions = ('Get-NoAgenda',
                'Get-PodcastData',
                'Get-PodcastMedia',
                'Get-PodcastImage',
                'ConvertTo-PodcastHtml',
                'ConvertTo-PodcastXML',
                'Write-PodcastHtml', 
                'Write-PodcastXML'
               )

  foreach ($function in $functions)
  {
  
    Context "Test Function $function" {
      
      It "$function.ps1 should exist" {
        "$here\function-$function.ps1" | Should -Exist
      }
    
      It "$function.ps1 should have help block" {
        "$here\function-$function.ps1" | Should -FileContentMatch '<#'
        "$here\function-$function.ps1" | Should -FileContentMatch '# >'
      }

      It "$function.ps1 should have a SYNOPSIS section in the help block" {
        "$here\function-$function.ps1" | Should -FileContentMatch '.SYNOPSIS'
      }
    
      It "$function.ps1 should have a DESCRIPTION section in the help block" {
        "$here\function-$function.ps1" | Should -FileContentMatch '.DESCRIPTION'
      }

      It "$function.ps1 should have a EXAMPLE section in the help block" {
        "$here\function-$function.ps1" | Should -FileContentMatch '.EXAMPLE'
      }
    
      It "$function.ps1 should be an advanced function" {
        "$here\function-$function.ps1" | Should -FileContentMatch 'function'
        "$here\function-$function.ps1" | Should -FileContentMatch 'cmdletbinding'
        "$here\function-$function.ps1" | Should -FileContentMatch 'param'
      }
      
      It "$function.ps1 should contain Write-Verbose blocks" {
        "$here\function-$function.ps1" | Should -FileContentMatch 'Write-Verbose'
      }
    
      It "$function.ps1 is valid PowerShell code" {
        $psFile = Get-Content -Path "$here\function-$function.ps1" `
                              -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
        $errors.Count | Should -Be 0
      }

    
    } # Context "Test Function $function"

    Context "$function has tests" {
      It "function-$($function).Tests.ps1 should exist" {
        "$here\function-$($function).Tests.ps1" | Should -Exist
      }
    }
  
  } # foreach ($function in $functions)

#>

}