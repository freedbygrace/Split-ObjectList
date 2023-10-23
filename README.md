# Split-ObjectList

## SYNOPSIS
Provides the functionality to split a list of objects into chunks based on the specified mode.

## SYNTAX

```
Split-ObjectList [-ByPercentage] -PercentageList <UInt32[]> -InputObjectList <Object[]> [-ContinueOnError]
 [<CommonParameters>]
```

## DESCRIPTION
This is the more performant method of breaking an object into chunks for various use cases. A list of hundreds of thousands of objects can be broken apart in seconds.

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
The list of percentages to split the list of objects by. The cumulative value must be equal to 100.

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
If the list of input objects cannot be divided evenly, the stragglers will be automatically added to the final wave.

## RELATED LINKS

[https://stackoverflow.com/questions/56990719/split-array-by-percentage](https://stackoverflow.com/questions/56990719/split-array-by-percentage)

[https://www.infoworld.com/article/3666499/how-to-work-with-a-priority-queue-in-net-6.html](https://www.infoworld.com/article/3666499/how-to-work-with-a-priority-queue-in-net-6.html)

## SAMPLE LOG OUTPUT
```
VERBOSE: 10/22/2023 20:38:17.036 - Function 'Split-ObjectList' is beginning. Please Wait...
VERBOSE: 10/22/2023 20:38:17.045 - Available Function Parameter(s) = -ByPercentage:SwitchParameter, -PercentageList:UInt32[], -InputObjectList:Object[], -ContinueOnError:SwitchParameter
VERBOSE: 10/22/2023 20:38:17.046 - Supplied Function Parameter(s) = -ByPercentage:SwitchParameter, -PercentageList:UInt32[], -InputObjectList:Object[], -Verbose:SwitchParameter, -ContinueOnError:SwitchParameter
VERBOSE: 10/22/2023 20:38:17.047 - Execution of Split-ObjectList began on Sunday, October 22, 2023 @ 08:38:17.035 PM
VERBOSE: 10/22/2023 20:38:17.048 - Parameter Set Name: ByPercentage
VERBOSE: 10/22/2023 20:38:18.368 - Input Object List Count: 194081
VERBOSE: 10/22/2023 20:38:18.369 - Attempting to process percentage list entry 1 of 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.369 - Percentage: 5%
VERBOSE: 10/22/2023 20:38:18.371 - Percentage Calculation: 9704
VERBOSE: 10/22/2023 20:38:18.376 - Attempting to process wave 1. Please Wait...
VERBOSE: 10/22/2023 20:38:18.378 - Attempting to add 9704 member(s) to wave 1. Please Wait...
VERBOSE: 10/22/2023 20:38:18.386 - Successfully completed the processing of wave 1.
VERBOSE: 10/22/2023 20:38:18.387 - There are now 184377 objects remaining in the queue.
VERBOSE: 10/22/2023 20:38:18.387 - Attempting to process percentage list entry 2 of 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.388 - Percentage: 10%
VERBOSE: 10/22/2023 20:38:18.389 - Percentage Calculation: 19408
VERBOSE: 10/22/2023 20:38:18.392 - Attempting to process wave 2. Please Wait...
VERBOSE: 10/22/2023 20:38:18.393 - Attempting to add 19408 member(s) to wave 2. Please Wait...
VERBOSE: 10/22/2023 20:38:18.399 - Successfully completed the processing of wave 2.
VERBOSE: 10/22/2023 20:38:18.399 - There are now 164969 objects remaining in the queue.
VERBOSE: 10/22/2023 20:38:18.4 - Attempting to process percentage list entry 3 of 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.401 - Percentage: 15%
VERBOSE: 10/22/2023 20:38:18.401 - Percentage Calculation: 29112
VERBOSE: 10/22/2023 20:38:18.402 - Attempting to process wave 3. Please Wait...
VERBOSE: 10/22/2023 20:38:18.403 - Attempting to add 29112 member(s) to wave 3. Please Wait...
VERBOSE: 10/22/2023 20:38:18.411 - Successfully completed the processing of wave 3.
VERBOSE: 10/22/2023 20:38:18.412 - There are now 135857 objects remaining in the queue.
VERBOSE: 10/22/2023 20:38:18.412 - Attempting to process percentage list entry 4 of 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.413 - Percentage: 20%
VERBOSE: 10/22/2023 20:38:18.413 - Percentage Calculation: 38816
VERBOSE: 10/22/2023 20:38:18.415 - Attempting to process wave 4. Please Wait...
VERBOSE: 10/22/2023 20:38:18.415 - Attempting to add 38816 member(s) to wave 4. Please Wait...
VERBOSE: 10/22/2023 20:38:18.427 - Successfully completed the processing of wave 4.
VERBOSE: 10/22/2023 20:38:18.428 - There are now 97041 objects remaining in the queue.
VERBOSE: 10/22/2023 20:38:18.428 - Attempting to process percentage list entry 5 of 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.429 - Percentage: 25%
VERBOSE: 10/22/2023 20:38:18.429 - Percentage Calculation: 48520
VERBOSE: 10/22/2023 20:38:18.431 - Attempting to process wave 5. Please Wait...
VERBOSE: 10/22/2023 20:38:18.431 - Attempting to add 48520 member(s) to wave 5. Please Wait...
VERBOSE: 10/22/2023 20:38:18.446 - Successfully completed the processing of wave 5.
VERBOSE: 10/22/2023 20:38:18.447 - There are now 48521 objects remaining in the queue.
VERBOSE: 10/22/2023 20:38:18.447 - Attempting to process percentage list entry 6 of 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.448 - Percentage: 25%
VERBOSE: 10/22/2023 20:38:18.448 - Percentage Calculation: 48520
VERBOSE: 10/22/2023 20:38:18.449 - Attempting to process wave 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.45 - Attempting to add 48520 member(s) to wave 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.466 - The 194081 input object(s) could not be divided evenly.
VERBOSE: 10/22/2023 20:38:18.467 - Attempting to add the 1 remaining queue member(s) to wave 6. Please Wait...
VERBOSE: 10/22/2023 20:38:18.467 - New Wave Member Count: 48521
VERBOSE: 10/22/2023 20:38:18.469 - Successfully completed the processing of wave 6.
VERBOSE: 10/22/2023 20:38:18.47 - There are now 0 objects remaining in the queue.
VERBOSE: 10/22/2023 20:38:18.47 - Execution of Split-ObjectList ended on Sunday, October 22, 2023 @ 08:38:18.47 PM
VERBOSE: 10/22/2023 20:38:18.471 - Function execution took 0 hour(s), 0 minute(s), 1 second(s), and 434 millisecond(s)
VERBOSE: 10/22/2023 20:38:18.472 - Function 'Split-ObjectList' is completed.
```

## SAMPLE OUTPUT:

```
Wave        : 1
Percentage  : 5
MemberCount : 9704
Members     : {1, 2, 3, 4...}

Wave        : 2
Percentage  : 10
MemberCount : 19408
Members     : {9705, 9706, 9707, 9708...}

Wave        : 3
Percentage  : 15
MemberCount : 29112
Members     : {29113, 29114, 29115, 29116...}

Wave        : 4
Percentage  : 20
MemberCount : 38816
Members     : {58225, 58226, 58227, 58228...}

Wave        : 5
Percentage  : 25
MemberCount : 48520
Members     : {97041, 97042, 97043, 97044...}

Wave        : 6
Percentage  : 25
MemberCount : 48521
Members     : {145561, 145562, 145563, 145564...}
```
