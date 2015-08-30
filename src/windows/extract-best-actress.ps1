$data =gc .\bestactress.txt | ConvertFrom-String -tf .\bestactors.template.txt

$listOfYears = @()


 foreach ($record in $data) {
    
 
    $nominees = $record.nominees
    foreach ($nominee in $nominees) {
        $nominee.movie = $nominee.movie -replace "(.)*\|(\'\'\[\[)?",""      
    }
        	 
     $props = @{
        year = $record.year
        winner = $record.winner
        winnerMovie = $record.winnerMovie -replace "(.)*\|(\'\'\[\[)?",""
        nominees = $nominees       
     }

     $listOfYears += $props       
}
$json = $listOfYears | ConvertTo-Json
$json | Out-File "oscar-best-actress.json"