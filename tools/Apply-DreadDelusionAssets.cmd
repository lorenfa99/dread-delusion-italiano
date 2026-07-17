@echo off
setlocal
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -File "%~dp0Apply-DreadDelusionAssets.ps1" %*
if errorlevel 1 (
    echo.
    echo Installazione non riuscita. Leggi il messaggio precedente.
    pause
    exit /b 1
)
echo.
echo Installazione completata correttamente.
pause
