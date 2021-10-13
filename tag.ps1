$versions = @()
Get-Content full_tag_list.json `
| jq '.[].ref' `
| ForEach-Object {$_ -replace '"',''} `
| ForEach-Object {$_ -split "/"} `
| Select-String -Pattern "^v0.0" `
| ForEach-Object {$_ -match "v\d.\d.(?<version>.+)" | Out-Null; $versions += $Matches.version} 

$latest = ($versions `
| Where-Object -FilterScript { $_ -gt 99 } `
| Where-Object -FilterScript { $_ -lt 200 } `
| Measure-Object).Maximum

if($latest -eq 199) {
  Write-Output "No new minor versions available"
  exit 1;
}
elseif($latest -eq $NULL) {
  $latest = 100
}

$latest++
$tag = "v0.0" + "." + $latest.ToString()
echo $tag




# $appropriate

# foreach($tag in $tags) {
#     $tag -match "v\d.\d.(?<version>.+)" | Out-Null
#     $versions += $Matches.version
# }
# $versions | Where-Object -FilterScript { $_ -lt 22 }
