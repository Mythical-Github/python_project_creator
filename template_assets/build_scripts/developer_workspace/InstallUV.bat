@echo off
setlocal

:: Check if 'uv' is already installed
python -c "import uv" 2>NUL

if %ERRORLEVEL% NEQ 0 (
    echo 'uv' package not found, installing...
    pip install uv
) else (
    echo 'uv' package is already installed.
)

endlocal
