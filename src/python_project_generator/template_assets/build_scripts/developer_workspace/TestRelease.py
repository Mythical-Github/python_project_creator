@echo off
setlocal

:: Determine the script directory
set "SCRIPT_DIR=%~dp0"

:: Define the assets directory
set "ASSETS_DIR=%SCRIPT_DIR%.."

:: Define the path for the run_default.bat file
set "RUN_BAT_FILE=%ASSETS_DIR%\base\run_default.bat"

:: Check if the run_default.bat file exists
if exist "%RUN_BAT_FILE%" (
    cls
    call "%RUN_BAT_FILE%"
) else (
    echo run_default.bat file not found.
)

endlocal
exit /b
