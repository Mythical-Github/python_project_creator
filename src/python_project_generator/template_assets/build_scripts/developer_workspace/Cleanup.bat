@echo off
:: Set up directories based on script location
setlocal
set "SCRIPT_DIR=%~dp0"
set "BASE_DIR=%SCRIPT_DIR%\..\base"
set "BUILD_SCRIPTS_DIR=%SCRIPT_DIR%"


:: Change to the script directory
cd /d "%SCRIPT_DIR%"


:: Delete 'dist' directory if it exists
if exist "%SCRIPT_DIR%\dist\" (
    rmdir /s /q "%SCRIPT_DIR%\dist"
)


:: Delete 'build' directory if it exists
if exist "%SCRIPT_DIR%\build\" (
    rmdir /s /q "%SCRIPT_DIR%\build"
)


:: Delete '__main__.spec' file if it exists
if exist "%SCRIPT_DIR%\__main__.spec" (
    del /q "%SCRIPT_DIR%\__main__.spec"
)


:: Delete 'UnrealAutoMod' directory in BASE_DIR if it exists
if exist "%BASE_DIR%\UnrealAutoMod\" (
    rmdir /s /q "%BASE_DIR%\UnrealAutoMod"
)


:: Delete 'logs' directory in BASE_DIR if it exists
if exist "%BASE_DIR%\logs\" (
    rmdir /s /q "%BASE_DIR%\logs"
)


endlocal
