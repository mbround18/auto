Write-Output "::group::Parse Version"

$File = "/tmp/auto.out"
$Version = ""

function parse {
  param (
   $File,
    $Pattern,
    $SubPattern
  )
  $FileContent = (Select-String $File -Context 2 -Pattern $Pattern)
  return $FileContent | Out-String | Select-String -Pattern $SubPattern
}

$Options = @( @{
  Pattern = "Published canary"
  SubPattern = "version:"
  Matcher = "Published canary version: (.+)"
},@{
  Pattern = "Created GitHub release"
  SubPattern = "tag:"
  Matcher = "Creating release on GitHub for tag: (v.+)"
})

$Options | ForEach-Object {
  $Out = parse -File $File -Pattern $_.Pattern -SubPattern $_.SubPattern
  if ($Out -match $_.Matcher) {
    $Revision = ($Matches[1] | Out-String)
    if ($_.Prefix) {
      $Version = $_.Prefix + $Revision
    } else {
      $Version = $Revision
    }
  }
}
Write-Output "Version=$Version"
Write-Output "version=$Version" >> $GITHUB_OUTPUT
Write-Output "::endgroup::"