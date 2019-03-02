param($params);
$templatesString = $($params.templates);

# Select Path
$propsPath = @{
    Parameters = @(
         @{Name="root"; Title="Select Path"; Options='master:\content'; Tooltip="Filter by path"; Editor="droptree" } 
    )
    Title = "Path Select Modal"
    Description = ""
    Width = 800
    Height = 600
    ShowHints = $true    
}

$result = Read-Variable @propsPath 

if($result -eq "cancel"){
    exit
}

$returnPath = $($params.Path)
if($root -ne $null){
$returnPath = $root.Paths.FullPath
}

$argumentList = @{'path'=$returnPath
                ; 'templates'=$templatesString};

return $argumentList