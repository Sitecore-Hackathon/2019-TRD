$argumentList = @{'path'='master:\content'
                ; 'templates'=''};

while($true){
    
    $operationsList = @{}

    # Get all possible operations
    $operationItems = Get-ChildItem -Path master: -ID '{B4FA2464-1AD3-43BC-87CB-24477C37A54D}'
    foreach ($item in $operationItems) {
        $item.Name
        $operationsList.Add($item.Name, $item.ID.ToString())
    }

    $propsTemplates = @{
        Parameters  = @(
            @{Name = "selectedOperation"; Title = "Select Operation"; Options = $operationsList; Tooltip = "Select operation to perform on filtered items"; } 
        )
        Title       = "Templates Select Modal"
        Description = ""
        Width       = 800
        Height      = 600
        ShowHints   = $true
    }

    $result = Read-Variable @propsTemplates 

    if ($result -eq "cancel") {
        exit
    }


    $argumentList = Invoke-Script '/sitecore/system/Modules/PowerShell/Script Library/Custom/Library/Bulk Operator/Selectors/Select Path' -argumentList $argumentList
    $argumentList
    
    $argumentList = Invoke-Script '/sitecore/system/Modules/PowerShell/Script Library/Custom/Library/Bulk Operator/Selectors/Select Templates' -argumentList $argumentList
    $argumentList
    
    $items = Invoke-Script '/sitecore/system/Modules/PowerShell/Script Library/Custom/Library/Bulk Operator/Selectors/Select Items' -argumentList $argumentList
    $items
    
    $itemsList = @{'items'= [system.String]::Join("|", $items)};
    
    $argumentList = Invoke-Script $selectedOperation -argumentList $itemsList
    
    $result = Show-Confirm -Title "Do you want to perform another operation?"

    if($result -eq 'no'){
        exit
    }
}