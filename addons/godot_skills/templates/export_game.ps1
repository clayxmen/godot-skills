param (
    [string]$Preset = "Windows Desktop",
    [string]$OutputPath = "build/windows/GodotGame.exe"
)

Write-Host "🚀 Exporting Godot 4 Release for [$Preset]..." -ForegroundColor Cyan

$OutDir = Split-Path $OutputPath
if (-not (Test-Path $OutDir)) {
    New-Item -ItemType Directory -Path $OutDir | Out-Null
}

$Args = @(
    "--headless",
    "--export-release",
    "$Preset",
    "$OutputPath"
)

& "godot" $Args
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Export Completed Successfully -> $OutputPath" -ForegroundColor Green
} else {
    Write-Host "❌ Export Failed with code $LASTEXITCODE" -ForegroundColor Red
}
exit $LASTEXITCODE
