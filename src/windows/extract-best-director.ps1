$data = gc bestdirector.txt | ConvertFrom-String -tf bestdirector.template.txt

$listOfYears = @()


 foreach ($record in $data) {
    
 
    $nominees = $record.nomineesList.Items
    foreach ($nominee in $nominees) {
        $nominee.movie = $nominee.movie -replace "(.)*\|(\'\'\[\[)?",""      
    }
        	 
     $props = @{
        year = $record.year
        winner = $record.best.name
        winnerMovie = $record.best.movie -replace "(.)*\|(\'\'\[\[)?",""
        nominees = $nominees       
     }

     $listOfYears += $props       
}
$json = $listOfYears | ConvertTo-Json
$json | Out-File "oscar-best-director.json"