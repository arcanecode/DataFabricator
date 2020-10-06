<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Export-Documentation.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This file is used to generate (or regenerate) the Markdown Documenation from the
  inline help using the PlatyPS module. Using this, when I update any function in the module and
  its help, I can simply run this script to regenerate all the documentation quick and easy.

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
Install-Module PlatyPS       # Should only need to run this once
Import-Module PlatyPS

# Before running, you need to have the most current version of DataFabricator loaded in memory
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator

<#-------------------------------------------------------------------------------------------------
  Now generate the documentation. PlatyPS New-MarkdownHelp cmdlet will read the comment based
  help included with each function in the module and generate a markdown document from it.

  The OutputFolder is the location the markdown will be written to. We assume you are in the
  root folder of the module, with the Code, Data, Documentation etc. folders under it.

  Force is needed to overwrite existing documentation, and be aware this WILL overwrite any
  Markdown files that exist from previous runs. Any markdown files you manually created, such
  as a readme, are not affected.

  AlphabeticParamsOrder simply orders any parameters in alphabetical order.

  By default at the top of each markdown PlatyPS will insert metadata. If found this wasn't
  particularly useful, so use the -NoMetadata switch to suppress it.

  When you use -WithModulePage, PlatyPS will generate a single markdown with the same name as
  the module. This will act as a table of contents for your help, with links to each individual
  markdown for a function. The issue is force will overwrite the file, including the required
  updates for descriptions. So I used it once, to generate a list of everything, then removed
  it from the parameters. From here on it'll get manually updated.
-----------------------------------------------------------------------------------------------#>
$docPath = ".\Documentation"
New-MarkdownHelp -Module DataFabricator `
                 -OutputFolder $docPath `
                 -Force `
                 -AlphabeticParamsOrder `
                 -NoMetadata
              # -WithModulePage

<#-------------------------------------------------------------------------------------------------
  As nice as PlayPS is, and it is a huge timesaver, it also has it's issues.

  First, it has a weird quirk (bug?) That makes everything under the Input and Output tags
  a level 3 header. This looks ugly and shouldn't be, so this code will clean that up by
  stripping out the ### for each line in those sections

  In addition, it does not adhere to good markdown rules, such as blank lines after headers, 
  so we will make checks to reformat the output to make it adhere to good practices.

  When PlatyPS inserted a code block, it just used the generic three backticks. I chose to
  update it with ```powershell in order to get good formatting for PowerShell code.

  Next I got into some customizations that were for me. First, when I was showing example
  output, I often used a format like:
  FirstName | Charlie
  LastName | Brown

  I used the custom code below to convert that into a proper markdown table.

  Next, I have standard comment headers I place in my code. To further boost my ego, I added
  some code that would convert the links I place in my comment headers into actual markdown
  link syntax.

  In my comment based help, I placed links to other related commands. PlatyPS just 
  renders them with the full https://github/arcanecode/blah/blah/blah, so I fix the generated
  markdown link to something nicer to read.

  I'm hopeful that one day the Output bug that started this will be fixed, however a lot of
  the other code that evolved from this will remain. It shows how you can take a level of
  automation, provided by a module like PlatyPS, and amplify it with a bit of your own code
  to make a really outstanding product.
-----------------------------------------------------------------------------------------------#>

# Get a list of all the MD files
$filePath = Get-ChildItem -Path $docPath | Where-Object {$_.Extension -eq '.md'} # | Where-Object { $_.Name -eq 'ConvertFrom-CityStateCode.md'}

# Create a function to do the cleanup. This will make it easier to transfer this code to
# future projects.
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
    $checkIOforUnwantedH3Tags = $false
    $checkForBlankLineAfterAHeaderLine = $false
    $skipSyntaxCheck = $false
    $yamlBlock = $false
    $prevLine = ''
    $insertTableHeader = $false

    # Create an array to hold the new file output
    $newOutput = @()

    # Loop over each line
    foreach ($line in $contents)
    {
      Write-Verbose '----------------------------------------'
      Write-Verbose $line
      Write-Verbose '----------------------------------------'

      # If the previous line was a header tag (if so it set the checkForBlank to
      # true during the previous iteration in the loop), and the current line is blank,
      # insert a blank line between the header and this one
      if ($checkForBlankLineAfterAHeaderLine)
      {
        Write-Verbose "Checking for Blank: $($line.Length) $line"
        if ($line.Length -ne 0)
          { $newOutput += ''  ; Write-Verbose 'Adding a blank'}
        $checkForBlankLineAfterAHeaderLine = $false
      }

      # If we are at the input area, turn on the flag to begin checking
      # for the erroneous ### tags PlatyPS likes (mistakenly) to insert
      if ( $line.StartsWith('## INPUTS') )
      {
        $checkIOforUnwantedH3Tags = $true
        $insertTableHeader = $true
        Write-Verbose 'Start Checking'
      }

      # If we are checking, it means we're in the input/output area
      if ( $checkIOforUnwantedH3Tags )
      {
        # If this line starts with a H3 tag we want to remove it
        if ( $line.StartsWith('###') )
          { $line = $line.Substring(4) ; Write-Verbose 'Removing ###'}

        # In the output section of the help I use | to divide the property from its
        # description. Use this code to convert it to a proper markdown table
        if ($line.Contains('|'))
        {
          if ( $insertTableHeader )
          {
            $newOutput += ''
            $newOutput += 'Property | Description'
            $newOutput += '| ----- | ------ |'
            $insertTableHeader = $false
          }
        }

        # Once we hit the notes area stop checking
        if ( $line.StartsWith('## NOTES' ) )
          {
             $checkIOforUnwantedH3Tags = $false
             $insertTableHeader = $false
             Write-Verbose 'Found ## NOTES'
          }

      } # if ( $checkIOforUnwantedH3Tags )

      # Before and after some of the header tags, PlatyPS does not put a blank line,
      # so see if we need to add one before or after. This will fix both H2 and H3 headers.
      if ( $line.StartsWith('##') )
      {
        Write-Verbose "Found StartsWith ## at $line "

        # Trigger a check for the line after it
        $checkForBlankLineAfterAHeaderLine = $true

        # In addition to a blank line after a header tag, there should also be a
        # blank line before the header. Check the previous line, and if it wasn't
        # empty, add a blank line ahead of the header line (contained in $line)
        if ($prevLine.Length -ne 0)
          { $newOutput += ''  ; Write-Verbose "Adding a blank line after $line"}
      }

      # There are two types of code syntax blocks. The first is YAML, which PlatyPS inserts.
      # The second are in the EXAMPLE area, unfortunately PLatyPS just inserts a ```, which
      # denotes as a code block but not a PowerShell code block, hence the markdown won't
      # render it with the right syntax colors. We will fix that here, by replacing the
      # first instance of a code block with a named powershell block.
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

      # In the Examples section, use the same technique with the | symbol to take output
      # and turn it into a markdown table. I have to be careful though, since PowerShell itself
      # uses pipes, not to screw with the powershell code block but only the data under it,
      # until it hits the next example
      if ( $line.StartsWith('```') )
      {
        if ( $line.StartsWith('```powershell') -eq $false )
        {
          $exampleChecking = $true
          $insertTableHeader = $true
          Write-Verbose 'Start Example Checking'
        }
      }

      # In theory this shouldn't happen, it should have gotten turned off from the
      # previous iteration in the loop. But just in case let's turn it off anyway
      if ( $line.StartsWith('```powershell')  )
      {
        $exampleChecking = $false
        $insertTableHeader = $false
      }

      # OK, time to turn it into a table. In the help text we already use a | to separate
      # the properties and values, so all we really have to do is insert a table header. Then
      # markdown will read the rest of the text as a table automatically
      if ( $line.Length -gt 0 )
      {
        if ( ($line.Contains('|')) -and ($exampleChecking -eq $true))
        {
          if ( $insertTableHeader )
          {
            $newOutput += ''
            $newOutput += 'Property | Value'
            $newOutput += '| ----- | ------ |'
            $insertTableHeader = $false
          }
        }
      }

      # If we are at the start of a PowerShell code block, we definately want to turn off
      # checking
      if ( $line.StartsWith('```powershell') )
      {
        $exampleChecking = $false
        $insertTableHeader = $false
        Write-Verbose 'Stop Example Checking'
      }

      # Once we hit the parameters, we've exited the examples and should be sure to
      # turn checking off
      if ( $line.StartsWith('## PARAMETERS') )
      {
        $exampleChecking = $false
        $insertTableHeader = $false
        Write-Verbose 'Stop Example Checking'
      }


      # Look for links specific to our documentation, and remove the
      # https part and the md part from the link label so it looks like
      # a proper link when it's rendered in markdown. Thus instead of
      # getting https://blah/blah/Get-FabricatedDate.md as the 'friendly' name,
      # it will instead become just Get-FabricatedDate
      $lookFor = '[https://github.com/arcanecode/DataFabricator/blob/master/Documentation/'
      if ($line.StartsWith($lookFor))
      {
        Write-Verbose 'Fixing Documentation Link'
        $line = '[' + $line.Substring(72)
        $line = $line.Replace('.md]', ']')
      }

      # There are a few text strings with URLs I want to clean up, as PlatyPS just uses the URL for
      # the friendly name of the link, and I would prefer to generate a human readable name.
      # In addtion, in the notes area I have my Twitter handle. While we are at it let's turn
      # it into an actual link (appeasing my vanity, don't ya know)
      # The hashtable Name property is to the left of the equal sign, the Value property is
      # to the right.
      $replacements = @{'Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com' = 'Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com'
                        '[http://datafabricator.com](http://datafabricator.com)' = '[Data Fabricator on GitHub](http://datafabricator.com)'
                        '[http://arcanecode.me]' = '[ArcaneCode''s Website](http://arcanecode.me)'
                       }

      # Note you can't iterate over a hashtable like you would an array, instead you have
      # to call the GetEnumerator() method of the hashtable
      foreach ( $r in $replacements.GetEnumerator() )
      {
        if ($line.StartsWith($r.Name))
          { $line = $r.Value }
      }

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

# Now we'll call the above function, passing in a list of files to correct
Format-PlatyPSMarkdown -FilePath $filePath # -Verbose


