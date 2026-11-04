# My-Neovim-Config installation script (Windows / PowerShell)
# Copies init.lua to %LOCALAPPDATA%\nvim (backs up the existing one)

$ErrorActionPreference = "Stop"

$ConfigDir = Join-Path $env:LOCALAPPDATA "nvim"
$InitSrc   = Join-Path $PSScriptRoot "init.lua"
$InitDest  = Join-Path $ConfigDir "init.lua"

Write-Host "My-Neovim-Config Installation (Windows)"
Write-Host "======================================="

function Test-Cmd($name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }

# --- Required tools ---
foreach ($tool in @("nvim", "git")) {
    if (-not (Test-Cmd $tool)) {
        Write-Error "Error: '$tool' not found. Install it, e.g.: winget install $(if ($tool -eq 'nvim') {'Neovim.Neovim'} else {'Git.Git'})"
        exit 1
    }
}

# C compiler (tree-sitter parsers)
if (-not ((Test-Cmd "gcc") -or (Test-Cmd "clang") -or (Test-Cmd "zig") -or (Test-Cmd "cl"))) {
    Write-Warning "No C compiler found (gcc/clang/zig/cl). tree-sitter parsers need one. e.g.: winget install zig.zig"
}

# make or cmake (telescope-fzf-native)
if (-not ((Test-Cmd "make") -or (Test-Cmd "cmake"))) {
    Write-Warning "Neither make nor cmake found. telescope-fzf-native will be skipped. e.g.: winget install Kitware.CMake"
}

# Go (gopls via Mason)
if (-not (Test-Cmd "go")) {
    Write-Warning "go not found. gopls cannot be installed by Mason. e.g.: winget install GoLang.Go"
}

# --- Nerd Font ---
function Test-NerdFont {
    $dirs = @("$env:LOCALAPPDATA\Microsoft\Windows\Fonts", "$env:WINDIR\Fonts")
    foreach ($d in $dirs) {
        if ((Test-Path $d) -and (Get-ChildItem $d -Filter "*Nerd*" -ErrorAction SilentlyContinue)) { return $true }
    }
    return $false
}

if (-not (Test-NerdFont)) {
    Write-Host "Nerd Font is Not Found"
    $answer = Read-Host "Do want install Nerd Font [y/n]"
    if ($answer -ne "y") { exit 1 }

    $tmp = Join-Path $env:TEMP "JetBrainsMonoNF"
    New-Item -ItemType Directory -Force $tmp | Out-Null
    $zip = Join-Path $tmp "JetBrainsMono.zip"
    Invoke-WebRequest "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" -OutFile $zip
    Expand-Archive $zip -DestinationPath $tmp -Force

    $fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
    New-Item -ItemType Directory -Force $fontDir | Out-Null
    $reg = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
    Get-ChildItem $tmp -Filter "*.ttf" | ForEach-Object {
        $dest = Join-Path $fontDir $_.Name
        Copy-Item $_.FullName $dest -Force
        New-ItemProperty -Path $reg -Name "$($_.BaseName) (TrueType)" -Value $dest -PropertyType String -Force | Out-Null
    }
    Remove-Item $tmp -Recurse -Force
    Write-Host "Font installed. Set 'JetBrainsMono Nerd Font' in your terminal settings."
}

# --- Config ---
if (-not (Test-Path $ConfigDir)) {
    Write-Host "Creating: $ConfigDir"
    New-Item -ItemType Directory -Force $ConfigDir | Out-Null
} else {
    Write-Host "Directory exists: $ConfigDir"
}

if (Test-Path $InitDest) {
    $backup = "$InitDest.backup.$(Get-Date -Format yyyyMMdd_HHmmss)"
    Write-Host "Backing up: $InitDest -> $backup"
    Copy-Item $InitDest $backup
}

Write-Host "Copying: $InitSrc -> $InitDest"
Copy-Item $InitSrc $InitDest -Force

Write-Host ""
Write-Host "Installation complete!"
Write-Host "Open Neovim and run :Lazy sync to install plugins."
