# Split-ObjectList

## SYNOPSIS
Provides the functionality to split a list of objects into chunks based on the specified mode.

## SYNTAX

```
Split-ObjectList [-ByPercentage] -PercentageList <UInt32[]> -InputObjectList <Object[]> [-ContinueOnError]
 [<CommonParameters>]
```

## DESCRIPTION
Slightly more detailed description of what your function does

## EXAMPLES

### EXAMPLE 1
```
$SplitObjectListResult = Split-ObjectList -ByPercentage -PercentageList @(5, 10, 15, 20, 25, 25) -InputObjectList (1..200000) -Verbose

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
	$SplitObjectListParameters.InputObjectList = 1..200000
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

## NOTES
This is the more performant way of breaking an object into chunks for various use cases.
Most of the time, various "List" type objects are used with index removal and so forth, which can work, but is not ideal.

## RELATED LINKS

[https://stackoverflow.com/questions/56990719/split-array-by-percentage](https://stackoverflow.com/questions/56990719/split-array-by-percentage)

[https://www.infoworld.com/article/3666499/how-to-work-with-a-priority-queue-in-net-6.html](https://www.infoworld.com/article/3666499/how-to-work-with-a-priority-queue-in-net-6.html)

