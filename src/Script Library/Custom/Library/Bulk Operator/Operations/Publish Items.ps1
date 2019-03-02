param($params);
$itemsString = $($params.items);
$items = $itemsString.split('|')

foreach($itemId in $items){
    $item = Get-Item -Path master: -ID $itemID;

    # TODO prompt user to select target & language
   Publish-Item -Path ('master:' + $item.Paths.FullPath) $itemId -Target Internet -PublishMode Full
}