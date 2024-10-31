@echo off
setlocal EnableDelayedExpansion

cd %~dp0

set "SCRIPT_DIR=%CD%"

set "json_file=%~dp0ProjectInfo.json"

:: Check if JSON file exists
if not exist "%json_file%" (
    echo ProjectInfo.json file not found. Please ensure data.json is in the same directory.
    exit /b 1
)

call InstallJQ.bat

set "jq_path=%~dp0jq.exe"

:: Parse JSON using jq and set variables
for /f "delims=" %%A in ('%jq_path% -r ".ProjectName" "%json_file%"') do set "ProjectName=%%A"

set "SRC_DIR=%CD%\..\..\src\%ProjectName%"


:: Parse Modules array and store each module in a variable
set i=0
set "PyInstallerCMD=pyinstaller"

for /f "delims=" %%A in ('%jq_path% -r ".AddData[]" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD! --add-data=%%A;."
)

set i=0

for /f "delims=" %%A in ('%jq_path% -r ".CollectData[]" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD! --collect-data=%%A;."
)

set i=0

for /f "delims=" %%A in ('%jq_path% -r ".CollectSubModules[]" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD! --collect-submodules=%%A;."
)

echo !PyInstallerCMD!

set i=0

for /f "delims=" %%A in ('%jq_path% -r ".AdditionalArgs" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD! %%A"
)

set "IconArg=%SCRIPT_DIR%\%ProjectName%\images\icons\project_main_icon.ico"

set "PyInstallerCMD=!PyInstallerCMD! %IconArg%"

echo !PyInstallerCMD!

pause

endlocal
