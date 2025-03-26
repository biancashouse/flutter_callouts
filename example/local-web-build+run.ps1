function localWebRun {
    try {
        & flutter build web --release -t lib/main.dart
    }
    catch {
        Write-Host "flutter build web failed: $_"
        exit 1
    }

    try {
        & python -m http.server 55555
    }
    catch {
        Write-Host "launching python web server failed: $_"
        exit 1
    }
}

# can start from any project directory
$startDir = (Get-Location).Path
# dir contains the pubspec file)
while (-not (Test-Path "pubspec.yaml")) {
    Set-Location ".."
}

Set-Location "build/web"
localWebRun
Set-Location $startDir
