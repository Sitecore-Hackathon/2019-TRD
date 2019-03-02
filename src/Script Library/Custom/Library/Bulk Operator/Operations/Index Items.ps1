param($params);
$itemsString = $($params.items);
$items = $itemsString.split('|')


$options = @{}
[Sitecore.ContentSearch.ContentSearchManager]::Indexes | Foreach-Object { 
    $options.Add($_.Name, $_.Name) 
}

$propsIndex = @{
    Parameters  = @(
        @{Name = "indexName"; Title = "Choose an index"; Options = $options; Tooltip = "Select an index to rebuild the selected items in"}
    )
    Title       = "Index Select Modal"
    Description = ""
    Width       = 800
    Height      = 600
    ShowHints   = $true
}

$result = Read-Variable @propsIndex

if ($result -eq "cancel") {
    exit
}

$index = [Sitecore.ContentSearch.ContentSearchManager]::GetIndex($indexName)

foreach ($itemId in $items) {
    $item = Get-Item -Path master: -ID $itemId
    [Sitecore.ContentSearch.Maintenance.IndexCustodian]::Refresh($index, [Sitecore.ContentSearch.SitecoreIndexableItem]$item)
}
