# claude-init installer for Windows
# https://github.com/Flexonze/claude-init

$ErrorActionPreference = "Stop"

function Write-Info {
    param([string]$Message)
    Write-Host "==> " -ForegroundColor Blue -NoNewline
    Write-Host $Message
}

function Write-Success {
    param([string]$Message)
    Write-Host "==> " -ForegroundColor Green -NoNewline
    Write-Host $Message
}

Write-Info "Installing claude-init..."

$CommandsDir = Join-Path $env:USERPROFILE ".claude\commands"
$TargetFile = Join-Path $CommandsDir "claude-init.md"
$SourceUrl = "https://raw.githubusercontent.com/Flexonze/claude-init/main/claude-init.md"

# Create directory
Write-Info "Creating $CommandsDir..."
try {
    New-Item -ItemType Directory -Path $CommandsDir -Force | Out-Null
} catch {
    Write-Host "Error: Failed to create directory - $_" -ForegroundColor Red
    exit 1
}

# Download file
Write-Info "Downloading claude-init.md..."
try {
    Invoke-WebRequest -Uri $SourceUrl -OutFile $TargetFile -UseBasicParsing
} catch {
    Write-Host "Error: Failed to download claude-init.md - $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Success "/claude-init installed successfully!"
Write-Host ""
Write-Host "╭─────────────────────────────────╮" -ForegroundColor Blue
Write-Host "│" -ForegroundColor Blue -NoNewline; Write-Host "  Usage:                         " -NoNewline; Write-Host "│" -ForegroundColor Blue
Write-Host "│" -ForegroundColor Blue -NoNewline; Write-Host "    cd path/to/your/project      " -NoNewline; Write-Host "│" -ForegroundColor Blue
Write-Host "│" -ForegroundColor Blue -NoNewline; Write-Host "    claude /claude-init          " -NoNewline; Write-Host "│" -ForegroundColor Blue
Write-Host "╰─────────────────────────────────╯" -ForegroundColor Blue
Write-Host ""
