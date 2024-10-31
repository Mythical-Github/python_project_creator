@echo off

set "jq_path=%~dp0jq.exe"
set "jq_url=https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-win64.exe"

:: Check if jq.exe is in the same directory as the batch file
if not exist "%jq_path%" (
    echo jq.exe not found. Downloading jq...
    powershell -command "Invoke-WebRequest -Uri %jq_url% -OutFile '%jq_path%'"
    
    if not exist "%jq_path%" (
        echo Failed to download jq. Exiting.
        exit /b 1
    )
    echo jq.exe downloaded successfully.
)

exit /b 0