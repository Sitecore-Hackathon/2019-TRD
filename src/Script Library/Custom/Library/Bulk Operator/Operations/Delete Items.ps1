param($params);
$itemsString = $($params.items);
$items = $itemsString.split('|')

foreach ($itemID in $items) {

    if (-Not ([string]::IsNullOrEmpty($itemID))) {
        $item = Get-Item -Path "master:" -ID $itemID

        if ($item) {
            Remove-Item -Path ('master:' + $item.Paths.FullPath)
            "Item Deleted: " + $item.Paths.FullPath + " (" + $itemID + ")"
        }
    }
}