#requires -Version 5.1
[CmdletBinding()]
param(
    [Alias('Path')]
    [string]$ResourcesAssets = '',
    [string]$GameDataDir = '',
    [string]$TranslationsDir = '',
    [string]$FontPng = '',
    [switch]$NoPrompt
)

$ErrorActionPreference = 'Stop'
$releaseDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$toolsDir = Join-Path $releaseDir 'DreadDelusion-AssetTools'
$patcher = Join-Path $toolsDir 'dread_patch.dll'
$verifier = Join-Path $toolsDir 'verify_patch.dll'
$classData = Join-Path $toolsDir 'classdata.tpk'
$prepareTexts = Join-Path $releaseDir 'Prepare-DreadDelusionTexts.ps1'
$bundledFont = Join-Path $toolsDir 'LiberationSans SDF Atlas-resources.assets-16.png'
if ([string]::IsNullOrWhiteSpace($TranslationsDir)) {
    $repositoryTranslations = Join-Path (Split-Path -Parent $releaseDir) 'translations'
    if (Test-Path -LiteralPath $repositoryTranslations -PathType Container) {
        $TranslationsDir = (Resolve-Path -LiteralPath $repositoryTranslations).Path
    } else {
        $TranslationsDir = $releaseDir
    }
}
$temp = Join-Path ([IO.Path]::GetTempPath()) ('DreadDelusion-resources.assets-' + [Guid]::NewGuid().ToString('N'))
$textStage = Join-Path ([IO.Path]::GetTempPath()) ('DreadDelusionAssetTextStage-' + [Guid]::NewGuid().ToString('N'))

function Require-File([string]$FilePath, [string]$Description) {
    if (-not (Test-Path -LiteralPath $FilePath -PathType Leaf)) {
        throw "$Description non trovato: $FilePath"
    }
}

function Convert-ToResourcesAssetsPath([string]$SelectedPath) {
    if ([string]::IsNullOrWhiteSpace($SelectedPath)) {
        return ''
    }
    $SelectedPath = $SelectedPath.Trim().Trim('"')
    if (Test-Path -LiteralPath $SelectedPath -PathType Container) {
        $SelectedPath = Join-Path $SelectedPath 'resources.assets'
    }
    return $SelectedPath
}

function Get-SteamRoots {
    $roots = New-Object System.Collections.Generic.List[string]
    foreach ($candidate in @(
        (Join-Path ([Environment]::GetFolderPath('ProgramFilesX86')) 'Steam'),
        (Join-Path ([Environment]::GetFolderPath('ProgramFiles')) 'Steam'),
        'C:\Steam'
    )) {
        if (-not [string]::IsNullOrWhiteSpace($candidate) -and
            (Test-Path -LiteralPath $candidate -PathType Container)) {
            $roots.Add($candidate)
        }
    }
    try {
        $registrySteam = (Get-ItemProperty -LiteralPath 'HKCU:\Software\Valve\Steam' -Name SteamPath -ErrorAction Stop).SteamPath
        if ($registrySteam -and (Test-Path -LiteralPath $registrySteam -PathType Container)) {
            $roots.Add($registrySteam)
        }
    } catch {
        # Steam may not be registered for the current Windows user.
    }

    $allRoots = New-Object System.Collections.Generic.List[string]
    foreach ($root in @($roots | Select-Object -Unique)) {
        $allRoots.Add($root)
        $libraryFile = Join-Path $root 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $libraryFile -PathType Leaf) {
            foreach ($line in Get-Content -LiteralPath $libraryFile -ErrorAction SilentlyContinue) {
                if ($line -match '^\s*"path"\s+"([^"]+)"') {
                    $libraryRoot = $Matches[1] -replace '\\\\', '\'
                    if (Test-Path -LiteralPath $libraryRoot -PathType Container) {
                        $allRoots.Add($libraryRoot)
                    }
                }
            }
        }
    }
    return @($allRoots | Select-Object -Unique)
}

function Get-InstalledResourcesCandidates {
    $found = New-Object System.Collections.Generic.List[string]
    foreach ($steamRoot in Get-SteamRoots) {
        $candidate = Join-Path $steamRoot 'steamapps\common\Dread Delusion\windows_content\Dread Delusion_Data\resources.assets'
        if (Test-Path -LiteralPath $candidate -PathType Leaf) {
            $found.Add((Resolve-Path -LiteralPath $candidate).Path)
        }
    }
    return @($found | Select-Object -Unique)
}

function Select-ResourcesAssetsFile([string]$InitialDirectory = '') {
    try {
        Add-Type -AssemblyName System.Windows.Forms
        $dialog = New-Object System.Windows.Forms.OpenFileDialog
        $dialog.Title = 'Seleziona il file resources.assets di Dread Delusion'
        $dialog.Filter = 'Unity resources.assets|resources.assets|Tutti i file|*.*'
        $dialog.FileName = 'resources.assets'
        $dialog.CheckFileExists = $true
        if ($InitialDirectory -and (Test-Path -LiteralPath $InitialDirectory -PathType Container)) {
            $dialog.InitialDirectory = $InitialDirectory
        }
        if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            return $dialog.FileName
        }
    } catch {
        Write-Warning 'Impossibile aprire la finestra di selezione del file.'
    }
    $manualPath = Read-Host 'Incolla il percorso completo di resources.assets (oppure della cartella Dread Delusion_Data)'
    return Convert-ToResourcesAssetsPath $manualPath
}

function Resolve-TargetResourcesAssets {
    if (-not [string]::IsNullOrWhiteSpace($ResourcesAssets)) {
        return Convert-ToResourcesAssetsPath $ResourcesAssets
    }
    if (-not [string]::IsNullOrWhiteSpace($GameDataDir)) {
        return Convert-ToResourcesAssetsPath $GameDataDir
    }

    $candidates = @(Get-InstalledResourcesCandidates)
    if ($candidates.Count -eq 1) {
        Write-Host 'Installazione di Dread Delusion rilevata:' -ForegroundColor Cyan
        Write-Host "  $($candidates[0])"
        if ($NoPrompt) {
            return $candidates[0]
        }
        $answer = Read-Host 'Premi INVIO per usare questo file, oppure digita S per selezionarne un altro'
        if ($answer -notmatch '(?i)^s$') {
            return $candidates[0]
        }
        return Select-ResourcesAssetsFile (Split-Path -Parent $candidates[0])
    }

    if ($candidates.Count -gt 1) {
        Write-Host 'Sono state trovate più installazioni di Dread Delusion:' -ForegroundColor Cyan
        for ($index = 0; $index -lt $candidates.Count; $index++) {
            Write-Host "  $($index + 1)) $($candidates[$index])"
        }
        if ($NoPrompt) {
            throw 'Più file resources.assets rilevati. Specificane uno con -ResourcesAssets.'
        }
        $selection = Read-Host 'Digita il numero da usare, oppure S per aprire la finestra di selezione'
        if ($selection -match '^\d+$') {
            $chosen = [int]$selection
            if ($chosen -ge 1 -and $chosen -le $candidates.Count) {
                return $candidates[$chosen - 1]
            }
        }
        return Select-ResourcesAssetsFile
    }

    if ($NoPrompt) {
        throw 'Dread Delusion non è stato rilevato. Specifica il file con -ResourcesAssets.'
    }
    Write-Host 'Dread Delusion non è stato rilevato automaticamente.' -ForegroundColor Yellow
    Write-Host 'Seleziona: Dread Delusion\windows_content\Dread Delusion_Data\resources.assets'
    return Select-ResourcesAssetsFile
}

try {
    $target = Resolve-TargetResourcesAssets
    Require-File $target 'resources.assets del gioco'
    $target = (Resolve-Path -LiteralPath $target).Path
    if ([IO.Path]::GetFileName($target) -ne 'resources.assets') {
        Write-Warning "Il file selezionato non si chiama resources.assets: $target"
    }

    Write-Host ''
    Write-Host 'File che verrà aggiornato:' -ForegroundColor Cyan
    Write-Host "  $target"

    Require-File $patcher 'Patcher degli asset'
    Require-File $verifier 'Validatore degli asset'
    Require-File $classData 'Database delle classi Unity'
    Require-File $prepareTexts 'Preparatore UTF-8 dei testi'

    $txtFiles = @(Get-ChildItem -LiteralPath $TranslationsDir -Filter '*.txt' -File |
        Where-Object { $_.Name -ne 'SHA256SUMS.txt' })
    if ($txtFiles.Count -eq 0) {
        throw "Nessun file di traduzione .txt trovato in $TranslationsDir"
    }

    New-Item -ItemType Directory -Path $textStage -Force | Out-Null
    & $prepareTexts -TranslationsDir $TranslationsDir -DestinationDir $textStage

    if ([string]::IsNullOrWhiteSpace($FontPng)) {
        $fontCandidates = @(Get-ChildItem -LiteralPath $releaseDir -Filter 'LiberationSans SDF Atlas-resources.assets-*.png' -File)
        $preferred = @($fontCandidates | Where-Object { $_.Name -eq 'LiberationSans SDF Atlas-resources.assets-16.png' })
        if ($preferred.Count -gt 0) {
            $FontPng = $preferred[0].FullName
        } elseif ($fontCandidates.Count -eq 1) {
            $FontPng = $fontCandidates[0].FullName
        } elseif ($fontCandidates.Count -gt 1) {
            $FontPng = ($fontCandidates | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName
            Write-Warning "Trovati più font compatibili; verrà usato il più recente: $FontPng"
        } elseif (Test-Path -LiteralPath $bundledFont -PathType Leaf) {
            $FontPng = $bundledFont
        } else {
            throw 'Font italiano non trovato. Inserisci il PNG nella cartella della release oppure usa -FontPng.'
        }
    }
    Require-File $FontPng 'Font PNG'

    $running = @(Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -match '(?i)dread' })
    if ($running.Count -gt 0) {
        throw 'Dread Delusion sembra essere in esecuzione. Chiudilo e riprova.'
    }

    $dotnetCommand = Get-Command dotnet.exe -ErrorAction SilentlyContinue
    if (-not $dotnetCommand) {
        $fallbackDotnet = 'C:\Program Files\dotnet\dotnet.exe'
        Require-File $fallbackDotnet 'Runtime .NET'
        $dotnet = $fallbackDotnet
    } else {
        $dotnet = $dotnetCommand.Source
    }

    $native = Join-Path $toolsDir 'runtimes\win-x64\native'
    if (Test-Path -LiteralPath $native -PathType Container) {
        $env:PATH = $native + ';' + $env:PATH
    }

    Write-Host ''
    Write-Host 'Creazione del nuovo resources.assets...' -ForegroundColor Cyan
    & $dotnet $patcher $target $textStage $classData $FontPng $temp
    if ($LASTEXITCODE -ne 0) {
        throw "Il patcher è terminato con il codice $LASTEXITCODE"
    }

    Write-Host 'Verifica del file prima dell’installazione...' -ForegroundColor Cyan
    & $dotnet $verifier $temp $textStage $classData $FontPng
    if ($LASTEXITCODE -ne 0) {
        throw "La verifica del nuovo file è terminata con il codice $LASTEXITCODE"
    }

    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backup = "$target.italian-backup-$stamp"
    Copy-Item -LiteralPath $target -Destination $backup -ErrorAction Stop
    Copy-Item -LiteralPath $temp -Destination $target -Force -ErrorAction Stop

    Write-Host 'Verifica del resources.assets installato...' -ForegroundColor Cyan
    & $dotnet $verifier $target $textStage $classData $FontPng
    if ($LASTEXITCODE -ne 0) {
        throw "La verifica finale non è riuscita. Ripristina il backup: $backup"
    }

    Write-Host ''
    Write-Host 'TRADUZIONE INSTALLATA CORRETTAMENTE.' -ForegroundColor Green
    Write-Host "Backup creato: $backup"
}
catch {
    Write-Host ''
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host 'Se il file si trova sotto Program Files e l’accesso viene negato, avvia il .cmd come amministratore.' -ForegroundColor Yellow
    exit 1
}
finally {
    if (Test-Path -LiteralPath $temp) {
        Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue
    }
    if (Test-Path -LiteralPath $textStage) {
        # Resolve and constrain the recursive cleanup to this invocation's temp folder.
        $resolvedStage = (Resolve-Path -LiteralPath $textStage).Path
        $resolvedTempRoot = (Resolve-Path -LiteralPath ([IO.Path]::GetTempPath())).Path.TrimEnd('\', '/')
        $stageParent = (Split-Path -Parent $resolvedStage).TrimEnd('\', '/')
        $stageLeaf = Split-Path -Leaf $resolvedStage
        $stageInfo = Get-Item -LiteralPath $resolvedStage
        $isOwnedStage = [string]::Equals($stageParent, $resolvedTempRoot, [StringComparison]::OrdinalIgnoreCase) -and
            $stageLeaf -match '^DreadDelusionAssetTextStage-[0-9a-f]{32}$' -and
            ($stageInfo.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0
        if ($isOwnedStage) {
            Remove-Item -LiteralPath $resolvedStage -Recurse -Force -ErrorAction SilentlyContinue
        } else {
            Write-Warning 'Temporary text folder was not removed because its resolved path was unexpected.'
        }
    }
}
