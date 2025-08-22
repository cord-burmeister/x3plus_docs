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
        [string]$FolderName,
        [string]$OutputFolder,
        [string]$BookDefinitionFile 
    )

    $start = Get-Date
    $location = Get-Location

    Set-Location $FolderName

    $bookName = $BookDefinitionFile
    $bookName = $bookName.Replace(".yaml", "").Replace("latex-metadata-", "")
    $bookName = Split-Path -Path $bookName -Leaf

    # Get files and filter those starting with a number
    $filteredFiles = Get-ChildItem -Path $FolderName -Filter *.md | Where-Object { $_.Name -match "^\d" } | Sort-Object Name
Write-Host $OutputFolder\$bookName.pdf
Write-Host $BookDefinitionFile

&pandoc --toc --standalone --listings `
--template $PSScriptRoot\templates\eisvogel.tex `
-o $OutputFolder\$bookName.pdf `
$BookDefinitionFile `
$filteredFiles.FullName

    Set-Location $location
    $end = Get-Date
    Write-Host "Generating the book $bookName took " ($end - $start).
}


function Find-ForBooks {
    param (
        [string]$FolderName,
        [string]$OutputFolder
    )
    # Get folder in the sort order
     $filteredFolders = Get-ChildItem -Path $FolderName -Directory | Where-Object { $_.Name -match "^\d" } | Sort-Object Name
    foreach ($folder in $filteredFolders) {
        Write-Host "Processing folder: $($folder.Name)"
        Find-ForBooks -FolderName $folder.FullName -OutputFolder $OutputFolder
    }
     $bookDefinitions = Get-ChildItem -Path $FolderName  -Filter *.yaml | Sort-Object Name
    foreach ($bookDefinition in $bookDefinitions) {
        Write-Host "Processing book: $($bookDefinition.Name)"
        Convert-Book -FolderName $FolderName -OutputFolder $OutputFolder -BookDefinitionFile $bookDefinition.FullName
    }

}




$start = Get-Date
$location = Get-Location
$folderPath = "$PSScriptRoot\docs"
if (-Not (Test-Path -Path $folderPath)) {
    Write-Error "The folder path '$folderPath' does not exist."
    exit 1
}


$OutputFolder = "$PSScriptRoot\output"
if (-Not (Test-Path -Path $OutputFolder)) {
    New-Item -Path $OutputFolder  -ItemType Directory
}


Set-Location $folderPath

Find-ForBooks -FolderName $folderPath  -OutputFolder $OutputFolder


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