$versions = @()
Get-Content full_tag_list.json `
| jq '.[].ref' `
| ForEach-Object {$_ -replace '"',''} `
| ForEach-Object {$_ -split "/"} `
| Select-String -Pattern "^v0.0" `
| ForEach-Object {$_ -match "v\d.\d.(?<version>.+)" | Out-Null; $versions += $Matches.version} 
$versions | Where-Object -FilterScript { $_ -gt 1 }









# $appropriate

# foreach($tag in $tags) {
#     $tag -match "v\d.\d.(?<version>.+)" | Out-Null
#     $versions += $Matches.version
# }
# $versions | Where-Object -FilterScript { $_ -lt 22 }
