<#
.SYNOPSIS
    Universal One-Liner Installer for Godot Skills Suite (Windows PowerShell)

.DESCRIPTION
    Installs 25+ Godot Skills and AI Agent Context into any Godot project or globally.

.EXAMPLE
    # Initialize current directory with Clean Architecture + AI Rules:
    pwsh -File install.ps1

    # Install into a specific external project:
    pwsh -File install.ps1 -Target "D:\Games\MyAwesomeRPG"

    # Install globally for all projects on this machine:
    pwsh -File install.ps1 -Global
#>

param (
    [string]$Target = ".",
    [switch]$Global,
    [switch]$Doctor,
    [string]$AddSkill = ""
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$CliScript = Join-Path $ScriptDir "tools\godot_skills_cli.py"

Write-Host "`n===========================================================" -ForegroundColor Cyan
Write-Host "   GODOT SKILLS SUITE (GODOT 4.3+) - UNIVERSAL INSTALLER" -ForegroundColor Cyan
Write-Host "===========================================================`n" -ForegroundColor Cyan

# Check for Python 3
$PythonCmd = ""
if (Get-Command python -ErrorAction SilentlyContinue) {
    $PythonCmd = "python"
} elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    $PythonCmd = "python3"
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    $PythonCmd = "py -3"
}

if (-not $PythonCmd) {
    Write-Host "[!] Python 3 not detected. Running native PowerShell fallback..." -ForegroundColor Yellow
    
    $TargetResolved = (Resolve-Path $Target).Path
    $SkillsSource = Join-Path $ScriptDir "skills"

    if ($Global) {
        $GlobalDest = Join-Path $env:USERPROFILE ".gemini\config\skills"
        New-Item -ItemType Directory -Path $GlobalDest -Force | Out-Null
        Copy-Item -Path "$SkillsSource\*" -Destination $GlobalDest -Recurse -Force
        Write-Host "[+] [PowerShell Fallback] Installed all skills globally to: $GlobalDest" -ForegroundColor Green
    } else {
        $GeminiDest = Join-Path $TargetResolved ".gemini\skills"
        New-Item -ItemType Directory -Path $GeminiDest -Force | Out-Null
        Copy-Item -Path "$SkillsSource\*" -Destination $GeminiDest -Recurse -Force
        Write-Host "[+] [PowerShell Fallback] Installed skills into: $GeminiDest" -ForegroundColor Green
    }
    exit 0
}

# Run via CLI
if ($Global) {
    & $PythonCmd $CliScript "global-sync"
} elseif ($Doctor) {
    & $PythonCmd $CliScript "doctor" "--target" $Target
} elseif ($AddSkill) {
    & $PythonCmd $CliScript "add" $AddSkill "--target" $Target
} else {
    & $PythonCmd $CliScript "init" "--target" $Target
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "[+] Installation and Setup Complete! Enjoy Warning-Free Godot 4 Game Development.`n" -ForegroundColor Green
} else {
    Write-Host "[-] Operation failed with exit code $LASTEXITCODE`n" -ForegroundColor Red
}
exit $LASTEXITCODE
