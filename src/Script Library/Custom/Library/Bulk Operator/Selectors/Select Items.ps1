param($params);
$rootPath = $($params.path);
$templatesString = $($params.templates);

$templates = $templatesString.split('|')
$root = Get-Item -Path ('master:' + $rootPath)
# Select Items

# Create ordered hashtable to fill with items to display and select
$itemsToSelect = [ordered]@{}

foreach ($item in $root.Axes.GetDescendants()) {
    if ($templatesString.Trim() -eq "" -or $templates.Contains($item.TemplateID.ToString())) {
        $itemsToSelect.Add($item.Name + " (" + $item.Paths.FullPath.ToString() + " - " + $item.ID.ToString() + ")", $item.ID)
    }
}

$props = @{
    Parameters  = @(
        @{Name = "selectedItems"; Title = "Select Items"; Options = $itemsToSelect ; Tooltip = "Filter by items"; Editor = "checklist"} 
    )
    Title       = "Items Select Modal"
    Description = ""
    Width       = 800
    Height      = 600
    ShowHints   = $true
}

$result = Read-Variable @props

if ($result -eq "cancel") {
    exit
}

return $selectedItems