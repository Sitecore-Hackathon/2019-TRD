param($params);
$root = $($params.root);

# Select Templates  
$templatesToSelect = [ordered] @{}

# Get all templates
$allTemplates = Get-ChildItem -Path 'master:\templates' -Recurse |`
    Where-Object { $_.TemplateName -ne 'Template Folder' `
        -and $_.TemplateName -ne 'Template field' `
        -and $_.TemplateName -ne 'Template section' `
        -and $_.Name -ne '__Standard Values' }

# Add non-sytem templates to ordered hashtable
foreach ($item in $allTemplates) {
    if ($item.Paths.FullPath.Contains("/sitecore/templates/System")) {
        continue;
    }

    $templatesToSelect.Add($item.Paths.FullPath, $item.ID)
}

$propsTemplates = @{
    Parameters  = @(
        @{Name = "templates"; Title = "Select Templates"; Options = $templatesToSelect; Tooltip = "Filter items by template"; Editor = "checklist" } 
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

$argumentList = @{'path'=$($params.path)
                ; 'templates'=[system.String]::Join("|", $templates)};

return $argumentList