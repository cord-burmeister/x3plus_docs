<#
     CreateRelease.ps1
     -----------------
     This script creates a GitHub release and uploads files from a specified source directory using the GitHub CLI (`gh`).

     PARAMETERS:
          -ReleaseTag      The tag name for the release (e.g., 2025-09-30)
          -ReleaseNotes    The release notes or description
          -SourceLocation  The folder containing files to upload to the release

     USAGE EXAMPLE:
          .\CreateRelease.ps1 -ReleaseTag "2025-09-30" -ReleaseNotes "First Version" -sourceLocation "C:\path\to\files"

     REQUIREMENTS:
          - GitHub CLI (`gh`) must be installed and authenticated (run `gh auth login` first)
          - You must have permission to create releases in the target repository
#>
param (
     [string] $ReleaseTag = "",
     [string] $ReleaseNotes = "Update to Books",
     [string] $SourceLocation = "$PSScriptRoot\..\output"
)

$location = Get-Location
Set-Location $PSScriptRoot
$releaseTag = $ReleaseTag.Trim()

if (-not $ReleaseTag) {
    # String is empty, null, or only whitespace
    $releaseTag  = Get-Date -Format "yyyy-MM-dd"
}

Write-Host "Creating release with tag: $releaseTag"
Write-Host "Using source location: $SourceLocation"

&gh auth status

if ($?) {
     $files = Get-ChildItem -Path $SourceLocation -File  -Filter "*.pdf" | Where-Object { -not ($_.Name -like '*Draft*') }     
     gh release create $releaseTag -t $releaseTag -n $ReleaseNotes
     foreach ($file in $files) {
          Write-Host $file
          gh release upload $releaseTag "$SourceLocation\$file"
     }
} else {
     Write-Error "gh is not logged in Github. Perform gh auth login."
     Exit 1
}

Set-Location $location