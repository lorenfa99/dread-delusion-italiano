#requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$TranslationsDir,
    [Parameter(Mandatory = $true)]
    [string]$DestinationDir
)

# Keep the editable TXT files unchanged. Unity TextAsset.text expects UTF-8,
# so only the generated staging copies are normalised before insertion.
$ErrorActionPreference = 'Stop'
$source = (Resolve-Path -LiteralPath $TranslationsDir).Path
$destination = [IO.Path]::GetFullPath($DestinationDir)
if ([string]::Equals($source.TrimEnd('\', '/'), $destination.TrimEnd('\', '/'), [StringComparison]::OrdinalIgnoreCase)) {
    throw 'The staging directory must not be the source translation directory.'
}
$files = @(Get-ChildItem -LiteralPath $source -Filter '*.txt' -File |
    Where-Object { $_.Name -ne 'SHA256SUMS.txt' })
if ($files.Count -eq 0) { throw 'No translation TXT files found.' }
[IO.Directory]::CreateDirectory($destination) | Out-Null
$strictUtf8 = New-Object Text.UTF8Encoding($false, $true)
$outputUtf8 = New-Object Text.UTF8Encoding($false)
$legacy = [Text.Encoding]::GetEncoding(1252)
$converted = 0
foreach ($file in $files) {
    $raw = [IO.File]::ReadAllBytes($file.FullName)
    if ($raw.Length -ge 2 -and (($raw[0] -eq 0xFF -and $raw[1] -eq 0xFE) -or
                              ($raw[0] -eq 0xFE -and $raw[1] -eq 0xFF))) {
        throw "UTF-16/32 TXT is not supported. Save as UTF-8 first: $($file.Name)"
    }
    try {
        $text = $strictUtf8.GetString($raw)
    } catch [Text.DecoderFallbackException] {
        $text = $legacy.GetString($raw)
        $converted++
    }
    if ($text.Length -gt 0 -and $text[0] -eq [char]0xFEFF) { $text = $text.Substring(1) }
    [IO.File]::WriteAllText((Join-Path $destination $file.Name), $text, $outputUtf8)
}
Write-Output "TXT_PREPARED=$($files.Count) LEGACY_TO_UTF8=$converted"
