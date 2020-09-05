<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Export-Documentation.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This file is used to generate (or regenerate) the Markdown Documenation from the
  inline help using the PlatyPS module. 

  Before running you will need to install PlatyPS, available from the PSGallery.
  Install-Module PlatyPS

  Learn more about PlatyPS at: 
  https://github.com/PowerShell/platyPS

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author. 
-----------------------------------------------------------------------------------------------#>

# Import PlatyPS into memory
Import-Module PlatyPS

# Before running, you need to have the most current version loaded in memory
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator 

# Now generate the documentation (Force is needed to overwrite existing documentation)
# Note this will overwrite any changes you manually made
$docPath = ".\Documentation"
New-MarkdownHelp -Module DataFabricator -OutputFolder $docPath -Force -WithModulePage -AlphabeticParamsOrder

#Update-MarkdownHelp -Path $docPath

# This will update existing help or create files for new cmdlets
#Update-MarkdownHelpModule -Path $docPath

# PlatyPS has a weird quirk (bug?) That makes everything under the Input and Output tags
# a level 3 header. This looks ugly and shouldn't be, so this code will clean that up by
# stripping out the ### for each line in those sections

# In addition, it does not adhere to good markdown rules, so we will make checks to reformat the
# output to do so

# Get a list of all the MD files
$filePath = Get-ChildItem -Path $docPath | Where-Object {$_.Extension -eq '.md'} # | Where-Object { $_.Name -eq 'ConvertFrom-CityStateCode.md'}

# Now loop over each one fixing the issue
foreach ($f in $filePath)
{
  # Just display the name of what we are working on
  $f.FullName 
  
  # Get the contents of the file into memory
  $contents = Get-Content -Path $f.FullName

  # Set the various flags we have to have
  $startChecking = $false 
  $checkForBlank = $false
  $skipSyntaxCheck = $false
  $yamlBlock = $false
  $prevLine = ''

  # Create an array to hold the new file output
  $newOutput = @()

  # Loop over each line
  foreach ($line in $contents)
  { 
    # If the previous line was a header tag, and the current line is blank,
    # insert a blank line between the header and this one
    if ($checkForBlank)
    {
      if ($line.Length -ne 0)
        { $newOutput += ''  }
      $checkForBlank = $false
    }

    # If we try to do a substring and the line isn't long enough, it will
    # produce an error, so annoyingly we have to check each line length first
    if ( $line.Length -ge 9)
    {
      # It's the INPUTS and OUTPUTS areas that PlatyPS messes up the formatting
      # so set a flag to indicate we are in that area
      if ( $line.Substring(0, 9) -eq '## INPUTS')
        { $startChecking = $true }
    }
    
    # If we are checking, it means we're in the input/output area
    if ( $startChecking )
    {
      # If this line starts with a H3 tag we want to remove it
      if ( $line.Length -ge 4)
      { 
        if ( $line.Substring(0, 3) -eq '###' )
          { $line = $line.Substring(4) }
      }
      
      # Once we hit the notes area stop checking
      if ( $line.Length -ge 8)
      {
         if ( $line.Substring(0, 8) -eq '## NOTES' )
           { $startChecking = $false }
      }
    }

    # After some of the headers, it does not put a blank line, so add one
    if ( $line.Length -ge 2)
    { 
      if ( $line.Substring(0, 2) -eq '##' )
        { 
          $checkForBlank = $true 
          if ($prevLine.Length -ne 0) 
            { $newOutput += ''  }
        }
    }

    # If this is a code syntax block    
    if ( ($line -eq '```') -and ($yamlBlock -eq $false) )
    {
      # And it's the first one
      if ( $skipSyntaxCheck -eq $false )
      {
        # Replace the line with the one for powershell 
        $line = '```powershell'  
        # Indicate we should skip the next comment block that ends the block
        $skipSyntaxCheck = $true 
      }
      else 
      {
        $skipSyntaxCheck = $false
        $yamlBlock = $false
      }
    }

    # PlatyPS puts in YAML blocks so we need to flag when we find one so
    # we don't accidentally replace the closing YAML tag with the start powershell tag
    if ( $line -eq '```yaml' )
    {
      $yamlBlock = $true
    }

<# Need to fix this
    # Don't write two blanks in a row
    if ( ( $line -eq '' ) -and ( $prevLine -eq '' ) )
    {
      $prevLine = $line
      # Don't add a second empty line
    }
    else
    {
      $prevLine = $line
      $newOutput += $line
    }
#>
      $prevLine = $line
      $newOutput += $line

  }

  # Finally! Write the fixed MD to the file, replacing it
  $newOutput | Out-File -Path $f.FullName -Force
}
