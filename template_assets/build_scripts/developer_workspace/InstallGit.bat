@echo off
setlocal

set CURL_OPTIONS=-L --retry 3 --retry-delay 5

git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git not found, downloading and installing the latest version...

    curl %CURL_OPTIONS% -o git_installer.exe https://github.com/git-for-windows/git/releases/latest/download/Git-2.42.0-64-bit.exe

    git_installer.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NOICONS

    timeout /t 30 >nul

    echo Git installed successfully.
) else (
    echo Git is already installed.
)

exit /b
