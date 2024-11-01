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

for /f "delims=" %%A in ('%jq_path% -r ".ProjectName" "%json_file%"') do set "ProjectName=%%A"

set "PyInstallerCMD=pyinstaller"


set i=0
for /f "delims=" %%A in ('%jq_path% -r ".CollectData[]" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD! --collect-data=%%A"
)


set i=0
for /f "delims=" %%A in ('%jq_path% -r ".CollectSubModules[]" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD! --collect-submodules "%%A""
)


set i=0
for /f "delims=" %%A in ('%jq_path% -r ".AdditionalArgs[]" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD! %%A"
)


set "IconArg=--icon="%SCRIPT_DIR%\%ProjectName%\assets\images\icons\project_main_icon.ico""
set "PyInstallerCMD=!PyInstallerCMD! %IconArg%"


set i=0
for /f "delims=" %%A in ('%jq_path% -r ".AddData[]" "%json_file%"') do (
    set /a i+=1
    set "PyInstallerCMD=!PyInstallerCMD!--add-data=%%A;."
)

set "main_py=%SCRIPT_DIR%\%ProjectName%\src\%ProjectName%\__main__.py"
set "PyInstallerCMD=!PyInstallerCMD! "!main_py!""


echo !PyInstallerCMD!
!PyInstallerCMD!

pause

endlocal
