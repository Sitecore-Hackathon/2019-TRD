param($params);
$itemsString = $($params.items);
$items = $itemsString.split('|')


$propsPath = @{
    Parameters  = @(
        @{Name = "targetParent"; Title = "Select Target Path"; Options = 'master:\content'; Tooltip = "Select target path to copy items to"; Editor = "droptree" } 
    )
    Title       = "Target Path Select Modal"
    Description = ""
    Width       = 800
    Height      = 600
    ShowHints   = $true    
}

$result = Read-Variable @propsPath 

if ($result -eq "cancel") {
    exit
}

$targetParent

foreach ($itemID in $items) {
    $sourceItem = Get-Item -Path master: -ID $itemID;
    If($sourceItem -eq $null){
        continue
     }
    Copy-Item -Path ('master:' + $sourceItem.Paths.FullPath) -Destination ("{0}/{1}" -f ('master:' + $targetParent.Paths.FullPath), $sourceItem.Name);
}
