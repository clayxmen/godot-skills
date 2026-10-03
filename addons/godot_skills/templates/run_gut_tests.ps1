# PowerShell script to execute GUT unit tests headless
param (
    [string]$GodotPath = "godot",
    [string]$TestDir = "res://test/unit"
)

Write-Host "🚀 Running Headless GUT Test Suite..." -ForegroundColor Cyan

$Args = @(
    "--headless",
    "-s", "addons/gut/gut_cmdln.gd",
    "-gdir=$TestDir",
    "-gexit"
)

& $GodotPath $Args
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ All Tests Passed Successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ GUT Tests Failed with exit code $LASTEXITCODE" -ForegroundColor Red
}
exit $LASTEXITCODE
