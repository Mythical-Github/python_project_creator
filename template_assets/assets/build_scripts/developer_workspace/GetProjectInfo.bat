@echo off
setlocal EnableDelayedExpansion

:: Check if both arguments are provided
if "%~1"=="" (
    echo First argument (script itself) is missing.
    exit /b 1
)
if "%~2"=="" (
    echo Second argument (target script) is missing.
    exit /b 1
)

:: Get the directory of the script itself
set "scriptDir=%~dp0"
set "iniFile=%scriptDir%ProjectInfo.ini"

:: Check if ProjectInfo.ini exists
if not exist "%iniFile%" (
    echo ProjectInfo.ini not found in the script directory.
    exit /b 1
)

:: Read the ProjectInfo.ini file
for /f "tokens=1,* delims==" %%A in ('type "%iniFile%"') do (
    set "key=%%A"
    set "value=%%B"

    :: Collect module entries
    if "!key!"=="Modules" (
        set "modules=!modules! !value!"
    ) else (
        set "!key!=!value!"
    )
)

:: Pass collected values to the target script
call "%~2" "%ProjectName%" "%PythonVersion%" %modules%

rem your_script.bat %~f0 target_script.bat

