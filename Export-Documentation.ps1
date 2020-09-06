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
# Import-Module PlatyPS

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

function Format-PlatyPSMarkdown()
{
  [CmdletBinding()]
  param (
          [array] $FilePath
        )

# Now loop over each one fixing the issue
  foreach ($f in $FilePath)
  {
    # Just display the name of what we are working on
    $f.Name 
    
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
      Write-Verbose '----------------------------------------'
      Write-Verbose $line
      Write-Verbose '----------------------------------------'
      # If the previous line was a header tag, and the current line is blank,
      # insert a blank line between the header and this one
      if ($checkForBlank)
      {
        Write-Verbose "Checking for Blank: $($line.Length) $line"
        if ($line.Length -ne 0)
          { $newOutput += ''  ; Write-Verbose 'Adding a blank'}
        $checkForBlank = $false
      }
  
      # If we are at the input area, turn on the flag to begin checking
      # for the erroneous ### tags PlatyPS likes (mistakenly) to insert
      if ( $line.StartsWith('## INPUTS') )
        { $startChecking = $true ; Write-Verbose 'Start Checking'}
  
      # If we are checking, it means we're in the input/output area
      if ( $startChecking )
      {
        # If this line starts with a H3 tag we want to remove it
        if ( $line.StartsWith('###') )
          { $line = $line.Substring(4) ; Write-Verbose 'Removing ###'}
  
        # Once we hit the notes area stop checking
        if ( $line.StartsWith('## NOTES' ) )
          { $startChecking = $false ; Write-Verbose 'Found ## NOTES'}
  
      } # if ( $startChecking )
  
      # After some of the headers, it does not put a blank line, so add one
      if ( $line.StartsWith('##') )
      { 
        Write-Verbose "Found StartsWith ## at $line "
        # Trigger a check for the line after it
        $checkForBlank = $true 
        # If the previous line wasn't empty, add an extra one
        if ($prevLine.Length -ne 0) 
          { $newOutput += ''  ; Write-Verbose "Adding a blank line after $line"}
      }
  
      # If this is a code syntax block    
      if ( ($line -eq '```') -and ($yamlBlock -eq $false) )
      {
        Write-Verbose 'Found a syntax block that wasn''t YAML'
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
      
      } #if ( ($line -eq '```') -and ($yamlBlock -eq $false) )
  
      # PlatyPS puts in YAML blocks so we need to flag when we find one so
      # we don't accidentally replace the closing YAML tag with the start powershell tag
      if ( $line -eq '```yaml' )
        { $yamlBlock = $true ; Write-Verbose 'Found a YAML block'}
  
      # Look for links specific to our documentation, and remove the
      # https part and the md part from the link label so it looks like
      # a proper link when it's rendered in markdown
      $lookFor = '[https://github.com/arcanecode/DataFabricator/blob/master/Documentation/'
      if ($line.StartsWith($lookFor))
      {
        Write-Verbose 'Fixing Documentation Link'
        $line = '[' + $line.Substring(72)
        $line = $line.Replace('.md]', ']')
      }

      # The notes section contains my twitter handle, let's make it a link
      $lookFor = 'Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com'
      $replaceWith = 'Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com'
      if ($line.StartsWith($lookFor))
        { $line = $replaceWith ; Write-Verbose '@ArcaneCode'}
  
      # Also clean up the link to the Data Fabricator site we include in
      # Every help comment
      $lookFor = '[http://datafabricator.com](http://datafabricator.com)'
      $replaceWith = '[Data Fabricator on GitHub](http://datafabricator.com)'
      if ($line.StartsWith($lookFor))
        { $line = $replaceWith ; Write-Verbose 'Fixing Data Fabrictor'}

      # The link section contains a link to my website, fix it to be
      # a real markdown link
      $lookFor = '[http://arcanecode.me]'
      $replaceWith = '[ArcaneCode''s Website](http://arcanecode.me)'
      if ( $line.StartsWith($lookFor) )
        { $line = $replaceWith ; Write-Verbose 'Fixing arcanecode.me' }

      Write-Verbose 'Adding line'
      $prevLine = $line
      $newOutput += $line
  
    } # foreach ($line in $contents)
  
    # Final cleanup, there winds up being an extraneous blank line
    # at the end of the file. Resift the output stopping at the
    # Data Fabricator URL, which should always be the last thing
    $finalOutput = @()
    foreach ($line in $newOutput)
    {
      if ($line -eq '[Data Fabricator on GitHub](http://datafabricator.com)')
      {
        # Finally! Write the fixed MD to the file, replacing it
        Write-Verbose "Writing to $($f.FullName)"
        $finalOutput += $line
        $finalOutput | Out-File -Path $f.FullName -Force
        break 
      }
      else
      {
        $finalOutput += $line
      }
    }

  } # foreach ($f in $FilePath)

} # function Format-PlatyPSMarkdown

Format-PlatyPSMarkdown -FilePath $filePath # -Verbose