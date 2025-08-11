# x3plus_docs

This is the project documentation for the x3plus project.

## Introduction

This is the source for a collection of booklets which describe the journey exploring the robot space.

## Build the books

### Install required tools on Windows

To generate the books as PDF the following tools are required.

``` CMD
choco install vscode -y
choco install git -y
choco install miktex -y
choco install pandoc -y
choco install powershell-core -y
choco install plantuml -y
```

### Generate the books

Use the powershell script to generate the PDFs

``` CMD
GenerateBooks.ps1
```

## Github Pages

[Github Pages](https://cord-burmeister.github.io/x3plus_docs/)
