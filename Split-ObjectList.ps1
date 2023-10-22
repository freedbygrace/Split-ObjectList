## Microsoft Function Naming Convention: http://msdn.microsoft.com/en-us/library/ms714428(v=vs.85).aspx

#region Function Split-ObjectList
Function Split-ObjectList
    {
        <#
          .SYNOPSIS
          Provides the functionality to split a list of objects into chunks based on the specified mode.
          
          .DESCRIPTION
          This is the more performant method of breaking an object into chunks for various use cases.
          
          .PARAMETER ByPercentage
          Places the function into "ByPercentage" mode. This will split the list of objects based on the provided percentage list.

          .PARAMETER PercentageList
          The list of percentages to split the list of objects by.

          .PARAMETER InputObjectList
          A valid list of objects that will be used for splitting.

          .PARAMETER ContinueOnError
          Ignore errors.
          
          .EXAMPLE
          $SplitObjectListResult = Split-ObjectList -ByPercentage -PercentageList @(5, 10, 15, 20, 25, 25) -InputObjectList (1..200000) -Verbose

          Write-Output -InputObject ($SplitObjectListResult)
          
          .EXAMPLE
          $SplitObjectListParameters = New-Object -TypeName 'System.Collections.Specialized.OrderedDictionary'
	          $SplitObjectListParameters.ByPercentage = $True
	          $SplitObjectListParameters.PercentageList = New-Object -TypeName 'System.Collections.Generic.List[UInt32]'
              $SplitObjectListParameters.PercentageList.Add(5)
              $SplitObjectListParameters.PercentageList.Add(10)
              $SplitObjectListParameters.PercentageList.Add(15)
              $SplitObjectListParameters.PercentageList.Add(20)
              $SplitObjectListParameters.PercentageList.Add(25)
              $SplitObjectListParameters.PercentageList.Add(25)
	          $SplitObjectListParameters.InputObjectList = 1..200000
	          $SplitObjectListParameters.Verbose = $True
            $SplitObjectListParameters.ContinueOnError = $False

          $SplitObjectListResult = Split-ObjectList @SplitObjectListParameters

          Write-Output -InputObject ($SplitObjectListResult)

          .NOTES
          Most of the time, various "List" type objects are used with index removal and so forth, which can work, but is not the most performant.
          
          .LINK
          https://stackoverflow.com/questions/56990719/split-array-by-percentage

          .LINK
          https://www.infoworld.com/article/3666499/how-to-work-with-a-priority-queue-in-net-6.html
        #>
        
        [CmdletBinding(ConfirmImpact = 'Low', DefaultParameterSetName = 'ByPercentage')]
       
        [OutputType([System.Management.Automation.PSObject[]])]
        Param
          (        
              [Parameter(Mandatory=$True, ParameterSetName = 'ByPercentage')]
              [ValidateNotNullOrEmpty()]
              [Switch]$ByPercentage,

              [Parameter(Mandatory=$True, ParameterSetName = 'ByPercentage')]
              [ValidateNotNullOrEmpty()]
              [System.UInt32[]]$PercentageList,
                
              [Parameter(Mandatory=$True)]
              [ValidateNotNullOrEmpty()]
              [System.Object[]]$InputObjectList,
                                                            
              [Parameter(Mandatory=$False)]
              [Switch]$ContinueOnError        
          )
                    
        Begin
          {

              
              Try
                {
                    $DateTimeLogFormat = 'dddd, MMMM dd, yyyy @ hh:mm:ss.FFF tt'  ###Monday, January 01, 2019 @ 10:15:34.000 AM###
                    [ScriptBlock]$GetCurrentDateTimeLogFormat = {(Get-Date).ToString($DateTimeLogFormat)}
                    $DateTimeMessageFormat = 'MM/dd/yyyy HH:mm:ss.FFF'  ###03/23/2022 11:12:48.347###
                    [ScriptBlock]$GetCurrentDateTimeMessageFormat = {(Get-Date).ToString($DateTimeMessageFormat)}
                    $DateFileFormat = 'yyyyMMdd'  ###20190403###
                    [ScriptBlock]$GetCurrentDateFileFormat = {(Get-Date).ToString($DateFileFormat)}
                    $DateTimeFileFormat = 'yyyyMMdd_HHmmss'  ###20190403_115354###
                    [ScriptBlock]$GetCurrentDateTimeFileFormat = {(Get-Date).ToString($DateTimeFileFormat)}
                    $TextInfo = (Get-Culture).TextInfo
                    $LoggingDetails = New-Object -TypeName 'System.Collections.Specialized.OrderedDictionary'    
                      $LoggingDetails.Add('LogMessage', $Null)
                      $LoggingDetails.Add('WarningMessage', $Null)
                      $LoggingDetails.Add('ErrorMessage', $Null)
                    $CommonParameterList = New-Object -TypeName 'System.Collections.Generic.List[String]'
                      $CommonParameterList.AddRange([System.Management.Automation.PSCmdlet]::CommonParameters)
                      $CommonParameterList.AddRange([System.Management.Automation.PSCmdlet]::OptionalCommonParameters)

                    [ScriptBlock]$ErrorHandlingDefinition = {
                                                                Param
                                                                  (
                                                                      [Int16]$Severity,
                                                                      [Boolean]$ContinueOnError
                                                                  )
                                                                                                                
                                                                $ExceptionPropertyDictionary = New-Object -TypeName 'System.Collections.Specialized.OrderedDictionary'
                                                                  $ExceptionPropertyDictionary.Add('Message', $_.Exception.Message)
                                                                  $ExceptionPropertyDictionary.Add('Category', $_.Exception.ErrorRecord.FullyQualifiedErrorID)
                                                                  #$ExceptionPropertyDictionary.Add('ExitCode', $Script:LASTEXITCODE)
                                                                  #$ExceptionPropertyDictionary.Add('Script', $_.InvocationInfo.ScriptName)
                                                                  $ExceptionPropertyDictionary.Add('LineNumber', $_.InvocationInfo.ScriptLineNumber)
                                                                  $ExceptionPropertyDictionary.Add('LinePosition', $_.InvocationInfo.OffsetInLine)
                                                                  $ExceptionPropertyDictionary.Add('Code', $_.InvocationInfo.Line.Trim())

                                                                $ExceptionMessageList = New-Object -TypeName 'System.Collections.Generic.List[String]'

                                                                ForEach ($ExceptionProperty In $ExceptionPropertyDictionary.GetEnumerator())
                                                                  {
                                                                      $ExceptionMessageList.Add("[$($ExceptionProperty.Key): $($ExceptionProperty.Value)]")
                                                                  }

                                                                $LogMessageParameters = New-Object -TypeName 'System.Collections.Specialized.OrderedDictionary'
                                                                  $LogMessageParameters.Message = $ExceptionMessageList -Join ' '
                                                                  $LogMessageParameters.Verbose = $True
                              
                                                                Switch ($Severity)
                                                                  {
                                                                      {($_ -in @(1))} {Write-Verbose @LogMessageParameters}
                                                                      {($_ -in @(2))} {Write-Warning @LogMessageParameters}
                                                                      {($_ -in @(3))} {Write-Error @LogMessageParameters}
                                                                  }

                                                                Switch ($ContinueOnError)
                                                                  {
                                                                      {($_ -eq $False)}
                                                                        {                  
                                                                            Throw
                                                                        }
                                                                  }
                                                            }
                    
                    #Determine the date and time we executed the function
                      $FunctionStartTime = (Get-Date)
                    
                    [String]$FunctionName = $MyInvocation.MyCommand
                    [System.IO.FileInfo]$InvokingScriptPath = $MyInvocation.PSCommandPath
                    [System.IO.DirectoryInfo]$InvokingScriptDirectory = $InvokingScriptPath.Directory.FullName
                    [System.IO.FileInfo]$FunctionPath = "$($InvokingScriptDirectory.FullName)\Functions\$($FunctionName).ps1"
                    [System.IO.DirectoryInfo]$FunctionDirectory = "$($FunctionPath.Directory.FullName)"
                    
                    $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Function `'$($FunctionName)`' is beginning. Please Wait..."
                    Write-Verbose -Message ($LoggingDetails.LogMessage)
              
                    #Define Default Action Preferences
                      $ErrorActionPreference = 'Stop'
                      
                    [String[]]$AvailableScriptParameters = (Get-Command -Name ($FunctionName)).Parameters.GetEnumerator() | Where-Object {($_.Value.Name -inotin $CommonParameterList)} | ForEach-Object {"-$($_.Value.Name):$($_.Value.ParameterType.Name)"}
                    $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Available Function Parameter(s) = $($AvailableScriptParameters -Join ', ')"
                    Write-Verbose -Message ($LoggingDetails.LogMessage)

                    [String[]]$SuppliedScriptParameters = $PSBoundParameters.GetEnumerator() | ForEach-Object {Try {"-$($_.Key):$($_.Value.GetType().Name)"} Catch {"-$($_.Key):Unknown"}}
                    $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Supplied Function Parameter(s) = $($SuppliedScriptParameters -Join ', ')"
                    Write-Verbose -Message ($LoggingDetails.LogMessage)

                    $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Execution of $($FunctionName) began on $($FunctionStartTime.ToString($DateTimeLogFormat))"
                    Write-Verbose -Message ($LoggingDetails.LogMessage)

                    [String]$ParameterSetName = $PSCmdlet.ParameterSetName

                    $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Parameter Set Name: $($ParameterSetName)"
                    Write-Verbose -Message ($LoggingDetails.LogMessage)
                                        
                    #Create an object that will contain the functions output.
                      $OutputObjectList = New-Object -TypeName 'System.Collections.Generic.List[System.Management.Automation.PSObject]'


                }
              Catch
                {
                    $ErrorHandlingDefinition.Invoke(2, $ContinueOnError.IsPresent)
                }
              Finally
                {
                    
                }
          }

        Process
          {           
              Try
                {  
                    Switch ($ParameterSetName)
                      {
                          {($_ -iin @('ByPercentage'))}
                            {
                                [UInt32]$RequiredPercentageListTotal = 100
                                
                                [UInt32]$PercentageListTotal = ($PercentageList | Measure-Object -Sum).Sum
                                
                                Switch ($PercentageListTotal -ne $RequiredPercentageListTotal)
                                  {
                                      {($_ -eq $True)}
                                        {
                                            $LoggingDetails.WarningMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - The percentage list must equal $($RequiredPercentageListTotal)."
                                            Write-Warning -Message ($LoggingDetails.WarningMessage) -Verbose

                                            Return
                                        }
                                  }
                                
                                $InputObjectQueue = New-Object -TypeName 'System.Collections.Generic.Queue[System.Object]'

                                $InputObjectList | ForEach-Object {($InputObjectQueue.Enqueue($_))}

                                $InputObjectListCount = ($InputObjectList | Measure-Object).Count

                                $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Input Object List Count: $($InputObjectListCount)"
                                Write-Verbose -Message ($LoggingDetails.LogMessage)
                                
                                $PercentageListCounter = 1

                                $PercentageListCount = ($PercentageList | Measure-Object).Count
            
                                For ($PercentageListIndex = 0; $PercentageListIndex -lt $PercentageListCount; $PercentageListIndex++)
                                  {
                                      $Percentage = $PercentageList[$PercentageListIndex]

                                      $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Attempting to process percentage list entry $($PercentageListCounter) of $($PercentageListCount). Please Wait..."
                                      Write-Verbose -Message ($LoggingDetails.LogMessage)

                                      $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Percentage: $($Percentage)%"
                                      Write-Verbose -Message ($LoggingDetails.LogMessage)
                        
                                      Switch ($InputObjectQueue.Count -gt 0)
                                        {
                                            {($_ -eq $True)}
                                              {                                    
                                                  $InputObjectPercentageFormula = {[System.Math]::Round((($InputObjectListCount * $Percentage) / 100), 0)}
                  
                                                  $InputObjectPercentageCalculation = $InputObjectPercentageFormula.InvokeReturnAsIs()

                                                  $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Percentage Calculation: $($InputObjectPercentageCalculation)"
                                                  Write-Verbose -Message ($LoggingDetails.LogMessage)
                  
                                                  $OutputObjectProperties = New-Object -TypeName 'System.Collections.Specialized.OrderedDictionary'
                                                    $OutputObjectProperties.Wave = $PercentageListCounter
                                                    $OutputObjectProperties.Count = 0
                                                    $OutputObjectProperties.Members = New-object -TypeName 'System.Collections.Generic.List[System.Object]'

                                                  $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Attempting to process wave $($OutputObjectProperties.Wave). Please Wait..."
                                                  Write-Verbose -Message ($LoggingDetails.LogMessage)
                                                  
                                                  $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Attempting to add $($InputObjectPercentageCalculation) member(s) to wave $($OutputObjectProperties.Wave). Please Wait..."
                                                  Write-Verbose -Message ($LoggingDetails.LogMessage)
                                      
                                                  $InputObjectCounter = 1
                                    
                                                  For ($InputObjectCounter = 1; $InputObjectCounter -le $InputObjectPercentageCalculation; $InputObjectCounter++)
                                                    {
                                                        $InputObject = $InputObjectQueue.Dequeue()
                                          
                                                        $OutputObjectProperties.Members.Add($InputObject)
                                                    }

                                                  $OutputObjectProperties.Members = $OutputObjectProperties.Members.ToArray()
                                    
                                                  $OutputObjectProperties.Count = $OutputObjectProperties.Members.Count
                                    
                                                  $OutputObject = New-Object -TypeName 'System.Management.Automation.PSObject' -Property ($OutputObjectProperties)

                                                  $OutputObjectList.Add($OutputObject)

                                                  $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Successfully completed the processing of wave $($OutputObjectProperties.Wave)."
                                                  Write-Verbose -Message ($LoggingDetails.LogMessage)
                                              }
                                        }

                                      $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - There are now $($InputObjectQueue.Count) objects remaining in the queue."
                                      Write-Verbose -Message ($LoggingDetails.LogMessage)

                                      $PercentageListCounter++        
                                  }
                            }
                      }
                }
              Catch
                {
                    $ErrorHandlingDefinition.Invoke(2, $ContinueOnError.IsPresent)
                }
              Finally
                {
                    
                }
          }
        
        End
          {                                        
              Try
                {
                    #Determine the date and time the function completed execution
                      $FunctionEndTime = (Get-Date)

                      $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Execution of $($FunctionName) ended on $($FunctionEndTime.ToString($DateTimeLogFormat))"
                      Write-Verbose -Message ($LoggingDetails.LogMessage)

                    #Log the total script execution time  
                      $FunctionExecutionTimespan = New-TimeSpan -Start ($FunctionStartTime) -End ($FunctionEndTime)

                      $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Function execution took $($FunctionExecutionTimespan.Hours.ToString()) hour(s), $($FunctionExecutionTimespan.Minutes.ToString()) minute(s), $($FunctionExecutionTimespan.Seconds.ToString()) second(s), and $($FunctionExecutionTimespan.Milliseconds.ToString()) millisecond(s)"
                      Write-Verbose -Message ($LoggingDetails.LogMessage)
                    
                    $LoggingDetails.LogMessage = "$($GetCurrentDateTimeMessageFormat.Invoke()) - Function `'$($FunctionName)`' is completed."
                    Write-Verbose -Message ($LoggingDetails.LogMessage)
                }
              Catch
                {
                    $ErrorHandlingDefinition.Invoke(2, $ContinueOnError.IsPresent)
                }
              Finally
                {
                    $OutputObjectList = $OutputObjectList.ToArray()

                    Write-Output -InputObject ($OutputObjectList)
                }
          }
    }
#endregion