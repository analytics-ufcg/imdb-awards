 $data =gc .\bestmovies.txt | ConvertFrom-String -tf .\bestmovies.template.txt

 $listOfYears = @()

 foreach ($record in $data.record) {
    
     $nomineesList = @()
     foreach ($nominee in $record.nominees) {
         $nomineesList += $nominee.name -replace "(.)*\|",""      
     }
     $winner = $nomineesList[0]
	 
     $props = @{
        year = $record.year
        winner = $winner
        nominees = $nomineesList 
     }

     $listOfYears += $props       
}
$json = $listOfYears | ConvertTo-Json
$json | Out-File "oscar-best-movies.json"