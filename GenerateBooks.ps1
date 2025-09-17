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

# Create an empty list
$filteredFiles = @()

# Regex pattern to match Markdown image syntax
$imagePattern = '!\[(.*?)\]\((.*?)\)'
$sectionPattern ='(?ms)^#{1,6}'
$admonitionPattern = '(?m)^!!!\s*(\w+)\s+(.*?)\r?\n((?:^(?!\s*$).*\r?\n)*)'


# Get files and directories and filter those starting with a number
$filteredFilesAndFolders = Get-ChildItem -Path $FolderName | Where-Object { $_.Name -match "^\d" } | Sort-Object Name

# Get files and filter those starting with a number for the shared folder
$sharedFilesPost = Get-ChildItem -Path $PostSharedFolder -Filter *.md | Where-Object { $_.Name -match "^\d" } | Sort-Object Name

# Get files and filter those starting with a number for the shared folder
$sharedFilesPre = Get-ChildItem -Path $PreSharedFolder -Filter *.md | Where-Object { $_.Name -match "^\d" } | Sort-Object Name

Write-Host $OutputFolder\$bookName.pdf
Write-Host $BookDefinitionFile
Write-Host "Print Date = " $printDate
$temporaryFiles = @()

    foreach ($item in $filteredFilesAndFolders) {
        if ($item.PSIsContainer) {
            $indexItems = Get-ChildItem -Path $item.FullName -Filter index.md 

            if ($indexItems.Count -eq 0) {
                Write-Warning "The sub folder $($item.FullName) does not contain an index.md file."
            }
            else {
                $filteredFiles += $indexItems
            }
            $subSectionFiles = @()
            $subSectionFiles = Get-ChildItem -Path $item.FullName -Filter *.md | Where-Object { $_.Name -match "^\d" } | Sort-Object Name
            foreach ($subSectionItem in $subSectionFiles) {
                $path = Join-Path  $item.FullName  ("." + $subSectionItem.Name).ToString()
                $folderName = $item.FullName
                # Some Debug here Write-Host $path
                $content = Get-Content $subSectionItem.FullName -Raw
                $updatedContent = [regex]::Replace($content, $admonitionPattern, {
                    param($match)
                    $type = $match.Groups[1].Value
                    $title = $match.Groups[2].Value
                    $body = $match.Groups[3].Value.Trim()
                    #Write-Host "`n::: {$type}`n**$title**`n$body`n:::`n`n"
                    return "`n::: $type`n**$title**`n$body`n:::`n`n"
                })
                # Replace image paths
                $updatedContent2 = [regex]::Replace($updatedContent, $imagePattern, {
                    param($match)
                    $altText = $match.Groups[1].Value
                    $oldPath = $match.Groups[2].Value
                    $fileName = [System.IO.Path]::GetFileName($oldPath)
                    return "![${altText}](${folderName}/images/$fileName)"
                })
                $updatedContent3 = [regex]::Replace($updatedContent2, $sectionPattern, {
                    param($match)
                    $newSectionLevel = "#" + $match.Value
                    return "${newSectionLevel}"
                })

                # $updatedContent | ForEach-Object {
                #     $_ -replace '^#{1,6}', '#$0'
                # } | Set-Content $path
                $updatedContent3  | Set-Content $path

            }

            $processedSubSectionFiles = Get-ChildItem -Path $item.FullName -Filter *.md | Where-Object { $_.Name -match "^\.\d" } | Sort-Object Name
            $temporaryFiles += $processedSubSectionFiles
            $filteredFiles += $processedSubSectionFiles

        } else {
            $path = Join-Path  $item.DirectoryName  ("." + $item.Name).ToString()
            $content = Get-Content $item.FullName -Raw
            $updatedContent = [regex]::Replace($content, $admonitionPattern, {
                param($match)
                $type = $match.Groups[1].Value
                $title = $match.Groups[2].Value
                $body = $match.Groups[3].Value.Trim()
                #Write-Host "`n::: {$type}`n**$title**`n$body`n:::`n`n"
                return "`n::: $type`n**$title**`n$body`n:::`n`n"
            })
            $updatedContent  | Set-Content $path
            #$filteredFiles += $item
        }
    }

    $processedSectionFiles = Get-ChildItem -Path $FolderName -Filter *.md | Where-Object { $_.Name -match "^\.\d" } | Sort-Object Name
    $temporaryFiles += $processedSectionFiles
    $filteredFiles += $processedSectionFiles
# # Generate the LaTeX output when you need to debug the LaTeX input 
# # For example when using some illegal characters
# &pandoc --toc --standalone `
# --metadata date=$printDate `
# --template $PSScriptRoot\templates\eisvogel.tex `
# -o $OutputFolder\$bookName.tex `
# $BookDefinitionFile `
# $filteredFiles.FullName `
# $sharedFiles.FullName

# Write-Host $BookDefinitionFile `
# $sharedFilesPre.FullName `
# $filteredFiles.FullName `
# $sharedFilesPost.FullName

    &pandoc --toc --standalone `
    --metadata date=$printDate `
    --from markdown+fenced_divs `
    --template $PSScriptRoot\templates\eisvogel.tex `
    --lua-filter $PSScriptRoot\templates\admonition.lua `
    --pdf-engine=xelatex `
    -o $OutputFolder\$bookName.pdf `
    $BookDefinitionFile `
    $sharedFilesPre.FullName `
    $filteredFiles.FullName `
    $sharedFilesPost.FullName

    # Clean up temporary files
    foreach ($tempFile in $temporaryFiles) {
        if (Test-Path -Path $tempFile.FullName) {
            # TODO Remove-Item -Path $tempFile.FullName -Force
        }
    }   
#    --filter pandoc-latex-environment `

    Set-Location $location
    $end = Get-Date
    Write-Host "Generating the book $bookName took " ($end - $start).
}



function Find-ForBooks {
    <#
    .SYNOPSIS
        Recursively processes folders to generate books from markdown and YAML definitions.

    .DESCRIPTION
        Finds all sub-folders and YAML book definition files in the specified folder, 
        and calls Convert-Book for each book definition found. 
        Also processes folders in sorted order, allowing for nested book structures.

    .PARAMETER FolderName
        The root folder to search for book folders and definitions.

    .PARAMETER PreSharedFolder
        Path to the folder containing markdown files to be included before book content.

    .PARAMETER PostSharedFolder
        Path to the folder containing markdown files to be included after book content.

    .PARAMETER OutputFolder
        The folder where the generated book outputs will be saved.

    .EXAMPLE
        Find-ForBooks -FolderName "C:\Books\docs" -PreSharedFolder "C:\Books\pre-shared" -PostSharedFolder "C:\Books\post-shared" -OutputFolder "C:\Books\output"
    #>
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

Set-Location $location
$end = Get-Date
Write-Host "Generating the books took " ($end - $start).