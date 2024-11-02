@echo off

cd /d %~dp0

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
for /f "delims=" %%A in ('%jq_path% -r ".PythonVersion" "%json_file%"') do set "PythonVersion=%%A"
for /f "delims=" %%A in ('%jq_path% -r ".RepoURL" "%json_file%"') do set "RepoURL=%%A"
for /f "delims=" %%A in ('%jq_path% -r ".RepoBranch" "%json_file%"') do set "RepoBranch=%%A"

set "base_dir=%~dp0%ProjectName%"

call InstallPython.bat
call InstallUV.bat

:: Remove the existing directory if it exists
if not exist "%base_dir%" (
    git clone -b %RepoBranch% %RepoURL%.git "%base_dir%"
)

:: Change to the base directory
cd "%base_dir%"

:: Create and activate the virtual environment, then install requirements, then run the application, then pause
uv venv --python %PythonVersion%
.venv\Scripts\activate && uv pip install -r requirements.txt && %command%
