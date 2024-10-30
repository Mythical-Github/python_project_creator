@echo off
setlocal

set "project_name=UnrealAutoModCLI"

:: Determine the script directory
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"  :: Remove trailing backslash

:: Set paths for new and old executable
set "NEW_EXE=%SCRIPT_DIR%\dist\__main__.exe"
set "ASSETS_DIR=%SCRIPT_DIR%\.."
set "OLD_EXE=%ASSETS_DIR%\base\%project_name%.exe"

:: Check and delete old executable if it exists
if exist "%OLD_EXE%" (
    echo Deleting old executable: "%OLD_EXE%"
    del "%OLD_EXE%"
)

:: Check and copy new executable if it exists
if exist "%NEW_EXE%" (
    echo Copying new executable to "%OLD_EXE%"
    copy "%NEW_EXE%" "%OLD_EXE%"
) else (
    echo New executable not found: "%NEW_EXE%"
)

echo Operation complete.
pause
