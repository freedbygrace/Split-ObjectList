# Split-ObjectList

## SYNOPSIS
Provides the functionality to split a list of objects into chunks based on the specified mode.

## SYNTAX

```
Split-ObjectList [-ByPercentage] -PercentageList <UInt32[]> -InputObjectList <Object[]> [-ContinueOnError]
 [<CommonParameters>]
```

## DESCRIPTION
This is the more performant method of breaking an object into chunks for various use cases.

## EXAMPLES

### EXAMPLE 1
```
$SplitObjectListResult = Split-ObjectList -ByPercentage -PercentageList @(5, 10, 15, 20, 25, 25) -InputObjectList (1..$(Get-Random -Minimum 100000 -Maximum 300000)) -Verbose

Write-Output -InputObject ($SplitObjectListResult)
```
### EXAMPLE 2
```
$SplitObjectListParameters = New-Object -TypeName 'System.Collections.Specialized.OrderedDictionary'
  $SplitObjectListParameters.ByPercentage = $True
  $SplitObjectListParameters.PercentageList = New-Object -TypeName 'System.Collections.Generic.List[UInt32]'
    $SplitObjectListParameters.PercentageList.Add(5)
    $SplitObjectListParameters.PercentageList.Add(10)
    $SplitObjectListParameters.PercentageList.Add(15)
    $SplitObjectListParameters.PercentageList.Add(20)
    $SplitObjectListParameters.PercentageList.Add(25)
    $SplitObjectListParameters.PercentageList.Add(25)
  $SplitObjectListParameters.InputObjectList = 1..$(Get-Random -Minimum 100000 -Maximum 300000)
  $SplitObjectListParameters.Verbose = $True
  $SplitObjectListParameters.ContinueOnError = $False

$SplitObjectListResult = Split-ObjectList @SplitObjectListParameters

Write-Output -InputObject ($SplitObjectListResult)
```
## PARAMETERS

### -ByPercentage
Places the function into "ByPercentage" mode.
This will split the list of objects based on the provided percentage list.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContinueOnError
Ignore errors.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObjectList
A valid list of objects that will be used for splitting.

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PercentageList
The list of percentages to split the list of objects by.

```yaml
Type: System.UInt32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject[]
## NOTES
Most of the time, various "List" type objects are used with index removal and so forth, which can work, but is not the most performant.

## RELATED LINKS

[https://stackoverflow.com/questions/56990719/split-array-by-percentage](https://stackoverflow.com/questions/56990719/split-array-by-percentage)

[https://www.infoworld.com/article/3666499/how-to-work-with-a-priority-queue-in-net-6.html](https://www.infoworld.com/article/3666499/how-to-work-with-a-priority-queue-in-net-6.html)

## SAMPLE OUTPUT:

```
Wave        : 1
Percentage  : 5
MemberCount : 12110
Members     : {1, 2, 3, 4...}

Wave        : 2
Percentage  : 10
MemberCount : 24219
Members     : {12111, 12112, 12113, 12114...}

Wave        : 3
Percentage  : 15
MemberCount : 36329
Members     : {36330, 36331, 36332, 36333...}

Wave        : 4
Percentage  : 20
MemberCount : 48439
Members     : {72659, 72660, 72661, 72662...}

Wave        : 5
Percentage  : 25
MemberCount : 60548
Members     : {121098, 121099, 121100, 121101...}

Wave        : 6
Percentage  : 25
MemberCount : 60548
Members     : {181646, 181647, 181648, 181649...}
```

## SAMPLE LOG OUTPUT
```
VERBOSE: 10/22/2023 20:08:21.727 - Function 'Split-ObjectList' is beginning. Please Wait...
VERBOSE: 10/22/2023 20:08:21.751 - Available Function Parameter(s) = -ByPercentage:SwitchParameter, -PercentageList:UInt32[], -InputObjectList:Object[], -ContinueOnError:SwitchParameter
VERBOSE: 10/22/2023 20:08:21.752 - Supplied Function Parameter(s) = -ByPercentage:SwitchParameter, -PercentageList:UInt32[], -InputObjectList:Object[], -Verbose:SwitchParameter, -ContinueOnError:SwitchParameter
VERBOSE: 10/22/2023 20:08:21.753 - Execution of Split-ObjectList began on Sunday, October 22, 2023 @ 08:08:21.726 PM
VERBOSE: 10/22/2023 20:08:21.754 - Parameter Set Name: ByPercentage
VERBOSE: 10/22/2023 20:08:23.407 - Input Object List Count: 242194
VERBOSE: 10/22/2023 20:08:23.408 - Attempting to process percentage list entry 1 of 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.409 - Percentage: 5%
VERBOSE: 10/22/2023 20:08:23.411 - Percentage Calculation: 12110
VERBOSE: 10/22/2023 20:08:23.412 - Attempting to process wave 1. Please Wait...
VERBOSE: 10/22/2023 20:08:23.412 - Attempting to add 12110 member(s) to wave 1. Please Wait...
VERBOSE: 10/22/2023 20:08:23.417 - Successfully completed the processing of wave 1.
VERBOSE: 10/22/2023 20:08:23.417 - There are now 230084 objects remaining in the queue.
VERBOSE: 10/22/2023 20:08:23.418 - Attempting to process percentage list entry 2 of 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.419 - Percentage: 10%
VERBOSE: 10/22/2023 20:08:23.419 - Percentage Calculation: 24219
VERBOSE: 10/22/2023 20:08:23.42 - Attempting to process wave 2. Please Wait...
VERBOSE: 10/22/2023 20:08:23.421 - Attempting to add 24219 member(s) to wave 2. Please Wait...
VERBOSE: 10/22/2023 20:08:23.43 - Successfully completed the processing of wave 2.
VERBOSE: 10/22/2023 20:08:23.431 - There are now 205865 objects remaining in the queue.
VERBOSE: 10/22/2023 20:08:23.432 - Attempting to process percentage list entry 3 of 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.432 - Percentage: 15%
VERBOSE: 10/22/2023 20:08:23.433 - Percentage Calculation: 36329
VERBOSE: 10/22/2023 20:08:23.434 - Attempting to process wave 3. Please Wait...
VERBOSE: 10/22/2023 20:08:23.434 - Attempting to add 36329 member(s) to wave 3. Please Wait...
VERBOSE: 10/22/2023 20:08:23.448 - Successfully completed the processing of wave 3.
VERBOSE: 10/22/2023 20:08:23.449 - There are now 169536 objects remaining in the queue.
VERBOSE: 10/22/2023 20:08:23.453 - Attempting to process percentage list entry 4 of 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.454 - Percentage: 20%
VERBOSE: 10/22/2023 20:08:23.455 - Percentage Calculation: 48439
VERBOSE: 10/22/2023 20:08:23.457 - Attempting to process wave 4. Please Wait...
VERBOSE: 10/22/2023 20:08:23.458 - Attempting to add 48439 member(s) to wave 4. Please Wait...
VERBOSE: 10/22/2023 20:08:23.474 - Successfully completed the processing of wave 4.
VERBOSE: 10/22/2023 20:08:23.475 - There are now 121097 objects remaining in the queue.
VERBOSE: 10/22/2023 20:08:23.475 - Attempting to process percentage list entry 5 of 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.476 - Percentage: 25%
VERBOSE: 10/22/2023 20:08:23.477 - Percentage Calculation: 60548
VERBOSE: 10/22/2023 20:08:23.48 - Attempting to process wave 5. Please Wait...
VERBOSE: 10/22/2023 20:08:23.48 - Attempting to add 60548 member(s) to wave 5. Please Wait...
VERBOSE: 10/22/2023 20:08:23.5 - Successfully completed the processing of wave 5.
VERBOSE: 10/22/2023 20:08:23.501 - There are now 60549 objects remaining in the queue.
VERBOSE: 10/22/2023 20:08:23.502 - Attempting to process percentage list entry 6 of 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.502 - Percentage: 25%
VERBOSE: 10/22/2023 20:08:23.503 - Percentage Calculation: 60548
VERBOSE: 10/22/2023 20:08:23.504 - Attempting to process wave 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.504 - Attempting to add 60548 member(s) to wave 6. Please Wait...
VERBOSE: 10/22/2023 20:08:23.529 - Successfully completed the processing of wave 6.
VERBOSE: 10/22/2023 20:08:23.53 - There are now 1 objects remaining in the queue.
VERBOSE: 10/22/2023 20:08:23.53 - Execution of Split-ObjectList ended on Sunday, October 22, 2023 @ 08:08:23.53 PM
VERBOSE: 10/22/2023 20:08:23.532 - Function execution took 0 hour(s), 0 minute(s), 1 second(s), and 803 millisecond(s)
VERBOSE: 10/22/2023 20:08:23.532 - Function 'Split-ObjectList' is completed.
```
