function Get-FabricatedBin()
{
  [CmdletBinding()]
  param (
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Typically with warehouses, the first two letters indicate the row
  $l1 = $m_Letter | Get-Random
  $l2 = $m_Letter | Get-Random

  # The first number indicates the level of the bin, i.3. 1 is the bottom
  # row, 2 second, and 3 third
  # The last two numbers indicate how far down the row to go
  $num = (1..399 | Get-Random).ToString().PadLeft(3, '0')

  $retVal = "$l1$l2$num"
  Write-Verbose "$fn Fabricated Bin: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}