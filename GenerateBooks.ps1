<# 
.SYNOPSIS
    This script is generating the book output on Windows.

.DESCRIPTION 
    This powershell script is generating the book output based on the new structure.
 
.NOTES 
    The new structure will match the topic structure .

.COMPONENT 
    Information about PowerShell Modules to be required.

.LINK 
    Useful Link to resources or others.
 
.Parameter ParameterName 
    Description for a parameter in param definition section. Each parameter requires a separate description. The name in the description and the parameter section must match. 
#>

Param
(
    # Param1 help description
    [Parameter(Mandatory=$false)]
    $Param1
)

function Convert-Book {
    param (
        [string] $FolderName,
        [string] $OutputFolder,
        [string] $PreSharedFolder,
        [string] $PostSharedFolder,
        [string] $BookDefinitionFile 
    )

$start = Get-Date
$location = Get-Location
$printDate = Get-Date -Format "yyyy-MM-dd"

Set-Location $FolderName

$bookName = $BookDefinitionFile
$bookName = $bookName.Replace(".yaml", "").Replace("latex-metadata-", "")
$bookName = Split-Path -Path $bookName -Leaf

# Get files and filter those starting with a number
$filteredFiles = Get-ChildItem -Path $FolderName -Filter *.md | Where-Object { $_.Name -match "^\d" } | Sort-Object Name
# Get files and filter those starting with a number for the shared folder
$sharedFilesPost = Get-ChildItem -Path $PostSharedFolder -Filter *.md | Where-Object { $_.Name -match "^\d" } | Sort-Object Name

# Get files and filter those starting with a number for the shared folder
$sharedFilesPre = Get-ChildItem -Path $PreSharedFolder -Filter *.md | Where-Object { $_.Name -match "^\d" } | Sort-Object Name

Write-Host $OutputFolder\$bookName.pdf
Write-Host $BookDefinitionFile
Write-Host "Print Date = " $printDate

# # Generate the LaTeX output when you need to debug the LaTeX input 
# # For example when using some illegal characters
# &pandoc --toc --standalone `
# --metadata date=$printDate `
# --template $PSScriptRoot\templates\eisvogel.tex `
# -o $OutputFolder\$bookName.tex `
# $BookDefinitionFile `
# $filteredFiles.FullName `
# $sharedFiles.FullName

&pandoc --toc --standalone `
--metadata date=$printDate `
--template $PSScriptRoot\templates\eisvogel.tex `
-o $OutputFolder\$bookName.pdf `
$BookDefinitionFile `
$sharedFilesPre.FullName `
$filteredFiles.FullName `
$sharedFilesPost.FullName

    Set-Location $location
    $end = Get-Date
    Write-Host "Generating the book $bookName took " ($end - $start).
}

function Find-ForBooks {
    param (
        [string] $FolderName,
        [string] $PreSharedFolder,
        [string] $PostSharedFolder,
        [string] $OutputFolder
    )
    # Get folder in the sort order
     $filteredFolders = Get-ChildItem -Path $FolderName -Directory | Where-Object { $_.Name -match "^\d" } | Sort-Object Name
    foreach ($folder in $filteredFolders) {
        Write-Host "Processing folder: $($folder.Name)"
        Find-ForBooks -FolderName $folder.FullName -OutputFolder $OutputFolder -PreSharedFolder $PreSharedFolder -PostSharedFolder $PostSharedFolder
    }
     $bookDefinitions = Get-ChildItem -Path $FolderName  -Filter *.yaml | Sort-Object Name
    foreach ($bookDefinition in $bookDefinitions) {
        Write-Host "Processing book: $($bookDefinition.Name)"
        Convert-Book -FolderName $FolderName -OutputFolder $OutputFolder -BookDefinitionFile $bookDefinition.FullName $PreSharedFolder -PostSharedFolder $PostSharedFolder
    }
}

$start = Get-Date
$location = Get-Location
$folderPath = "$PSScriptRoot\docs"
if (-Not (Test-Path -Path $folderPath)) {
    Write-Error "The folder path '$folderPath' does not exist."
    exit 1
}

$sharedPathPre = "$PSScriptRoot\pre-shared"
if (-Not (Test-Path -Path $sharedPathPre)) {
    Write-Error "The folder path '$sharedPathPre' does not exist."
    exit 1
}

$sharedPathPost = "$PSScriptRoot\post-shared"
if (-Not (Test-Path -Path $sharedPathPost)) {
    Write-Error "The folder path '$sharedPathPost' does not exist."
    exit 1
}


$OutputFolder = "$PSScriptRoot\output"
if (-Not (Test-Path -Path $OutputFolder)) {
    New-Item -Path $OutputFolder  -ItemType Directory
}

Set-Location $folderPath

Find-ForBooks -FolderName $folderPath -PreSharedFolder $sharedPathPre -PostSharedFolder $sharedPathPost -OutputFolder $OutputFolder

# # Get files and filter those starting with a number
# $filteredFiles = Get-ChildItem -Path $folderPath | Where-Object { $_.Name -match "^\d" } | Sort-Object Name

# &pandoc --toc --standalone `
# --template $PSScriptRoot\templates\eisvogel.tex `
# -o $OutputFolder\marvin-Marvin.pdf `
# $PSScriptRoot\latex-metadata-Marvin.yaml `
# $filteredFiles.FullName

Set-Location $location
$end = Get-Date
Write-Host "Generating the books took " ($end - $start).